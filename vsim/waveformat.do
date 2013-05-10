onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /top_level_tb/clk
add wave -noupdate -format Logic /top_level_tb/reset
add wave -noupdate -format Logic /top_level_tb/fft_enable
add wave -noupdate -format Logic /top_level_tb/to_fft_empty
add wave -noupdate -format Logic /top_level_tb/to_fft_full
add wave -noupdate -format Logic /top_level_tb/from_fft_empty
add wave -noupdate -format Logic /top_level_tb/from_fft_full
add wave -noupdate -format Logic /top_level_tb/dut/router/data_cntl/ram_read
add wave -noupdate -format Logic /top_level_tb/dut/router/data_cntl/ram_write
add wave -noupdate -format Logic /top_level_tb/dut/router/data_cntl/data_to_fft
add wave -noupdate -format Logic /top_level_tb/dut/router/data_cntl/data_from_fft
add wave -noupdate -format Logic /top_level_tb/dut/router/data_cntl/fft_full_flag
add wave -noupdate -format Logic /top_level_tb/fft_put_req
add wave -noupdate -format Logic /top_level_tb/fft_get_req
add wave -noupdate -format Literal -radix hex /top_level_tb/dut/router/data_cntl/data
add wave -noupdate -format Literal -radix hex /top_level_tb/dut/router/data_cntl/fft_data_out
add wave -noupdate -format Logic /top_level_tb/dut/memory/data
add wave -noupdate -format Literal -radix hex /top_level_tb/data_bus
add wave -noupdate -format Literal -radix decimal /top_level_tb/addr
#add wave -noupdate -format Logic /top_level_tb/dut/*
add wave -noupdate -format Logic /top_level_tb/memory/mem(0:32)

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7378 ps} 0}
WaveRestoreZoom {0 ps} {47250 ps}
configure wave -namecolwidth 223
configure wave -valuecolwidth 89
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
