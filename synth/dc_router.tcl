#########################################
# TCL script for Design Compiler        #
# 2012 Mingoo Seok                      #
#########################################

#########################################
# READ Design and Library               #
#########################################
set BEHAVIORROOT "../rtl/"
#set top_level
set top_level dc_router_top
source -verbose "common.tcl"

read_verilog {./rtl/pla_top.v}
read_verilog {./rtl/data_bus_controller.v}
read_verilog {./rtl/addr_calc_top.v}
read_verilog {./rtl/filt_address_calc.v}
read_verilog {./rtl/adder32b.v}
read_verilog {./rtl/filt_filesize_counter.v}
read_verilog {./rtl/dc_router_top.v}

list_designs

#########################################
# Design Constranits                    #
#########################################
current_design $top_level
link
source -verbose "timing.tcl"
#set_driving_cell -lib_cell HS65_GS_IVX2 [all_inputs]
set_max_capacitance 0.001 [all_inputs]
set_max_fanout 4 $top_level
set_max_fanout 2 [all_inputs]
set_max_area 0 

set_fix_multiple_port_nets -all -buffer_constants
#set_dont_use ST65GP_250/HS65_GS_IVX2

#set_ideal_network {resetn}
#set_ideal_network {addr_in}
#set_ideal_network {temp} -no_propagate
#set_ideal_network {data_out} -no_propagate
#set_multicycle_path 2 -from {temp1} -to {out1}
#set_multicycle_path 2 -from {temp2} -to {out2}

#########################################
# Compile for combinational logic       #
#########################################
check_design
#uniquify
compile_ultra
#compile

set maxpaths 20
set rpt_file "${top_level}.dc.rpt1"
check_design > $rpt_file
report_area  >> ${rpt_file}
report_power -hier -analysis_effort medium >> ${rpt_file}
report_design >> ${rpt_file}
report_cell >> ${rpt_file}
report_port -verbose >> ${rpt_file}
report_compile_options >> ${rpt_file}
report_constraint -all_violators -verbose >> ${rpt_file} 
report_timing -path full -delay max -max_paths $maxpaths -nworst 100 >> ${rpt_file}

check_design
#set_transform_for_retiming {temp_reg[6] temp_reg[5] temp_reg[4] temp_reg[3] temp_reg[2] temp_reg[1] temp_reg[0]} dont_retime
#optimize_registers -clock clk -edge rise -justification_effort high 

#balance_registers
#source -verbose "../script/timing.1.2ns.tcl"
#pipeline_design -stages 8 -clock_port_name $clk_name -check_design -verbose -print_critical_loop
#set_max_capacitance 1 [all_inputs] 
#compile_ultra -no_autoungroup -no_boundary_optimization
#remove_clock -all
#source -verbose "../script/timing.1us.tcl"
#pipeline_design -stages 8 -clock_port_name $clk_name -check_design -verbose 
#pipeline_design -stages 8 -clock_port_name $clk_name -async_reset reset -check_design -verbose 
#pipeline_design -stages 8 -clock_port_name $clk_name -async_reset reset -check_design -verbose -minimum_period_only

#########################################
# Write outputs                         #
#########################################
# Rename modules, signals according to the naming rules, tool exchange
#source -verbose "../script/namingrules.tcl"
set verilogout_no_tri TRUE
write -hierarchy -format verilog -output "${top_level}.nl.v"

# Generate Standard Delay Format (SDF) file
write_sdf -context verilog "${top_level}.temp.sdf"
# Generate report file
set maxpaths 20
set rpt_file "${top_level}.dc.rpt"
check_design > $rpt_file
report_area  >> ${rpt_file}
report_power -hier -analysis_effort medium >> ${rpt_file}
report_design >> ${rpt_file}
report_cell >> ${rpt_file}
report_port -verbose >> ${rpt_file}
report_compile_options >> ${rpt_file}
report_constraint -all_violators -verbose >> ${rpt_file}
report_timing -path full -delay max -max_paths $maxpaths -nworst 100 >> ${rpt_file}

