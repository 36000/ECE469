onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /floor_tracker_testbench/clk
add wave -noupdate /floor_tracker_testbench/reset
add wave -noupdate /floor_tracker_testbench/close_doors
add wave -noupdate /floor_tracker_testbench/direction
add wave -noupdate /floor_tracker_testbench/doors_open
add wave -noupdate /floor_tracker_testbench/curr_floor
add wave -noupdate /floor_tracker_testbench/selection
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1901 ps} 0}
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
WaveRestoreZoom {0 ps} {3728 ps}
