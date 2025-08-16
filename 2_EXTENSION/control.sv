module control
(
    input               button_0,
    input               button_1,
    input               clk,
    output  logic [2:0] led
);
    parameter RED = 3'b110, BLUE = 3'b011, GREEN = 3'b101;
    parameter STOP = 0, START = 1;

    logic [2:0] state;
    logic [31:0] counter;

    // Debounce button press
    logic delayed_button_0;
    always @(posedge clk) begin
        delayed_button_0 <= button_0;
    end

    always @ (posedge clk) begin
        if (delayed_button_0 == 0) begin
            state <= STOP;
        end
        if (button_1 == 0) begin
            state   <= START;
            counter <= 31'd6000_0000;
        end else if (state == START) begin
            if (counter < 31'd6000_0000)
                counter <= counter + 1;
            else
                counter <= 31'd0;
        end
    end

    always @ (posedge clk) begin
        case (counter)
            31'd0000_0000 : led <= RED;
            31'd3000_0000 : led <= BLUE;
            31'd6000_0000 : led <= GREEN;
            default: begin end
        endcase
    end

endmodule
