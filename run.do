vlib work
vlog AsyncFIFO.sv
vlog AsyncFIFO_tb.sv

vsim work.AsyncFIFO_tb
add wave -r *
run -all
