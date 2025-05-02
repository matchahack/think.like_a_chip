BOARD=tangnano
FAMILY=GW1N-9C
DEVICE=GW1NR-LV9QN88PC6/I5
TOP=control

yosys -p "read_verilog ${TOP}.v; synth_gowin -json ${TOP}.json"
nextpnr-himbaechel --json ${TOP}.json --write ${TOP}.json --device ${DEVICE} --vopt cst=${BOARD}.cst --vopt family=${FAMILY}
gowin_pack -d ${DEVICE} -o ${TOP}.fs ${TOP}.json
#openFPGALoader -b tangnano1k -f --verbose ${TOP}.fs
#rm *.fs *.json