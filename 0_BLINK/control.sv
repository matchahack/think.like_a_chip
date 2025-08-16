module control
(
    input               button_0,
    input               clk,                    // Clock input signal
    output       [2:0]  led                     // 3-bit LED output
);
    logic [2:0] state = 3'b000;
    assign led = state;

    always @ (posedge clk)
        if (button_0 == 0) state <= state + 1;

endmodule