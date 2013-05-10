onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate -format Logic /top_level_tb/*
add wave -noupdate -format Literal -radix hex /top_level_tb/top_half/acc_fft_data_out
add wave -noupdate -format Logic /top_level_tb/top_half/acc_fft_get
add wave -noupdate -format Literal -radix hex /top_level_tb/top_half/fifo_to_acc/fifo_cell0/register/sr
add wave -noupdate -format Literal -radix hex /top_level_tb/top_half/fifo_to_acc/fifo_cell1/register/sr
add wave -noupdate -format Literal -radix hex /top_level_tb/top_half/fifo_to_acc/fifo_cell2/register/sr
add wave -noupdate -format Literal -radix hex /top_level_tb/top_half/fifo_to_acc/fifo_cell3/register/sr
add wave -noupdate -format Literal -radix hex /top_level_tb/top_half/fifo_to_acc/fifo_cell4/register/sr
add wave -noupdate -format Literal -radix hex /top_level_tb/top_half/fifo_to_acc/fifo_cell5/register/sr
add wave -noupdate -format Literal -radix hex /top_level_tb/top_half/fifo_to_acc/fifo_cell6/register/sr
add wave -noupdate -format Literal -radix hex /top_level_tb/top_half/fifo_to_acc/fifo_cell7/register/sr
add wave -noupdate -format Literal -radix hex /top_level_tb/top_half/fifo_to_acc/fifo_cell8/register/sr
add wave -noupdate -format Literal -radix hex /top_level_tb/top_half/fifo_to_acc/fifo_cell9/register/sr
add wave -noupdate -format Literal -radix hex /top_level_tb/top_half/fifo_to_acc/fifo_cell10/register/sr
add wave -noupdate -format Literal -radix hex /top_level_tb/top_half/fifo_to_acc/fifo_cell11/register/sr
add wave -noupdate -format Literal -radix hex /top_level_tb/top_half/fifo_to_acc/fifo_cell12/register/sr
add wave -noupdate -format Literal -radix hex /top_level_tb/top_half/fifo_to_acc/fifo_cell13/register/sr
add wave -noupdate -format Literal -radix hex /top_level_tb/top_half/fifo_to_acc/fifo_cell14/register/sr
add wave -noupdate -format Literal -radix hex /top_level_tb/top_half/fifo_to_acc/fifo_cell15/register/sr


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
