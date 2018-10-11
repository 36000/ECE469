transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/micha/GitHub/ECE469/lab1 {C:/Users/micha/GitHub/ECE469/lab1/decoder2_4.sv}
vlog -sv -work work +incdir+C:/Users/micha/GitHub/ECE469/lab1 {C:/Users/micha/GitHub/ECE469/lab1/and_3.sv}
vlog -sv -work work +incdir+C:/Users/micha/GitHub/ECE469/lab1 {C:/Users/micha/GitHub/ECE469/lab1/decoder3_8.sv}
vlog -sv -work work +incdir+C:/Users/micha/GitHub/ECE469/lab1 {C:/Users/micha/GitHub/ECE469/lab1/decoder5_32.sv}

