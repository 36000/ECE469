onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /alu_testbench/A
add wave -noupdate /alu_testbench/B
add wave -noupdate /alu_testbench/cntrl
add wave -noupdate /alu_testbench/result
add wave -noupdate /alu_testbench/negative
add wave -noupdate /alu_testbench/zero
add wave -noupdate /alu_testbench/overflow
add wave -noupdate /alu_testbench/carry_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1287736 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 50
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits sec
update
WaveRestoreZoom {0 ps} {42 us}
