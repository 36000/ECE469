# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./or_64.sv"
vlog "./decoder2_4.sv"
vlog "./decoder3_8.sv"
vlog "./fulladder_1.sv"
vlog "./fulladdsub_1.sv"
vlog "./mux8_1.sv"
vlog "./mux4_1.sv"
vlog "./mux2_1.sv"
vlog "./ALU_1.sv"
vlog "./alu.sv"
vlog "./and_3.sv"
vlog "./controlblock.sv"
vlog "./CPU_singlecycle64.sv"
vlog "./D_FF.sv"
vlog "./datamem.sv"
vlog "./decoder5_32.sv"
vlog "./flagfile.sv"
vlog "./instructmem.sv"
vlog "./LSL_2.sv"
vlog "./math.sv"
vlog "./mux32_1.sv"
vlog "./mux64x2_1.sv"
vlog "./mux5x2_1.sv"
vlog "./mux64x32_64.sv"
vlog "./regfile.sv"
vlog "./register_1.sv"
vlog "./register_64.sv"
vlog "./SE_64.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work CPU_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do cpu_testbench_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
