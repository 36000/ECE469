# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./input_blink.sv"
vlog "./DE1_SoC.sv"
vlog "./myDFF.sv"
vlog "./buttons_controller.sv"
vlog "./floor_tracker.sv"
vlog "./myDFF_6b.sv"


# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work DE1_SoC_testbench
#vsim -voptargs="+acc" -t 1ps -lib work LFSR_10bit_testbench
#vsim -voptargs="+acc" -t 1ps -lib work score_counter_testbench
#vsim -voptargs="+acc" -t 1ps -lib work comparator_10bit_testbench
#vsim -voptargs="+acc" -t 1ps -lib work buttons_controller_testbench
#vsim -voptargs="+acc" -t 1ps -lib work floor_tracker_testbench


# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
#do LFSR_10bit_wave.do 
do DE1_SoC_wave.do 	
#do score_counter_wave.do 	
#do comparator_10bit_wave.do 	
#do buttons_controller_wave.do
#do floor_tracker_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
