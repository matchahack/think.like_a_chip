`include "debounce.sv"
`include "reset.sv"

module red_blink_led (
    input  wire         clk,
    input  wire         button_0,
    input  wire         button_1,
    input  wire [7:0]   password_input,
    output logic [2:0]  led
);
    // === Constant definitions === //
    localparam [9:0] SECRET_PASSWORD = 11'b0001000000;
    localparam integer BLINK_PERIOD = 24_000_000;  // ~250ms @ 24MHz
    localparam [2:0] RED = 3'b110;
    localparam [2:0] OFF = 3'b111;

    // === FSM === // 
    typedef enum logic [2:0] { USER_INPUT, COMPARING, SUCCESS, FAIL } state_t;

    // === Registers === //
    logic [25:0] blink_counter;
    logic [9:0] curr_index;
    integer check_index;
    logic [2:0] device_state;
    logic led_state;
    logic bit_pressed, bit_pressed_last;

    // Debounced button modules
    logic clean_button_0, clean_button_1;
    debounce db0 (.clk(clk), .button_in(button_0), .pressed_pulse(clean_button_0));
    debounce db1 (.clk(clk), .button_in(button_1), .pressed_pulse(clean_button_1));
    
    // reset signal module
    logic rst;
    reset rst0(.clk(clk), .clean_button_0(clean_button_0), .rst(rst));

    // === Behavioral Logic === //
    always_ff @(posedge clk) begin
        if (rst) begin
            blink_counter     <= 0;
            bit_pressed       <= 0;
            check_index       <= 0;
            led_state         <= 0;
            curr_index        <= 0;
            led               <= OFF;
            device_state      <= USER_INPUT;
        end else begin
            case (device_state)
                USER_INPUT:begin
                    if (clean_button_1) begin
                        device_state <= COMPARING;
                        bit_pressed   <= 0;
                    end
                    led_state    <= OFF;
                end
                
                COMPARING: begin
                    led <= (led_state ? RED : OFF);
                    bit_pressed_last <= bit_pressed && !SECRET_PASSWORD[curr_index];
                    if (blink_counter >= BLINK_PERIOD) begin
                        blink_counter <= 0;
                        led_state     <= ~led_state;
                        if (bit_pressed && SECRET_PASSWORD[curr_index] && bit_pressed_last) begin
                            device_state <= SUCCESS;
                        end
                        else begin
                            curr_index <= curr_index + 1;
                            bit_pressed   <= 0;
                        end
                    end else begin
                        blink_counter <= blink_counter + 1;
                        if(clean_button_1) bit_pressed <= 1;
                    end
                end

                SUCCESS: begin
                    blink_counter <= blink_counter + 1;
                    case (blink_counter)
                        0           : led <= 3'b110; // RED
                        24_000_000  : led <= 3'b011; // BLUE
                        48_000_000  : led <= 3'b101; // GREEN
                        default     : begin end
                    endcase
                end
                
                FAIL:begin
                    led_state <= RED;
                end
            endcase
        end
    end

endmodule
