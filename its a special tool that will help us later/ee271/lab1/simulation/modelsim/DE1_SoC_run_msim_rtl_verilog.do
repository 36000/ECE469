transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/micha/GitHub/ECE469/its\ a\ special\ tool\ that\ will\ help\ us\ later/ee271/lab1 {C:/Users/micha/GitHub/ECE469/its a special tool that will help us later/ee271/lab1/mux2_1.sv}

