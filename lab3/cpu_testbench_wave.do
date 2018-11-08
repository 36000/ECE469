onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /CPU_testbench/dut/reset
add wave -noupdate /CPU_testbench/dut/clk
add wave -noupdate -radix hexadecimal /CPU_testbench/dut/PC
add wave -noupdate -radix binary /CPU_testbench/dut/instr
add wave -noupdate -childformat {{{/CPU_testbench/dut/register_file/reg_outputs[31]} -radix decimal} {{/CPU_testbench/dut/register_file/reg_outputs[30]} -radix decimal} {{/CPU_testbench/dut/register_file/reg_outputs[29]} -radix decimal} {{/CPU_testbench/dut/register_file/reg_outputs[28]} -radix decimal} {{/CPU_testbench/dut/register_file/reg_outputs[27]} -radix decimal} {{/CPU_testbench/dut/register_file/reg_outputs[26]} -radix decimal} {{/CPU_testbench/dut/register_file/reg_outputs[25]} -radix decimal} {{/CPU_testbench/dut/register_file/reg_outputs[24]} -radix decimal} {{/CPU_testbench/dut/register_file/reg_outputs[23]} -radix decimal} {{/CPU_testbench/dut/register_file/reg_outputs[22]} -radix decimal} {{/CPU_testbench/dut/register_file/reg_outputs[21]} -radix decimal} {{/CPU_testbench/dut/register_file/reg_outputs[20]} -radix decimal} {{/CPU_testbench/dut/register_file/reg_outputs[19]} -radix decimal} {{/CPU_testbench/dut/register_file/reg_outputs[18]} -radix decimal} {{/CPU_testbench/dut/register_file/reg_outputs[17]} -radix decimal} {{/CPU_testbench/dut/register_file/reg_outputs[16]} -radix decimal} {{/CPU_testbench/dut/register_file/reg_outputs[15]} -radix decimal} {{/CPU_testbench/dut/register_file/reg_outputs[14]} -radix decimal} {{/CPU_testbench/dut/register_file/reg_outputs[13]} -radix decimal} {{/CPU_testbench/dut/register_file/reg_outputs[12]} -radix decimal} {{/CPU_testbench/dut/register_file/reg_outputs[11]} -radix decimal} {{/CPU_testbench/dut/register_file/reg_outputs[10]} -radix decimal} {{/CPU_testbench/dut/register_file/reg_outputs[9]} -radix decimal} {{/CPU_testbench/dut/register_file/reg_outputs[8]} -radix decimal} {{/CPU_testbench/dut/register_file/reg_outputs[7]} -radix decimal} {{/CPU_testbench/dut/register_file/reg_outputs[6]} -radix decimal} {{/CPU_testbench/dut/register_file/reg_outputs[5]} -radix decimal} {{/CPU_testbench/dut/register_file/reg_outputs[4]} -radix decimal} {{/CPU_testbench/dut/register_file/reg_outputs[3]} -radix decimal} {{/CPU_testbench/dut/register_file/reg_outputs[2]} -radix decimal} {{/CPU_testbench/dut/register_file/reg_outputs[1]} -radix decimal} {{/CPU_testbench/dut/register_file/reg_outputs[0]} -radix decimal}} -subitemconfig {{/CPU_testbench/dut/register_file/reg_outputs[31]} {-height 15 -radix decimal} {/CPU_testbench/dut/register_file/reg_outputs[30]} {-height 15 -radix decimal} {/CPU_testbench/dut/register_file/reg_outputs[29]} {-height 15 -radix decimal} {/CPU_testbench/dut/register_file/reg_outputs[28]} {-height 15 -radix decimal} {/CPU_testbench/dut/register_file/reg_outputs[27]} {-height 15 -radix decimal} {/CPU_testbench/dut/register_file/reg_outputs[26]} {-height 15 -radix decimal} {/CPU_testbench/dut/register_file/reg_outputs[25]} {-height 15 -radix decimal} {/CPU_testbench/dut/register_file/reg_outputs[24]} {-height 15 -radix decimal} {/CPU_testbench/dut/register_file/reg_outputs[23]} {-height 15 -radix decimal} {/CPU_testbench/dut/register_file/reg_outputs[22]} {-height 15 -radix decimal} {/CPU_testbench/dut/register_file/reg_outputs[21]} {-height 15 -radix decimal} {/CPU_testbench/dut/register_file/reg_outputs[20]} {-height 15 -radix decimal} {/CPU_testbench/dut/register_file/reg_outputs[19]} {-height 15 -radix decimal} {/CPU_testbench/dut/register_file/reg_outputs[18]} {-height 15 -radix decimal} {/CPU_testbench/dut/register_file/reg_outputs[17]} {-height 15 -radix decimal} {/CPU_testbench/dut/register_file/reg_outputs[16]} {-height 15 -radix decimal} {/CPU_testbench/dut/register_file/reg_outputs[15]} {-height 15 -radix decimal} {/CPU_testbench/dut/register_file/reg_outputs[14]} {-height 15 -radix decimal} {/CPU_testbench/dut/register_file/reg_outputs[13]} {-height 15 -radix decimal} {/CPU_testbench/dut/register_file/reg_outputs[12]} {-height 15 -radix decimal} {/CPU_testbench/dut/register_file/reg_outputs[11]} {-height 15 -radix decimal} {/CPU_testbench/dut/register_file/reg_outputs[10]} {-height 15 -radix decimal} {/CPU_testbench/dut/register_file/reg_outputs[9]} {-height 15 -radix decimal} {/CPU_testbench/dut/register_file/reg_outputs[8]} {-height 15 -radix decimal} {/CPU_testbench/dut/register_file/reg_outputs[7]} {-height 15 -radix decimal} {/CPU_testbench/dut/register_file/reg_outputs[6]} {-height 15 -radix decimal} {/CPU_testbench/dut/register_file/reg_outputs[5]} {-height 15 -radix decimal} {/CPU_testbench/dut/register_file/reg_outputs[4]} {-height 15 -radix decimal} {/CPU_testbench/dut/register_file/reg_outputs[3]} {-height 15 -radix decimal} {/CPU_testbench/dut/register_file/reg_outputs[2]} {-height 15 -radix decimal} {/CPU_testbench/dut/register_file/reg_outputs[1]} {-height 15 -radix decimal} {/CPU_testbench/dut/register_file/reg_outputs[0]} {-height 15 -radix decimal}} /CPU_testbench/dut/register_file/reg_outputs
add wave -noupdate /CPU_testbench/dut/negative
add wave -noupdate /CPU_testbench/dut/zero
add wave -noupdate /CPU_testbench/dut/overflow
add wave -noupdate /CPU_testbench/dut/carry_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {536035518 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 264
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {1437500 ps} {605187500 ps}
