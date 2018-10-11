transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+U:/ECE469/lab1 {U:/ECE469/lab1/mux4_1.sv}
vlog -sv -work work +incdir+U:/ECE469/lab1 {U:/ECE469/lab1/mux32_1.sv}
vlog -sv -work work +incdir+U:/ECE469/lab1 {U:/ECE469/lab1/mux2_1.sv}

vlog -sv -work work +incdir+U:/ECE469/lab1 {U:/ECE469/lab1/mux32_1.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  mux32_1_testbench

add wave *
view structure
view signals
run -all
