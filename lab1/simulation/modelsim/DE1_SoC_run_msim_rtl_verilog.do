transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/micha/GitHub/ECE469/lab1 {C:/Users/micha/GitHub/ECE469/lab1/register_64.sv}
vlog -sv -work work +incdir+C:/Users/micha/GitHub/ECE469/lab1 {C:/Users/micha/GitHub/ECE469/lab1/register_1.sv}
vlog -sv -work work +incdir+C:/Users/micha/GitHub/ECE469/lab1 {C:/Users/micha/GitHub/ECE469/lab1/regfile.sv}
vlog -sv -work work +incdir+C:/Users/micha/GitHub/ECE469/lab1 {C:/Users/micha/GitHub/ECE469/lab1/mux64x32_64.sv}
vlog -sv -work work +incdir+C:/Users/micha/GitHub/ECE469/lab1 {C:/Users/micha/GitHub/ECE469/lab1/mux4_1.sv}
vlog -sv -work work +incdir+C:/Users/micha/GitHub/ECE469/lab1 {C:/Users/micha/GitHub/ECE469/lab1/mux32_1.sv}
vlog -sv -work work +incdir+C:/Users/micha/GitHub/ECE469/lab1 {C:/Users/micha/GitHub/ECE469/lab1/D_FF.sv}
vlog -sv -work work +incdir+C:/Users/micha/GitHub/ECE469/lab1 {C:/Users/micha/GitHub/ECE469/lab1/decoder5_32.sv}
vlog -sv -work work +incdir+C:/Users/micha/GitHub/ECE469/lab1 {C:/Users/micha/GitHub/ECE469/lab1/decoder3_8.sv}
vlog -sv -work work +incdir+C:/Users/micha/GitHub/ECE469/lab1 {C:/Users/micha/GitHub/ECE469/lab1/decoder2_4.sv}
vlog -sv -work work +incdir+C:/Users/micha/GitHub/ECE469/lab1 {C:/Users/micha/GitHub/ECE469/lab1/and_3.sv}
vlog -sv -work work +incdir+C:/Users/micha/GitHub/ECE469/lab1 {C:/Users/micha/GitHub/ECE469/lab1/mux2_1.sv}

