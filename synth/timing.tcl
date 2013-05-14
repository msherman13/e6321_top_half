# Timing setup for synthesis

# Setting variables 
set clk_period 50
set clk_uncertainty 1
set clk_transition 3
set typical_input_delay 0
set typical_output_delay 1
set typical_wire_load 0.001

#Create real clock if clock port is found
if {[sizeof_collection [get_ports clk]] > 0} {
  set clk_name "clk"
  set clk_port "clk"
  #If no waveform is specified, 50% duty cycle is assumed
  create_clock -name $clk_name -period $clk_period [get_ports $clk_port] 
  set_drive 0 [get_clocks $clk_name] 
}

#Set clock uncertainty
set_clock_uncertainty $clk_uncertainty [get_clocks $clk_name]
#Propagated clock used for gated clocks only
set_clock_transition $clk_transition [get_clocks $clk_name]

# set_operating_conditions "typical" -library "typical" 
# set_wire_load_model -name "ibm13_wl10" -library "typical" 
#set_wire_load_mode "segmented" 

# Set maximum fanout of gates, reduced b/c smaller on-off ratio
#set_max_fanout 8 $top_level

# Configure the clock network
#set_fix_hold [all_clocks] 
set_dont_touch_network $clk_port 
# gkc
#set_ideal_network      reset

# Set delays: Input, Output
#set_driving_cell -lib_cell HS65_GS_IVX9 [all_inputs]
set_input_delay $typical_input_delay [all_inputs] -clock $clk_name 
remove_input_delay -clock $clk_name [find port $clk_port]

#gkc
set_output_delay $typical_output_delay [all_outputs] -clock $clk_name 

# Set loading of outputs 
set_load $typical_wire_load [all_outputs]
