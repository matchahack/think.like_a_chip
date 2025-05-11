module control
(
    input           clk,
    input           button_0,
    input           button_1,
    output  [2:0]   led
);
    reg [2:0] traffic_lights, reset, pedestrian_button;
    assign button_0=pedestrian_button, button_1=reset, led=traffic_lights; 

    parameter   WAIT        = 0110,
                RED         = 0000,
                ORANGE_STOP = 0100,
                ORANGE_GO   = 0010,
                GREEN       = 1000;

    reg [2:0] traffic_lights_state;
    reg [2:0] next_state, current_state;
    reg [15:0] wait_time;

    always @ (posedge clk) begin // manage traffic lights state
        if (reset == 0) begin
            traffic_lights_state    <= RED;
            next_state              <= RED;
            wait_time               <= 0;
        end
        else begin
            if (pedestrian_button == 0 && traffic_lights_state == GREEN) begin
                // wait 30 seconds
                wait_time               <= 16'd30;
                current_state           <= GREEN;
                traffic_lights_state    <= WAIT;
            end
            case (traffic_lights_state)
                ORANGE_STOP: begin
                    // wait 20 seconds to warn the drivers to get ready to stop
                    wait_time               <= 16'd20;
                    current_state           <= ORANGE_STOP;
                    next_state              <= RED;
                    traffic_lights_state    <= WAIT;
                end
                RED: begin
                    // wait 45 seconds to let people cross the road
                    wait_time               <= 16'd45;
                    current_state           <= RED;
                    next_state              <= ORANGE_GO;
                    traffic_lights_state    <= WAIT;
                end
                ORANGE_GO: begin
                    // wait 20 seconds to warn the drivers to get ready to go
                    wait_time               <= 16'd20;
                    current_state           <= ORANGE_GO;
                    next_state              <= GREEN;
                    traffic_lights_state    <= WAIT;
                end
                WAIT: begin
                    wait_time    <= wait_time - 1;
                    if (wait_time == 0) begin
                        traffic_lights_state <= next_state;
                    end
                end
            endcase
        end
    end

    always @ (posedge clk) begin // drive the LED's
        if (reset == 0) begin
            traffic_lights <= RED;
        end else begin
            case (traffic_lights_state)
                WAIT:           traffic_lights <= current_state;
                RED:            traffic_lights <= 3'b001;
                ORANGE_GO:      traffic_lights <= 3'b010;
                ORANGE_STOP:    traffic_lights <= 3'b010;
                GREEN:          traffic_lights <= 3'b100;
            endcase
        end
    end
endmodule