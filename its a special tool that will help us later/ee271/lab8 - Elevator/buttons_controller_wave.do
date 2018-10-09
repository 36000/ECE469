onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /buttons_controller_testbench/clk
add wave -noupdate /buttons_controller_testbench/reset
add wave -noupdate /buttons_controller_testbench/curr_floor
add wave -noupdate /buttons_controller_testbench/selection
add wave -noupdate /buttons_controller_testbench/SW
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits sec
update
WaveRestoreZoom {0 ps} {1 ns}
