module control
(
    input               button_0,
    input               button_1,
    input               clk,                    // Clock input signal
    output  logic [2:0] led                     // 3-bit LED output
);
    parameter STOP=0, START=1;
    logic state;

    logic [31:0] counter;                       // 32-bit counter register

    initial begin
        state   <= STOP;
        counter <= 31'd0;                       // Initialize counter to 0
        led     <= 3'b110;                      // Initialize LED pattern
    end

    always @(posedge clk) begin
        if (button_0 == 0) state <= STOP;
        if (button_1 == 0) state <= START;
        if (state == START) begin
            if (counter < 31'd1350_0000)        // Check if counter is less than 135 million (for 0.5s delay)
                counter <= counter + 1;         // Increment counter
            else begin
                counter <= 31'd0;               // Reset counter
                led[2:0] <= {led[1:0],led[2]};  // Rotate LED pattern left
            end
        end
    end

endmodule