./clear.sh
iverilog -o control_tb control_tb.v control.v
vvp control_tb
gtkwave control_tb.vcd