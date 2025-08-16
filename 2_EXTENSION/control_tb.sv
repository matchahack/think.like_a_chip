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

    // TEST SIGNALS
    logic clk, button_0, button_1;
    wire [2:0] led;

    // CLOCK
    always #(DELAY_5) clk = ~clk;

    // STIMULUS
    initial begin
        clk       <= 0;
        button_0  <= 1;
        button_1  <= 1;

        // Wait a bit after reset
        #(DELAY_10);
        repeat (5) #(DELAY_10);

        // Normal START button press
        button_1 <= 0;
        #(DELAY_10);
        button_1 <= 1;

        // Let the system run a bit
        repeat (20) #(DELAY_10);

        // Introduce bug scenario:
        // Press WAIT (button_0), then very quickly press START (button_1)
        button_0 <= 0;
        #(DELAY_10);  // This delay is key: likely to land on edge cases
        button_1 <= 0;
        #(DELAY_10);
        button_0 <= 1;
        #(DELAY_10);
        button_1 <= 1;

        // Observe for a while
        repeat (50) #(DELAY_10);
    end

    // DUT INSTANTIATION
    control control_uut(
        .clk(clk),
        .button_0(button_0),
        .button_1(button_1),
        .led(led)
    );

endmodule
