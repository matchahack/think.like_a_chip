module reset(
    input clk,
    input clean_button_0,
    output rst
);
    logic [1:0] reset_press_count;
    logic reset_pulse;

    always_ff @(posedge clk) begin
        if (clean_button_0) begin
            if (reset_press_count == 2) begin
                reset_press_count <= 0;
                reset_pulse <= 1;
            end else begin
                reset_press_count <= reset_press_count + 1;
                reset_pulse <= 0;
            end
        end else begin
            reset_pulse <= 0;
        end
    end
    assign rst = reset_pulse;
endmodule