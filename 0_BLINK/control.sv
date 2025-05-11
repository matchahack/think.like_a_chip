module control
(
    input           clk,
    input           button_0,
    input           button_1,
    output  [2:0]   led
);

    localparam WAIT_TIME = 13500000;

    reg [2:0]   ledCounter      = 0;
    reg [23:0]  clockCounter    = 0;
    reg         start           = 0;

    always @(posedge clk) begin
        if (button_0 == 0) start <= 1;
        if (button_1 == 0) start <= 0;
        if (start == 1) begin
            clockCounter <= clockCounter + 1;
            if (clockCounter == WAIT_TIME) begin
                clockCounter <= 0;
                ledCounter <= ledCounter + 1;
            end
        end
    end

    assign led = ~ledCounter;
endmodule