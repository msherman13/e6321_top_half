onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate -format Logic /top_level_tb/*
add wave -noupdate -format Literal -radix hex /top_level_tb/top_half/acc_fft_data_out
add wave -noupdate -format Logic /top_level_tb/top_half/acc_fft_get

add wave -noupdate -format Literal -radix hex /top_level_tb/top_half/instruction

#add wave -noupdate -format Literal -radix hex /top_level_tb/top_half/router/data_to_fft
#add wave -noupdate -format Literal -radix hex /top_level_tb/top_half/acc_fft_data_out

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
