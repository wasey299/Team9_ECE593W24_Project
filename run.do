vlib work
vlog fifo_if.sv
vlog top.sv

vsim work.top
add wave -r *
run -all
