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
vlog -incr /tools2/courses/ee6321/share/ibm13rflpvt/verilog/ibm13rflpvt.v
vlog -incr dc_router_top_tb.v
vlog -incr dc_router_top.nophycell.v

# Run Simulator 
#vsim 
vsim -t ps -lib work dc_router_top_tb -sdftyp /dc_router_top/=apr.sdf
do waveformat.do   
run -all
#while {[exa testend_s] == "false"} {run 0.20 ms}
#quit -sim
