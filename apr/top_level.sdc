#/**************************************************
# * Timing constraint file in SDC format
# **************************************************/
#set sdc_version 1.4

#Create clock and set delays
 set clk_name "clk"
 set clk_period 50
 set clk_uncertainty 0
 set clk_transition 0
 set clk_latency 1
 set typical_input_delay 1
 set typical_output_delay 1
 set typical_wire_load 0.001
 set output_load 0.060

 set_max_fanout 4 [current_design]
 set_max_fanout 4 [all_inputs]
 set_max_capacitance 0.001 [all_inputs]
 #set_max_transition 0.100 [current_design]

 create_clock [get_ports $clk_name] -name clk -period $clk_period

 set_clock_uncertainty $clk_uncertainty [get_clocks $clk_name]
 set_clock_transition $clk_transition [get_clocks $clk_name]
 set_clock_latency $clk_latency [get_clocks $clk_name]

 set_input_delay $typical_input_delay [all_inputs] -clock $clk_name
 #remove_input_delay -clock $clk_name [find port $clk_name]
 set_output_delay $typical_output_delay [all_outputs] -clock $clk_name
 set_load $output_load [all_outputs]

#set false path
 #set_false_path -from reset
 set_false_path -from vdds
 set_false_path -from gnds
 #set_false_path -from data_valid_in
 #set_false_path -from coef_*
