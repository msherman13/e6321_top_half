#-----------------------------------------------------------------------------#
#                                                                             #
#                         M A C R O    F I L E                                #
#                          COPYRIGHT (C) 2006                                 #
#                                                                             #
#-----------------------------------------------------------------------------#
#-
#- Title       : RUNSIM.DO
#- Design      : MDCT Core
#- Author      : Mingoo Seok 
#-
#-----------------------------------------------------------------------------
#-
#- File        : RUNSIM.DO
#- Created     : Sat Mar 5 2006
#-
#-----------------------------------------------------------------------------
#-
#-  Description : ModelSim macro for running simulation
#-
#-----------------------------------------------------------------------------

vlib work 
vmap work work

# Include Netlist and Testbench
#vlog -incr /tools2/courses/ee6321/share/ibm13rflpvt/verilog/ibm13rflpvt.v
vlog -incr controller.v 
vlog -incr datapath.v
vlog -incr acc.v
vlog -incr hazard.v
vlog -incr mem.v
vlog -incr mipspipelined.v
vlog -incr mipstop.v
vlog -incr parts.v
vlog -incr adder32b.v
vlog -incr addr_calc_top.v
vlog -incr data_bus_controller.v
vlog -incr datapath.v
vlog -incr dc_router_top.v
vlog -incr filt_address_calc.v
vlog -incr filt_filesize_counter.v
vlog -incr pla_top.v
vlog -incr ram.v
vlog -incr top_level.v
vlog -incr top_level_tb.v

# Run Simulator 
vsim -t ps -lib work top_level_tb
do waveformat.do   
run -all
#while {[exa testend_s] == "false"} {run 0.20 ms}
#quit -sim	 
