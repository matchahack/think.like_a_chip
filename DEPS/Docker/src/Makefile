BOARD=tangnano
FAMILY=GW1NZ-1
DEVICE=GW1NZ-LV1QN48C6/I5
TOP=control

build:
	yosys -p "read_verilog -sv ${TOP}.sv; synth_gowin -json ${TOP}.json"
	nextpnr-himbaechel --json ${TOP}.json --write ${TOP}.json --device ${DEVICE} --vopt cst=${BOARD}.cst --vopt family=${FAMILY}
	gowin_pack -d ${DEVICE} -o ${TOP}.fs ${TOP}.json
	mv *.fs *.json bin/

clean:
	rm bin/*