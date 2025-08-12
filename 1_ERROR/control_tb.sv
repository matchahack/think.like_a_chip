module control_tb;

    // CONFIG
    parameter DURATION=2000, DELAY_5=5,
                    DELAY_10=10;

    // GENERATE SIM
    initial begin
        $dumpfile("control_tb.vcd");    
        $dumpvars(0, control_tb);       
        #(DURATION);                  
        $finish;                       
    end

    // TEST
    logic clk, button_0, button_1;
    wire [2:0] led;

    always #(DELAY_5) clk = ~clk;

    initial begin
        clk      <= 0;
        button_0 <= 1;
        button_1 <= 1;
        #(DELAY_10);
        repeat (100) #(DELAY_10);
        button_1 <= 0;
        repeat (5) #(DELAY_10);
        button_1 <= 1;
        repeat (5) #(DELAY_10);
        button_0 <= 0;
        repeat (5) #(DELAY_10);
        button_0 <= 1;
    end

    control control_uut(
        .clk(clk),
        .button_0(button_0),
        .button_1(button_1),
        .led(led)
    );

endmodule