module debounce 
#(
    parameter DEBOUNCE_CYCLES = 20_000  // Adjust based on clk frequency
)
(
    input  logic clk,            // clock
    input  logic button_in,      // raw button input (active low)
    output logic pressed_pulse   // 1-cycle pulse when button is pressed
);

    // 1. Synchronize input
    logic sync_0, sync_1;
    always_ff @(posedge clk) begin
        sync_0 <= button_in;
        sync_1 <= sync_0;
    end

    // 2. Debounce filter
    logic [$clog2(DEBOUNCE_CYCLES)-1:0] counter = 0;
    logic button_stable = 1'b1; // assume released at start

    always_ff @(posedge clk) begin
        if (sync_1 == button_stable) begin
            counter <= 0;
        end else begin
            counter <= counter + 1;
            if (counter == DEBOUNCE_CYCLES-1) begin
                button_stable <= sync_1;
                counter <= 0;
            end
        end
    end

    // 3. Detect falling edge (button press, active-low)
    logic button_prev;
    always_ff @(posedge clk) begin
        button_prev <= button_stable;
    end

    assign pressed_pulse = (button_prev == 1'b1) && (button_stable == 1'b0);

endmodule
