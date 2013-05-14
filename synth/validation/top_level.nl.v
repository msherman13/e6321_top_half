
module top_level ( clk, reset, acc_fft_data_out, acc_fft_data_in, 
        acc_fir_data_out, acc_fir_data_in, fft_enable, fir_enable, 
        to_fft_empty, from_fft_full, to_fir_empty, from_fir_full, acc_fft_get, 
        acc_fft_put, acc_fir_get, acc_fir_put, ram_read_enable, 
        ram_write_enable, addr, data_bus );
  input [31:0] acc_fft_data_out;
  input [31:0] acc_fft_data_in;
  input [31:0] acc_fir_data_out;
  input [31:0] acc_fir_data_in;
  output [31:0] addr;
  inout [31:0] data_bus;
  input clk, reset;
  output fft_enable, fir_enable, to_fft_empty, from_fft_full, to_fir_empty,
         from_fir_full, acc_fft_get, acc_fft_put, acc_fir_get, acc_fir_put,
         ram_read_enable, ram_write_enable;
  wire   n7918, n7919, acc_done, acc_bypass, from_fft_empty, from_fir_empty,
         iir_enable, \fifo_to_fft/hang[14] , \fifo_to_fft/hang[13] ,
         \fifo_to_fft/hang[12] , \fifo_to_fft/hang[11] ,
         \fifo_to_fft/hang[10] , \fifo_to_fft/hang[9] , \fifo_to_fft/hang[8] ,
         \fifo_to_fft/hang[7] , \fifo_to_fft/hang[6] , \fifo_to_fft/hang[5] ,
         \fifo_to_fft/hang[4] , \fifo_to_fft/hang[3] , \fifo_to_fft/hang[2] ,
         \fifo_to_fft/hang[1] , \fifo_to_fft/hang[0] ,
         \fifo_to_fft/tok_xnor_put , \fifo_from_fft/hold[15] ,
         \fifo_from_fft/hold[14] , \fifo_from_fft/hold[13] ,
         \fifo_from_fft/hold[12] , \fifo_from_fft/hold[11] ,
         \fifo_from_fft/hold[10] , \fifo_from_fft/hold[9] ,
         \fifo_from_fft/hold[8] , \fifo_from_fft/hold[7] ,
         \fifo_from_fft/hold[6] , \fifo_from_fft/hold[5] ,
         \fifo_from_fft/hold[4] , \fifo_from_fft/hold[3] ,
         \fifo_from_fft/hold[2] , \fifo_from_fft/hold[1] ,
         \fifo_from_fft/hold[0] , \fifo_to_fir/hang[14] ,
         \fifo_to_fir/hang[13] , \fifo_to_fir/hang[12] ,
         \fifo_to_fir/hang[11] , \fifo_to_fir/hang[10] , \fifo_to_fir/hang[9] ,
         \fifo_to_fir/hang[8] , \fifo_to_fir/hang[7] , \fifo_to_fir/hang[6] ,
         \fifo_to_fir/hang[5] , \fifo_to_fir/hang[4] , \fifo_to_fir/hang[3] ,
         \fifo_to_fir/hang[2] , \fifo_to_fir/hang[1] , \fifo_to_fir/hang[0] ,
         \fifo_to_fir/tok_xnor_put , \fifo_from_fir/hold[15] ,
         \fifo_from_fir/hold[14] , \fifo_from_fir/hold[13] ,
         \fifo_from_fir/hold[12] , \fifo_from_fir/hold[11] ,
         \fifo_from_fir/hold[10] , \fifo_from_fir/hold[9] ,
         \fifo_from_fir/hold[8] , \fifo_from_fir/hold[7] ,
         \fifo_from_fir/hold[6] , \fifo_from_fir/hold[5] ,
         \fifo_from_fir/hold[4] , \fifo_from_fir/hold[3] ,
         \fifo_from_fir/hold[2] , \fifo_from_fir/hold[1] ,
         \fifo_from_fir/hold[0] , \router/ram_write_enable_reg ,
         \router/ram_read_enable_reg , \router/iir_get_req_reg ,
         \router/fir_get_req_reg , \router/fir_put_req_reg ,
         \router/fft_get_req_reg , \router/fft_put_req_reg ,
         \router/iir_write_done , \router/iir_read_done ,
         \router/fir_write_done , \router/fir_read_done ,
         \router/fft_write_done , \router/fft_read_done ,
         \router/data_from_fir , \router/data_from_fft , \router/data_to_fft ,
         \mips/mips/accfullinstruction[31] ,
         \mips/mips/accfullinstruction[30] ,
         \mips/mips/accfullinstruction[29] ,
         \mips/mips/accfullinstruction[28] ,
         \mips/mips/accfullinstruction[27] ,
         \mips/mips/accfullinstruction[26] ,
         \mips/mips/accfullinstruction[25] ,
         \mips/mips/accfullinstruction[24] ,
         \mips/mips/accfullinstruction[23] ,
         \mips/mips/accfullinstruction[22] ,
         \mips/mips/accfullinstruction[21] ,
         \mips/mips/accfullinstruction[20] ,
         \mips/mips/accfullinstruction[19] ,
         \mips/mips/accfullinstruction[18] ,
         \mips/mips/accfullinstruction[17] ,
         \mips/mips/accfullinstruction[16] ,
         \mips/mips/accfullinstruction[15] ,
         \mips/mips/accfullinstruction[14] ,
         \mips/mips/accfullinstruction[13] ,
         \mips/mips/accfullinstruction[12] ,
         \mips/mips/accfullinstruction[11] ,
         \mips/mips/accfullinstruction[10] , \mips/mips/accfullinstruction[9] ,
         \mips/mips/accfullinstruction[8] , \mips/mips/accfullinstruction[7] ,
         \mips/mips/accfullinstruction[6] , \mips/mips/accfullinstruction[5] ,
         \mips/mips/accfullinstruction[4] , \mips/mips/accfullinstruction[3] ,
         \mips/mips/accfullinstruction[2] , \mips/mips/accfullinstruction[1] ,
         \mips/mips/accfullinstruction[0] , \mips/mips/accbypass ,
         \fifo_to_fft/empty_det/N4 , \fifo_from_fft/fifo_cell14/N7 ,
         \fifo_from_fft/fifo_cell14/control_signal ,
         \fifo_from_fft/fifo_cell15/N7 , \fifo_to_fir/empty_det/N4 ,
         \fifo_from_fir/fifo_cell14/N7 ,
         \fifo_from_fir/fifo_cell14/control_signal ,
         \fifo_from_fir/fifo_cell15/N7 , \router/pla_top/N60 ,
         \router/pla_top/instruction_valid ,
         \router/addr_calc/iir_write_addr[27] ,
         \router/addr_calc/iir_write_addr[23] ,
         \router/addr_calc/iir_write_addr[18] ,
         \router/addr_calc/iir_write_addr[14] ,
         \router/addr_calc/iir_write_addr[9] ,
         \router/addr_calc/iir_write_addr[5] ,
         \router/addr_calc/iir_write_addr[0] ,
         \router/addr_calc/fir_write_addr[30] ,
         \router/addr_calc/fir_write_addr[27] ,
         \router/addr_calc/fir_write_addr[23] ,
         \router/addr_calc/fir_write_addr[19] ,
         \router/addr_calc/fir_write_addr[15] ,
         \router/addr_calc/fir_write_addr[9] ,
         \router/addr_calc/fir_write_addr[5] ,
         \router/addr_calc/fir_write_addr[0] ,
         \router/addr_calc/fir_read_addr[30] ,
         \router/addr_calc/fir_read_addr[27] ,
         \router/addr_calc/fir_read_addr[23] ,
         \router/addr_calc/fir_read_addr[18] ,
         \router/addr_calc/fir_read_addr[14] ,
         \router/addr_calc/fir_read_addr[9] ,
         \router/addr_calc/fir_read_addr[5] ,
         \router/addr_calc/fir_read_addr[0] ,
         \router/addr_calc/fft_write_addr[31] ,
         \router/addr_calc/fft_write_addr[28] ,
         \router/addr_calc/fft_write_addr[27] ,
         \router/addr_calc/fft_write_addr[23] ,
         \router/addr_calc/fft_write_addr[19] ,
         \router/addr_calc/fft_write_addr[15] ,
         \router/addr_calc/fft_write_addr[9] ,
         \router/addr_calc/fft_write_addr[0] ,
         \router/addr_calc/fft_read_addr[30] ,
         \router/addr_calc/fft_read_addr[27] ,
         \router/addr_calc/fft_read_addr[23] ,
         \router/addr_calc/fft_read_addr[18] ,
         \router/addr_calc/fft_read_addr[14] ,
         \router/addr_calc/fft_read_addr[9] ,
         \router/addr_calc/fft_read_addr[5] ,
         \router/addr_calc/fft_read_addr[0] , \router/addr_calc/N99 ,
         \router/addr_calc/N95 , \router/addr_calc/N63 , \router/addr_calc/N9 ,
         \router/data_cntl/data_in[31] , \router/data_cntl/data_in[30] ,
         \router/data_cntl/data_in[29] , \router/data_cntl/data_in[28] ,
         \router/data_cntl/data_in[27] , \router/data_cntl/data_in[26] ,
         \router/data_cntl/data_in[25] , \router/data_cntl/data_in[24] ,
         \router/data_cntl/data_in[23] , \router/data_cntl/data_in[22] ,
         \router/data_cntl/data_in[21] , \router/data_cntl/data_in[20] ,
         \router/data_cntl/data_in[19] , \router/data_cntl/data_in[18] ,
         \router/data_cntl/data_in[17] , \router/data_cntl/data_in[16] ,
         \router/data_cntl/data_in[15] , \router/data_cntl/data_in[14] ,
         \router/data_cntl/data_in[13] , \router/data_cntl/data_in[12] ,
         \router/data_cntl/data_in[11] , \router/data_cntl/data_in[10] ,
         \router/data_cntl/data_in[9] , \router/data_cntl/data_in[8] ,
         \router/data_cntl/data_in[7] , \router/data_cntl/data_in[6] ,
         \router/data_cntl/data_in[5] , \router/data_cntl/data_in[4] ,
         \router/data_cntl/data_in[3] , \router/data_cntl/data_in[2] ,
         \router/data_cntl/data_in[1] , \router/data_cntl/data_in[0] ,
         \router/data_cntl/N168 , \router/data_cntl/N160 ,
         \router/data_cntl/N159 , \router/data_cntl/N156 ,
         \router/data_cntl/N155 , \router/data_cntl/N154 ,
         \router/data_cntl/N152 , \router/data_cntl/N151 ,
         \router/data_cntl/N150 , \router/data_cntl/fir_full_flag ,
         \mips/mips/a/N50 , \mips/mips/a/N49 , \mips/mips/a/N46 ,
         \mips/mips/a/countflag , \mips/mips/a/count[0] ,
         \fifo_to_fft/fifo_cell0/controller/f_i_get ,
         \fifo_to_fft/fifo_cell0/controller/valid_read ,
         \fifo_to_fft/fifo_cell0/controller/f_i_put ,
         \fifo_to_fft/fifo_cell1/controller/f_i_get ,
         \fifo_to_fft/fifo_cell1/controller/valid_read ,
         \fifo_to_fft/fifo_cell1/controller/f_i_put ,
         \fifo_to_fft/fifo_cell2/controller/f_i_get ,
         \fifo_to_fft/fifo_cell2/controller/valid_read ,
         \fifo_to_fft/fifo_cell2/controller/f_i_put ,
         \fifo_to_fft/fifo_cell3/controller/f_i_get ,
         \fifo_to_fft/fifo_cell3/controller/valid_read ,
         \fifo_to_fft/fifo_cell3/controller/f_i_put ,
         \fifo_to_fft/fifo_cell4/controller/f_i_get ,
         \fifo_to_fft/fifo_cell4/controller/valid_read ,
         \fifo_to_fft/fifo_cell4/controller/f_i_put ,
         \fifo_to_fft/fifo_cell5/controller/f_i_get ,
         \fifo_to_fft/fifo_cell5/controller/valid_read ,
         \fifo_to_fft/fifo_cell5/controller/f_i_put ,
         \fifo_to_fft/fifo_cell6/controller/f_i_get ,
         \fifo_to_fft/fifo_cell6/controller/valid_read ,
         \fifo_to_fft/fifo_cell6/controller/f_i_put ,
         \fifo_to_fft/fifo_cell7/controller/f_i_get ,
         \fifo_to_fft/fifo_cell7/controller/valid_read ,
         \fifo_to_fft/fifo_cell7/controller/f_i_put ,
         \fifo_to_fft/fifo_cell8/controller/f_i_get ,
         \fifo_to_fft/fifo_cell8/controller/valid_read ,
         \fifo_to_fft/fifo_cell8/controller/f_i_put ,
         \fifo_to_fft/fifo_cell9/controller/f_i_get ,
         \fifo_to_fft/fifo_cell9/controller/valid_read ,
         \fifo_to_fft/fifo_cell9/controller/f_i_put ,
         \fifo_to_fft/fifo_cell10/controller/f_i_get ,
         \fifo_to_fft/fifo_cell10/controller/valid_read ,
         \fifo_to_fft/fifo_cell10/controller/f_i_put ,
         \fifo_to_fft/fifo_cell11/controller/f_i_get ,
         \fifo_to_fft/fifo_cell11/controller/valid_read ,
         \fifo_to_fft/fifo_cell11/controller/f_i_put ,
         \fifo_to_fft/fifo_cell12/controller/f_i_get ,
         \fifo_to_fft/fifo_cell12/controller/valid_read ,
         \fifo_to_fft/fifo_cell12/controller/f_i_put ,
         \fifo_to_fft/fifo_cell13/controller/f_i_get ,
         \fifo_to_fft/fifo_cell13/controller/valid_read ,
         \fifo_to_fft/fifo_cell13/controller/f_i_put ,
         \fifo_to_fft/fifo_cell14/controller/f_i_get ,
         \fifo_to_fft/fifo_cell14/controller/valid_read ,
         \fifo_to_fft/fifo_cell14/controller/f_i_put ,
         \fifo_to_fft/fifo_cell15/controller/f_i_get ,
         \fifo_to_fft/fifo_cell15/controller/valid_read ,
         \fifo_to_fft/fifo_cell15/controller/f_i_put ,
         \fifo_from_fft/fifo_cell0/controller/f_i_get ,
         \fifo_from_fft/fifo_cell0/controller/valid_read ,
         \fifo_from_fft/fifo_cell0/data_out/N35 ,
         \fifo_from_fft/fifo_cell0/reg_gtok/token ,
         \fifo_from_fft/fifo_cell1/controller/f_i_get ,
         \fifo_from_fft/fifo_cell1/controller/valid_read ,
         \fifo_from_fft/fifo_cell1/data_out/N35 ,
         \fifo_from_fft/fifo_cell1/reg_gtok/token ,
         \fifo_from_fft/fifo_cell2/controller/f_i_get ,
         \fifo_from_fft/fifo_cell2/controller/valid_read ,
         \fifo_from_fft/fifo_cell2/data_out/N35 ,
         \fifo_from_fft/fifo_cell2/reg_gtok/token ,
         \fifo_from_fft/fifo_cell3/controller/f_i_get ,
         \fifo_from_fft/fifo_cell3/controller/valid_read ,
         \fifo_from_fft/fifo_cell3/data_out/N35 ,
         \fifo_from_fft/fifo_cell3/reg_gtok/token ,
         \fifo_from_fft/fifo_cell4/controller/f_i_get ,
         \fifo_from_fft/fifo_cell4/controller/valid_read ,
         \fifo_from_fft/fifo_cell4/data_out/N35 ,
         \fifo_from_fft/fifo_cell4/reg_gtok/token ,
         \fifo_from_fft/fifo_cell5/controller/f_i_get ,
         \fifo_from_fft/fifo_cell5/controller/valid_read ,
         \fifo_from_fft/fifo_cell5/data_out/N35 ,
         \fifo_from_fft/fifo_cell5/reg_gtok/token ,
         \fifo_from_fft/fifo_cell6/controller/f_i_get ,
         \fifo_from_fft/fifo_cell6/controller/valid_read ,
         \fifo_from_fft/fifo_cell6/data_out/N35 ,
         \fifo_from_fft/fifo_cell6/reg_gtok/token ,
         \fifo_from_fft/fifo_cell7/controller/f_i_get ,
         \fifo_from_fft/fifo_cell7/controller/valid_read ,
         \fifo_from_fft/fifo_cell7/data_out/N35 ,
         \fifo_from_fft/fifo_cell7/reg_gtok/token ,
         \fifo_from_fft/fifo_cell8/controller/f_i_get ,
         \fifo_from_fft/fifo_cell8/controller/valid_read ,
         \fifo_from_fft/fifo_cell8/data_out/N35 ,
         \fifo_from_fft/fifo_cell8/reg_gtok/token ,
         \fifo_from_fft/fifo_cell9/controller/f_i_get ,
         \fifo_from_fft/fifo_cell9/controller/valid_read ,
         \fifo_from_fft/fifo_cell9/data_out/N35 ,
         \fifo_from_fft/fifo_cell9/reg_gtok/token ,
         \fifo_from_fft/fifo_cell10/controller/f_i_get ,
         \fifo_from_fft/fifo_cell10/controller/valid_read ,
         \fifo_from_fft/fifo_cell10/data_out/N35 ,
         \fifo_from_fft/fifo_cell10/reg_gtok/token ,
         \fifo_from_fft/fifo_cell11/controller/f_i_get ,
         \fifo_from_fft/fifo_cell11/controller/valid_read ,
         \fifo_from_fft/fifo_cell11/data_out/N35 ,
         \fifo_from_fft/fifo_cell11/reg_gtok/token ,
         \fifo_from_fft/fifo_cell12/controller/f_i_get ,
         \fifo_from_fft/fifo_cell12/controller/valid_read ,
         \fifo_from_fft/fifo_cell12/data_out/N35 ,
         \fifo_from_fft/fifo_cell12/reg_gtok/token ,
         \fifo_from_fft/fifo_cell13/controller/f_i_get ,
         \fifo_from_fft/fifo_cell13/controller/valid_read ,
         \fifo_from_fft/fifo_cell13/data_out/N35 ,
         \fifo_from_fft/fifo_cell13/reg_gtok/token ,
         \fifo_from_fft/fifo_cell14/controller/f_i_get ,
         \fifo_from_fft/fifo_cell14/controller/valid_read ,
         \fifo_from_fft/fifo_cell14/data_out/N35 ,
         \fifo_from_fft/fifo_cell14/reg_gtok/token ,
         \fifo_from_fft/fifo_cell15/controller/f_i_get ,
         \fifo_from_fft/fifo_cell15/controller/valid_read ,
         \fifo_from_fft/fifo_cell15/reg_gtok/token ,
         \fifo_to_fir/fifo_cell0/controller/f_i_get ,
         \fifo_to_fir/fifo_cell0/controller/valid_read ,
         \fifo_to_fir/fifo_cell0/controller/f_i_put ,
         \fifo_to_fir/fifo_cell1/controller/f_i_get ,
         \fifo_to_fir/fifo_cell1/controller/valid_read ,
         \fifo_to_fir/fifo_cell1/controller/f_i_put ,
         \fifo_to_fir/fifo_cell2/controller/f_i_get ,
         \fifo_to_fir/fifo_cell2/controller/valid_read ,
         \fifo_to_fir/fifo_cell2/controller/f_i_put ,
         \fifo_to_fir/fifo_cell3/controller/f_i_get ,
         \fifo_to_fir/fifo_cell3/controller/valid_read ,
         \fifo_to_fir/fifo_cell3/controller/f_i_put ,
         \fifo_to_fir/fifo_cell4/controller/f_i_get ,
         \fifo_to_fir/fifo_cell4/controller/valid_read ,
         \fifo_to_fir/fifo_cell4/controller/f_i_put ,
         \fifo_to_fir/fifo_cell5/controller/f_i_get ,
         \fifo_to_fir/fifo_cell5/controller/valid_read ,
         \fifo_to_fir/fifo_cell5/controller/f_i_put ,
         \fifo_to_fir/fifo_cell6/controller/f_i_get ,
         \fifo_to_fir/fifo_cell6/controller/valid_read ,
         \fifo_to_fir/fifo_cell6/controller/f_i_put ,
         \fifo_to_fir/fifo_cell7/controller/f_i_get ,
         \fifo_to_fir/fifo_cell7/controller/valid_read ,
         \fifo_to_fir/fifo_cell7/controller/f_i_put ,
         \fifo_to_fir/fifo_cell8/controller/f_i_get ,
         \fifo_to_fir/fifo_cell8/controller/valid_read ,
         \fifo_to_fir/fifo_cell8/controller/f_i_put ,
         \fifo_to_fir/fifo_cell9/controller/f_i_get ,
         \fifo_to_fir/fifo_cell9/controller/valid_read ,
         \fifo_to_fir/fifo_cell9/controller/f_i_put ,
         \fifo_to_fir/fifo_cell10/controller/f_i_get ,
         \fifo_to_fir/fifo_cell10/controller/valid_read ,
         \fifo_to_fir/fifo_cell10/controller/f_i_put ,
         \fifo_to_fir/fifo_cell11/controller/f_i_get ,
         \fifo_to_fir/fifo_cell11/controller/valid_read ,
         \fifo_to_fir/fifo_cell11/controller/f_i_put ,
         \fifo_to_fir/fifo_cell12/controller/f_i_get ,
         \fifo_to_fir/fifo_cell12/controller/valid_read ,
         \fifo_to_fir/fifo_cell12/controller/f_i_put ,
         \fifo_to_fir/fifo_cell13/controller/f_i_get ,
         \fifo_to_fir/fifo_cell13/controller/valid_read ,
         \fifo_to_fir/fifo_cell13/controller/f_i_put ,
         \fifo_to_fir/fifo_cell14/controller/f_i_get ,
         \fifo_to_fir/fifo_cell14/controller/valid_read ,
         \fifo_to_fir/fifo_cell14/controller/f_i_put ,
         \fifo_to_fir/fifo_cell15/controller/f_i_get ,
         \fifo_to_fir/fifo_cell15/controller/valid_read ,
         \fifo_to_fir/fifo_cell15/controller/f_i_put ,
         \fifo_from_fir/fifo_cell0/controller/f_i_get ,
         \fifo_from_fir/fifo_cell0/controller/valid_read ,
         \fifo_from_fir/fifo_cell0/data_out/N35 ,
         \fifo_from_fir/fifo_cell0/reg_gtok/token ,
         \fifo_from_fir/fifo_cell1/controller/f_i_get ,
         \fifo_from_fir/fifo_cell1/controller/valid_read ,
         \fifo_from_fir/fifo_cell1/data_out/N35 ,
         \fifo_from_fir/fifo_cell1/reg_gtok/token ,
         \fifo_from_fir/fifo_cell2/controller/f_i_get ,
         \fifo_from_fir/fifo_cell2/controller/valid_read ,
         \fifo_from_fir/fifo_cell2/data_out/N35 ,
         \fifo_from_fir/fifo_cell2/reg_gtok/token ,
         \fifo_from_fir/fifo_cell3/controller/f_i_get ,
         \fifo_from_fir/fifo_cell3/controller/valid_read ,
         \fifo_from_fir/fifo_cell3/data_out/N35 ,
         \fifo_from_fir/fifo_cell3/reg_gtok/token ,
         \fifo_from_fir/fifo_cell4/controller/f_i_get ,
         \fifo_from_fir/fifo_cell4/controller/valid_read ,
         \fifo_from_fir/fifo_cell4/data_out/N35 ,
         \fifo_from_fir/fifo_cell4/reg_gtok/token ,
         \fifo_from_fir/fifo_cell5/controller/f_i_get ,
         \fifo_from_fir/fifo_cell5/controller/valid_read ,
         \fifo_from_fir/fifo_cell5/data_out/N35 ,
         \fifo_from_fir/fifo_cell5/reg_gtok/token ,
         \fifo_from_fir/fifo_cell6/controller/f_i_get ,
         \fifo_from_fir/fifo_cell6/controller/valid_read ,
         \fifo_from_fir/fifo_cell6/data_out/N35 ,
         \fifo_from_fir/fifo_cell6/reg_gtok/token ,
         \fifo_from_fir/fifo_cell7/controller/f_i_get ,
         \fifo_from_fir/fifo_cell7/controller/valid_read ,
         \fifo_from_fir/fifo_cell7/data_out/N35 ,
         \fifo_from_fir/fifo_cell7/reg_gtok/token ,
         \fifo_from_fir/fifo_cell8/controller/f_i_get ,
         \fifo_from_fir/fifo_cell8/controller/valid_read ,
         \fifo_from_fir/fifo_cell8/data_out/N35 ,
         \fifo_from_fir/fifo_cell8/reg_gtok/token ,
         \fifo_from_fir/fifo_cell9/controller/f_i_get ,
         \fifo_from_fir/fifo_cell9/controller/valid_read ,
         \fifo_from_fir/fifo_cell9/data_out/N35 ,
         \fifo_from_fir/fifo_cell9/reg_gtok/token ,
         \fifo_from_fir/fifo_cell10/controller/f_i_get ,
         \fifo_from_fir/fifo_cell10/controller/valid_read ,
         \fifo_from_fir/fifo_cell10/data_out/N35 ,
         \fifo_from_fir/fifo_cell10/reg_gtok/token ,
         \fifo_from_fir/fifo_cell11/controller/f_i_get ,
         \fifo_from_fir/fifo_cell11/controller/valid_read ,
         \fifo_from_fir/fifo_cell11/data_out/N35 ,
         \fifo_from_fir/fifo_cell11/reg_gtok/token ,
         \fifo_from_fir/fifo_cell12/controller/f_i_get ,
         \fifo_from_fir/fifo_cell12/controller/valid_read ,
         \fifo_from_fir/fifo_cell12/data_out/N35 ,
         \fifo_from_fir/fifo_cell12/reg_gtok/token ,
         \fifo_from_fir/fifo_cell13/controller/f_i_get ,
         \fifo_from_fir/fifo_cell13/controller/valid_read ,
         \fifo_from_fir/fifo_cell13/data_out/N35 ,
         \fifo_from_fir/fifo_cell13/reg_gtok/token ,
         \fifo_from_fir/fifo_cell14/controller/f_i_get ,
         \fifo_from_fir/fifo_cell14/controller/valid_read ,
         \fifo_from_fir/fifo_cell14/data_out/N35 ,
         \fifo_from_fir/fifo_cell14/reg_gtok/token ,
         \fifo_from_fir/fifo_cell15/controller/f_i_get ,
         \fifo_from_fir/fifo_cell15/controller/valid_read ,
         \fifo_from_fir/fifo_cell15/reg_gtok/token ,
         \router/addr_calc/fft_read_calc/count[30] ,
         \router/addr_calc/fft_read_calc/count[27] ,
         \router/addr_calc/fft_read_calc/count[23] ,
         \router/addr_calc/fft_read_calc/count[18] ,
         \router/addr_calc/fft_read_calc/count[14] ,
         \router/addr_calc/fft_read_calc/count[9] ,
         \router/addr_calc/fft_read_calc/count[5] ,
         \router/addr_calc/fft_read_calc/count[0] ,
         \router/addr_calc/fft_write_calc/count[31] ,
         \router/addr_calc/fft_write_calc/count[28] ,
         \router/addr_calc/fft_write_calc/count[27] ,
         \router/addr_calc/fft_write_calc/count[23] ,
         \router/addr_calc/fft_write_calc/count[19] ,
         \router/addr_calc/fft_write_calc/count[15] ,
         \router/addr_calc/fft_write_calc/count[9] ,
         \router/addr_calc/fft_write_calc/count[0] ,
         \router/addr_calc/fir_read_calc/count[30] ,
         \router/addr_calc/fir_read_calc/count[27] ,
         \router/addr_calc/fir_read_calc/count[23] ,
         \router/addr_calc/fir_read_calc/count[18] ,
         \router/addr_calc/fir_read_calc/count[14] ,
         \router/addr_calc/fir_read_calc/count[9] ,
         \router/addr_calc/fir_read_calc/count[5] ,
         \router/addr_calc/fir_read_calc/count[0] ,
         \router/addr_calc/fir_write_calc/count[30] ,
         \router/addr_calc/fir_write_calc/count[27] ,
         \router/addr_calc/fir_write_calc/count[23] ,
         \router/addr_calc/fir_write_calc/count[19] ,
         \router/addr_calc/fir_write_calc/count[15] ,
         \router/addr_calc/fir_write_calc/count[9] ,
         \router/addr_calc/fir_write_calc/count[5] ,
         \router/addr_calc/fir_write_calc/count[0] ,
         \router/addr_calc/iir_read_calc/count[31] ,
         \router/addr_calc/iir_read_calc/count[30] ,
         \router/addr_calc/iir_read_calc/count[29] ,
         \router/addr_calc/iir_read_calc/count[28] ,
         \router/addr_calc/iir_read_calc/count[27] ,
         \router/addr_calc/iir_read_calc/count[26] ,
         \router/addr_calc/iir_read_calc/count[25] ,
         \router/addr_calc/iir_read_calc/count[24] ,
         \router/addr_calc/iir_read_calc/count[23] ,
         \router/addr_calc/iir_read_calc/count[22] ,
         \router/addr_calc/iir_read_calc/count[21] ,
         \router/addr_calc/iir_read_calc/count[20] ,
         \router/addr_calc/iir_read_calc/count[19] ,
         \router/addr_calc/iir_read_calc/count[18] ,
         \router/addr_calc/iir_read_calc/count[17] ,
         \router/addr_calc/iir_read_calc/count[16] ,
         \router/addr_calc/iir_read_calc/count[15] ,
         \router/addr_calc/iir_read_calc/count[14] ,
         \router/addr_calc/iir_read_calc/count[13] ,
         \router/addr_calc/iir_read_calc/count[12] ,
         \router/addr_calc/iir_read_calc/count[11] ,
         \router/addr_calc/iir_read_calc/count[10] ,
         \router/addr_calc/iir_read_calc/count[9] ,
         \router/addr_calc/iir_read_calc/count[8] ,
         \router/addr_calc/iir_read_calc/count[7] ,
         \router/addr_calc/iir_read_calc/count[6] ,
         \router/addr_calc/iir_read_calc/count[5] ,
         \router/addr_calc/iir_read_calc/count[4] ,
         \router/addr_calc/iir_read_calc/count[3] ,
         \router/addr_calc/iir_read_calc/count[2] ,
         \router/addr_calc/iir_read_calc/count[1] ,
         \router/addr_calc/iir_read_calc/count[0] ,
         \router/addr_calc/iir_write_calc/count[30] ,
         \router/addr_calc/iir_write_calc/count[27] ,
         \router/addr_calc/iir_write_calc/count[23] ,
         \router/addr_calc/iir_write_calc/count[18] ,
         \router/addr_calc/iir_write_calc/count[14] ,
         \router/addr_calc/iir_write_calc/count[9] ,
         \router/addr_calc/iir_write_calc/count[5] ,
         \router/addr_calc/iir_write_calc/count[0] ,
         \router/addr_calc/fft_read_calc/counter/N212 ,
         \router/addr_calc/fft_read_calc/counter/N209 ,
         \router/addr_calc/fft_read_calc/counter/N208 ,
         \router/addr_calc/fft_read_calc/counter/N207 ,
         \router/addr_calc/fft_read_calc/counter/N206 ,
         \router/addr_calc/fft_read_calc/counter/N205 ,
         \router/addr_calc/fft_read_calc/counter/N204 ,
         \router/addr_calc/fft_read_calc/counter/N203 ,
         \router/addr_calc/fft_read_calc/counter/N202 ,
         \router/addr_calc/fft_read_calc/counter/N201 ,
         \router/addr_calc/fft_read_calc/counter/N200 ,
         \router/addr_calc/fft_read_calc/counter/N199 ,
         \router/addr_calc/fft_read_calc/counter/N198 ,
         \router/addr_calc/fft_read_calc/counter/N197 ,
         \router/addr_calc/fft_read_calc/counter/N196 ,
         \router/addr_calc/fft_read_calc/counter/N195 ,
         \router/addr_calc/fft_read_calc/counter/N194 ,
         \router/addr_calc/fft_read_calc/counter/N193 ,
         \router/addr_calc/fft_read_calc/counter/N192 ,
         \router/addr_calc/fft_read_calc/counter/N191 ,
         \router/addr_calc/fft_read_calc/counter/N190 ,
         \router/addr_calc/fft_read_calc/counter/N189 ,
         \router/addr_calc/fft_read_calc/counter/N188 ,
         \router/addr_calc/fft_read_calc/counter/N187 ,
         \router/addr_calc/fft_read_calc/counter/N186 ,
         \router/addr_calc/fft_read_calc/counter/N185 ,
         \router/addr_calc/fft_read_calc/counter/N184 ,
         \router/addr_calc/fft_read_calc/counter/N183 ,
         \router/addr_calc/fft_read_calc/counter/N182 ,
         \router/addr_calc/fft_read_calc/counter/N181 ,
         \router/addr_calc/fft_read_calc/counter/N180 ,
         \router/addr_calc/fft_read_calc/counter/N179 ,
         \router/addr_calc/fft_read_calc/counter/N178 ,
         \router/addr_calc/fft_read_calc/counter/N77 ,
         \router/addr_calc/fft_read_calc/counter/N76 ,
         \router/addr_calc/fft_read_calc/counter/N75 ,
         \router/addr_calc/fft_read_calc/counter/N74 ,
         \router/addr_calc/fft_read_calc/counter/N73 ,
         \router/addr_calc/fft_read_calc/counter/N72 ,
         \router/addr_calc/fft_read_calc/counter/N71 ,
         \router/addr_calc/fft_read_calc/counter/N70 ,
         \router/addr_calc/fft_read_calc/counter/N69 ,
         \router/addr_calc/fft_read_calc/counter/N68 ,
         \router/addr_calc/fft_read_calc/counter/N67 ,
         \router/addr_calc/fft_read_calc/counter/N66 ,
         \router/addr_calc/fft_read_calc/counter/N65 ,
         \router/addr_calc/fft_read_calc/counter/N64 ,
         \router/addr_calc/fft_read_calc/counter/N63 ,
         \router/addr_calc/fft_read_calc/counter/N62 ,
         \router/addr_calc/fft_read_calc/counter/N61 ,
         \router/addr_calc/fft_read_calc/counter/N60 ,
         \router/addr_calc/fft_read_calc/counter/N59 ,
         \router/addr_calc/fft_read_calc/counter/N58 ,
         \router/addr_calc/fft_read_calc/counter/N57 ,
         \router/addr_calc/fft_read_calc/counter/N56 ,
         \router/addr_calc/fft_read_calc/counter/N55 ,
         \router/addr_calc/fft_read_calc/counter/N54 ,
         \router/addr_calc/fft_read_calc/counter/N53 ,
         \router/addr_calc/fft_read_calc/counter/N52 ,
         \router/addr_calc/fft_read_calc/counter/N51 ,
         \router/addr_calc/fft_read_calc/counter/N50 ,
         \router/addr_calc/fft_read_calc/counter/N49 ,
         \router/addr_calc/fft_read_calc/counter/N48 ,
         \router/addr_calc/fft_read_calc/counter/N47 ,
         \router/addr_calc/fft_read_calc/counter/N40 ,
         \router/addr_calc/fft_read_calc/counter/hold ,
         \router/addr_calc/fft_write_calc/counter/N212 ,
         \router/addr_calc/fft_write_calc/counter/N209 ,
         \router/addr_calc/fft_write_calc/counter/N208 ,
         \router/addr_calc/fft_write_calc/counter/N207 ,
         \router/addr_calc/fft_write_calc/counter/N206 ,
         \router/addr_calc/fft_write_calc/counter/N205 ,
         \router/addr_calc/fft_write_calc/counter/N204 ,
         \router/addr_calc/fft_write_calc/counter/N203 ,
         \router/addr_calc/fft_write_calc/counter/N202 ,
         \router/addr_calc/fft_write_calc/counter/N201 ,
         \router/addr_calc/fft_write_calc/counter/N200 ,
         \router/addr_calc/fft_write_calc/counter/N199 ,
         \router/addr_calc/fft_write_calc/counter/N198 ,
         \router/addr_calc/fft_write_calc/counter/N197 ,
         \router/addr_calc/fft_write_calc/counter/N196 ,
         \router/addr_calc/fft_write_calc/counter/N195 ,
         \router/addr_calc/fft_write_calc/counter/N194 ,
         \router/addr_calc/fft_write_calc/counter/N193 ,
         \router/addr_calc/fft_write_calc/counter/N192 ,
         \router/addr_calc/fft_write_calc/counter/N191 ,
         \router/addr_calc/fft_write_calc/counter/N190 ,
         \router/addr_calc/fft_write_calc/counter/N189 ,
         \router/addr_calc/fft_write_calc/counter/N188 ,
         \router/addr_calc/fft_write_calc/counter/N187 ,
         \router/addr_calc/fft_write_calc/counter/N186 ,
         \router/addr_calc/fft_write_calc/counter/N185 ,
         \router/addr_calc/fft_write_calc/counter/N184 ,
         \router/addr_calc/fft_write_calc/counter/N183 ,
         \router/addr_calc/fft_write_calc/counter/N182 ,
         \router/addr_calc/fft_write_calc/counter/N181 ,
         \router/addr_calc/fft_write_calc/counter/N180 ,
         \router/addr_calc/fft_write_calc/counter/N179 ,
         \router/addr_calc/fft_write_calc/counter/N178 ,
         \router/addr_calc/fft_write_calc/counter/N77 ,
         \router/addr_calc/fft_write_calc/counter/N76 ,
         \router/addr_calc/fft_write_calc/counter/N75 ,
         \router/addr_calc/fft_write_calc/counter/N74 ,
         \router/addr_calc/fft_write_calc/counter/N73 ,
         \router/addr_calc/fft_write_calc/counter/N72 ,
         \router/addr_calc/fft_write_calc/counter/N71 ,
         \router/addr_calc/fft_write_calc/counter/N70 ,
         \router/addr_calc/fft_write_calc/counter/N69 ,
         \router/addr_calc/fft_write_calc/counter/N68 ,
         \router/addr_calc/fft_write_calc/counter/N67 ,
         \router/addr_calc/fft_write_calc/counter/N66 ,
         \router/addr_calc/fft_write_calc/counter/N65 ,
         \router/addr_calc/fft_write_calc/counter/N64 ,
         \router/addr_calc/fft_write_calc/counter/N63 ,
         \router/addr_calc/fft_write_calc/counter/N62 ,
         \router/addr_calc/fft_write_calc/counter/N61 ,
         \router/addr_calc/fft_write_calc/counter/N60 ,
         \router/addr_calc/fft_write_calc/counter/N59 ,
         \router/addr_calc/fft_write_calc/counter/N58 ,
         \router/addr_calc/fft_write_calc/counter/N57 ,
         \router/addr_calc/fft_write_calc/counter/N56 ,
         \router/addr_calc/fft_write_calc/counter/N55 ,
         \router/addr_calc/fft_write_calc/counter/N54 ,
         \router/addr_calc/fft_write_calc/counter/N53 ,
         \router/addr_calc/fft_write_calc/counter/N52 ,
         \router/addr_calc/fft_write_calc/counter/N51 ,
         \router/addr_calc/fft_write_calc/counter/N50 ,
         \router/addr_calc/fft_write_calc/counter/N49 ,
         \router/addr_calc/fft_write_calc/counter/N48 ,
         \router/addr_calc/fft_write_calc/counter/N47 ,
         \router/addr_calc/fft_write_calc/counter/N40 ,
         \router/addr_calc/fft_write_calc/counter/hold ,
         \router/addr_calc/fir_read_calc/counter/N212 ,
         \router/addr_calc/fir_read_calc/counter/N209 ,
         \router/addr_calc/fir_read_calc/counter/N208 ,
         \router/addr_calc/fir_read_calc/counter/N207 ,
         \router/addr_calc/fir_read_calc/counter/N206 ,
         \router/addr_calc/fir_read_calc/counter/N205 ,
         \router/addr_calc/fir_read_calc/counter/N204 ,
         \router/addr_calc/fir_read_calc/counter/N203 ,
         \router/addr_calc/fir_read_calc/counter/N202 ,
         \router/addr_calc/fir_read_calc/counter/N201 ,
         \router/addr_calc/fir_read_calc/counter/N200 ,
         \router/addr_calc/fir_read_calc/counter/N199 ,
         \router/addr_calc/fir_read_calc/counter/N198 ,
         \router/addr_calc/fir_read_calc/counter/N197 ,
         \router/addr_calc/fir_read_calc/counter/N196 ,
         \router/addr_calc/fir_read_calc/counter/N195 ,
         \router/addr_calc/fir_read_calc/counter/N194 ,
         \router/addr_calc/fir_read_calc/counter/N193 ,
         \router/addr_calc/fir_read_calc/counter/N192 ,
         \router/addr_calc/fir_read_calc/counter/N191 ,
         \router/addr_calc/fir_read_calc/counter/N190 ,
         \router/addr_calc/fir_read_calc/counter/N189 ,
         \router/addr_calc/fir_read_calc/counter/N188 ,
         \router/addr_calc/fir_read_calc/counter/N187 ,
         \router/addr_calc/fir_read_calc/counter/N186 ,
         \router/addr_calc/fir_read_calc/counter/N185 ,
         \router/addr_calc/fir_read_calc/counter/N184 ,
         \router/addr_calc/fir_read_calc/counter/N183 ,
         \router/addr_calc/fir_read_calc/counter/N182 ,
         \router/addr_calc/fir_read_calc/counter/N181 ,
         \router/addr_calc/fir_read_calc/counter/N180 ,
         \router/addr_calc/fir_read_calc/counter/N179 ,
         \router/addr_calc/fir_read_calc/counter/N178 ,
         \router/addr_calc/fir_read_calc/counter/N77 ,
         \router/addr_calc/fir_read_calc/counter/N76 ,
         \router/addr_calc/fir_read_calc/counter/N75 ,
         \router/addr_calc/fir_read_calc/counter/N74 ,
         \router/addr_calc/fir_read_calc/counter/N73 ,
         \router/addr_calc/fir_read_calc/counter/N72 ,
         \router/addr_calc/fir_read_calc/counter/N71 ,
         \router/addr_calc/fir_read_calc/counter/N70 ,
         \router/addr_calc/fir_read_calc/counter/N69 ,
         \router/addr_calc/fir_read_calc/counter/N68 ,
         \router/addr_calc/fir_read_calc/counter/N67 ,
         \router/addr_calc/fir_read_calc/counter/N66 ,
         \router/addr_calc/fir_read_calc/counter/N65 ,
         \router/addr_calc/fir_read_calc/counter/N64 ,
         \router/addr_calc/fir_read_calc/counter/N63 ,
         \router/addr_calc/fir_read_calc/counter/N62 ,
         \router/addr_calc/fir_read_calc/counter/N61 ,
         \router/addr_calc/fir_read_calc/counter/N60 ,
         \router/addr_calc/fir_read_calc/counter/N59 ,
         \router/addr_calc/fir_read_calc/counter/N58 ,
         \router/addr_calc/fir_read_calc/counter/N57 ,
         \router/addr_calc/fir_read_calc/counter/N56 ,
         \router/addr_calc/fir_read_calc/counter/N55 ,
         \router/addr_calc/fir_read_calc/counter/N54 ,
         \router/addr_calc/fir_read_calc/counter/N53 ,
         \router/addr_calc/fir_read_calc/counter/N52 ,
         \router/addr_calc/fir_read_calc/counter/N51 ,
         \router/addr_calc/fir_read_calc/counter/N50 ,
         \router/addr_calc/fir_read_calc/counter/N49 ,
         \router/addr_calc/fir_read_calc/counter/N48 ,
         \router/addr_calc/fir_read_calc/counter/N47 ,
         \router/addr_calc/fir_read_calc/counter/N40 ,
         \router/addr_calc/fir_read_calc/counter/hold ,
         \router/addr_calc/fir_write_calc/counter/N212 ,
         \router/addr_calc/fir_write_calc/counter/N209 ,
         \router/addr_calc/fir_write_calc/counter/N208 ,
         \router/addr_calc/fir_write_calc/counter/N207 ,
         \router/addr_calc/fir_write_calc/counter/N206 ,
         \router/addr_calc/fir_write_calc/counter/N205 ,
         \router/addr_calc/fir_write_calc/counter/N204 ,
         \router/addr_calc/fir_write_calc/counter/N203 ,
         \router/addr_calc/fir_write_calc/counter/N202 ,
         \router/addr_calc/fir_write_calc/counter/N201 ,
         \router/addr_calc/fir_write_calc/counter/N200 ,
         \router/addr_calc/fir_write_calc/counter/N199 ,
         \router/addr_calc/fir_write_calc/counter/N198 ,
         \router/addr_calc/fir_write_calc/counter/N197 ,
         \router/addr_calc/fir_write_calc/counter/N196 ,
         \router/addr_calc/fir_write_calc/counter/N195 ,
         \router/addr_calc/fir_write_calc/counter/N194 ,
         \router/addr_calc/fir_write_calc/counter/N193 ,
         \router/addr_calc/fir_write_calc/counter/N192 ,
         \router/addr_calc/fir_write_calc/counter/N191 ,
         \router/addr_calc/fir_write_calc/counter/N190 ,
         \router/addr_calc/fir_write_calc/counter/N189 ,
         \router/addr_calc/fir_write_calc/counter/N188 ,
         \router/addr_calc/fir_write_calc/counter/N187 ,
         \router/addr_calc/fir_write_calc/counter/N186 ,
         \router/addr_calc/fir_write_calc/counter/N185 ,
         \router/addr_calc/fir_write_calc/counter/N184 ,
         \router/addr_calc/fir_write_calc/counter/N183 ,
         \router/addr_calc/fir_write_calc/counter/N182 ,
         \router/addr_calc/fir_write_calc/counter/N181 ,
         \router/addr_calc/fir_write_calc/counter/N180 ,
         \router/addr_calc/fir_write_calc/counter/N179 ,
         \router/addr_calc/fir_write_calc/counter/N178 ,
         \router/addr_calc/fir_write_calc/counter/N77 ,
         \router/addr_calc/fir_write_calc/counter/N76 ,
         \router/addr_calc/fir_write_calc/counter/N75 ,
         \router/addr_calc/fir_write_calc/counter/N74 ,
         \router/addr_calc/fir_write_calc/counter/N73 ,
         \router/addr_calc/fir_write_calc/counter/N72 ,
         \router/addr_calc/fir_write_calc/counter/N71 ,
         \router/addr_calc/fir_write_calc/counter/N70 ,
         \router/addr_calc/fir_write_calc/counter/N69 ,
         \router/addr_calc/fir_write_calc/counter/N68 ,
         \router/addr_calc/fir_write_calc/counter/N67 ,
         \router/addr_calc/fir_write_calc/counter/N66 ,
         \router/addr_calc/fir_write_calc/counter/N65 ,
         \router/addr_calc/fir_write_calc/counter/N64 ,
         \router/addr_calc/fir_write_calc/counter/N63 ,
         \router/addr_calc/fir_write_calc/counter/N62 ,
         \router/addr_calc/fir_write_calc/counter/N61 ,
         \router/addr_calc/fir_write_calc/counter/N60 ,
         \router/addr_calc/fir_write_calc/counter/N59 ,
         \router/addr_calc/fir_write_calc/counter/N58 ,
         \router/addr_calc/fir_write_calc/counter/N57 ,
         \router/addr_calc/fir_write_calc/counter/N56 ,
         \router/addr_calc/fir_write_calc/counter/N55 ,
         \router/addr_calc/fir_write_calc/counter/N54 ,
         \router/addr_calc/fir_write_calc/counter/N53 ,
         \router/addr_calc/fir_write_calc/counter/N52 ,
         \router/addr_calc/fir_write_calc/counter/N51 ,
         \router/addr_calc/fir_write_calc/counter/N50 ,
         \router/addr_calc/fir_write_calc/counter/N49 ,
         \router/addr_calc/fir_write_calc/counter/N48 ,
         \router/addr_calc/fir_write_calc/counter/N47 ,
         \router/addr_calc/fir_write_calc/counter/N40 ,
         \router/addr_calc/fir_write_calc/counter/hold ,
         \router/addr_calc/iir_read_calc/counter/N209 ,
         \router/addr_calc/iir_read_calc/counter/N208 ,
         \router/addr_calc/iir_read_calc/counter/N207 ,
         \router/addr_calc/iir_read_calc/counter/N206 ,
         \router/addr_calc/iir_read_calc/counter/N205 ,
         \router/addr_calc/iir_read_calc/counter/N204 ,
         \router/addr_calc/iir_read_calc/counter/N203 ,
         \router/addr_calc/iir_read_calc/counter/N202 ,
         \router/addr_calc/iir_read_calc/counter/N201 ,
         \router/addr_calc/iir_read_calc/counter/N200 ,
         \router/addr_calc/iir_read_calc/counter/N199 ,
         \router/addr_calc/iir_read_calc/counter/N198 ,
         \router/addr_calc/iir_read_calc/counter/N197 ,
         \router/addr_calc/iir_read_calc/counter/N196 ,
         \router/addr_calc/iir_read_calc/counter/N195 ,
         \router/addr_calc/iir_read_calc/counter/N194 ,
         \router/addr_calc/iir_read_calc/counter/N193 ,
         \router/addr_calc/iir_read_calc/counter/N192 ,
         \router/addr_calc/iir_read_calc/counter/N191 ,
         \router/addr_calc/iir_read_calc/counter/N190 ,
         \router/addr_calc/iir_read_calc/counter/N189 ,
         \router/addr_calc/iir_read_calc/counter/N188 ,
         \router/addr_calc/iir_read_calc/counter/N187 ,
         \router/addr_calc/iir_read_calc/counter/N186 ,
         \router/addr_calc/iir_read_calc/counter/N185 ,
         \router/addr_calc/iir_read_calc/counter/N184 ,
         \router/addr_calc/iir_read_calc/counter/N183 ,
         \router/addr_calc/iir_read_calc/counter/N182 ,
         \router/addr_calc/iir_read_calc/counter/N181 ,
         \router/addr_calc/iir_read_calc/counter/N180 ,
         \router/addr_calc/iir_read_calc/counter/N179 ,
         \router/addr_calc/iir_read_calc/counter/N178 ,
         \router/addr_calc/iir_write_calc/counter/N212 ,
         \router/addr_calc/iir_write_calc/counter/N209 ,
         \router/addr_calc/iir_write_calc/counter/N208 ,
         \router/addr_calc/iir_write_calc/counter/N207 ,
         \router/addr_calc/iir_write_calc/counter/N206 ,
         \router/addr_calc/iir_write_calc/counter/N205 ,
         \router/addr_calc/iir_write_calc/counter/N204 ,
         \router/addr_calc/iir_write_calc/counter/N203 ,
         \router/addr_calc/iir_write_calc/counter/N202 ,
         \router/addr_calc/iir_write_calc/counter/N201 ,
         \router/addr_calc/iir_write_calc/counter/N200 ,
         \router/addr_calc/iir_write_calc/counter/N199 ,
         \router/addr_calc/iir_write_calc/counter/N198 ,
         \router/addr_calc/iir_write_calc/counter/N197 ,
         \router/addr_calc/iir_write_calc/counter/N196 ,
         \router/addr_calc/iir_write_calc/counter/N195 ,
         \router/addr_calc/iir_write_calc/counter/N194 ,
         \router/addr_calc/iir_write_calc/counter/N193 ,
         \router/addr_calc/iir_write_calc/counter/N192 ,
         \router/addr_calc/iir_write_calc/counter/N191 ,
         \router/addr_calc/iir_write_calc/counter/N190 ,
         \router/addr_calc/iir_write_calc/counter/N189 ,
         \router/addr_calc/iir_write_calc/counter/N188 ,
         \router/addr_calc/iir_write_calc/counter/N187 ,
         \router/addr_calc/iir_write_calc/counter/N186 ,
         \router/addr_calc/iir_write_calc/counter/N185 ,
         \router/addr_calc/iir_write_calc/counter/N184 ,
         \router/addr_calc/iir_write_calc/counter/N183 ,
         \router/addr_calc/iir_write_calc/counter/N182 ,
         \router/addr_calc/iir_write_calc/counter/N181 ,
         \router/addr_calc/iir_write_calc/counter/N180 ,
         \router/addr_calc/iir_write_calc/counter/N179 ,
         \router/addr_calc/iir_write_calc/counter/N178 ,
         \router/addr_calc/iir_write_calc/counter/N76 ,
         \router/addr_calc/iir_write_calc/counter/N75 ,
         \router/addr_calc/iir_write_calc/counter/N74 ,
         \router/addr_calc/iir_write_calc/counter/N73 ,
         \router/addr_calc/iir_write_calc/counter/N72 ,
         \router/addr_calc/iir_write_calc/counter/N71 ,
         \router/addr_calc/iir_write_calc/counter/N70 ,
         \router/addr_calc/iir_write_calc/counter/N69 ,
         \router/addr_calc/iir_write_calc/counter/N68 ,
         \router/addr_calc/iir_write_calc/counter/N67 ,
         \router/addr_calc/iir_write_calc/counter/N66 ,
         \router/addr_calc/iir_write_calc/counter/N65 ,
         \router/addr_calc/iir_write_calc/counter/N64 ,
         \router/addr_calc/iir_write_calc/counter/N63 ,
         \router/addr_calc/iir_write_calc/counter/N62 ,
         \router/addr_calc/iir_write_calc/counter/N61 ,
         \router/addr_calc/iir_write_calc/counter/N60 ,
         \router/addr_calc/iir_write_calc/counter/N59 ,
         \router/addr_calc/iir_write_calc/counter/N58 ,
         \router/addr_calc/iir_write_calc/counter/N57 ,
         \router/addr_calc/iir_write_calc/counter/N56 ,
         \router/addr_calc/iir_write_calc/counter/N55 ,
         \router/addr_calc/iir_write_calc/counter/N54 ,
         \router/addr_calc/iir_write_calc/counter/N53 ,
         \router/addr_calc/iir_write_calc/counter/N52 ,
         \router/addr_calc/iir_write_calc/counter/N51 ,
         \router/addr_calc/iir_write_calc/counter/N50 ,
         \router/addr_calc/iir_write_calc/counter/N49 ,
         \router/addr_calc/iir_write_calc/counter/N48 ,
         \router/addr_calc/iir_write_calc/counter/N47 ,
         \router/addr_calc/iir_write_calc/counter/N40 ,
         \router/addr_calc/iir_write_calc/counter/hold , n1161, n1289, n1353,
         n1417, n1481, n1545, n1609, n1673, n1737, n1801, n1865, n1929, n1993,
         n2057, n2121, n2185, n2249, n2313, n2377, n2441, n2569, n2633, n2697,
         n2761, n2825, n2889, n2953, n3017, n3081, n3145, n3209, n3273, n3337,
         n3401, n3465, n3593, n3760, n3808, n3811, n4310, n4325, n4348, n4699,
         n4714, n4725, n4740, n4773, n4794, n4810, n4843, n4915, n5162, n5165,
         n5575, n5595, n5600, n5601, n5602, n5603, n5604, n5605, n5606, n5607,
         n5608, n5609, n5610, n5611, n5612, n5613, n5614, n5615, n5616, n5617,
         n5618, n5619, n5620, n5621, n5622, n5623, n5624, n5625, n5626, n5627,
         n5628, n5629, n5630, n5631, n5632, n5633, n5634, n5635, n5636, n5637,
         n5638, n5639, n5640, n5641, n5642, n5643, n5644, n5645, n5646, n5647,
         n5648, n5649, n5650, n5651, n5652, n5653, n5654, n5655, n5656, n5657,
         n5658, n5659, n5660, n5661, n5662, n5663, n5664, n5665, n5666, n5667,
         n5668, n5670, n5672, n5674, n5675, n5676, n5677, n5678, n5679, n5680,
         n5681, n5682, n5683, n5684, n5685, n5686, n5687, n5688, n5689, n5690,
         n5691, n5692, n5693, n5694, n5695, n5696, n5697, n5698, n5699, n5700,
         n5701, n5702, n5703, n5704, n5705, n5706, n5707, n5708, n5709, n5710,
         n5711, n5712, n5713, n5714, n5715, n5716, n5717, n5718, n5719, n5720,
         n5721, n5722, n5723, n5724, n5725, n5726, n5727, n5728, n5729, n5730,
         n5731, n5732, n5733, n5734, n5735, n5736, n5737, n5738, n5739, n5740,
         n5741, n5742, n5743, n5744, n5745, n5746, n5747, n5748, n5749, n5750,
         n5751, n5752, n5753, n5754, n5755, n5756, n5757, n5758, n5759, n5760,
         n5761, n5762, n5763, n5764, n5765, n5766, n5767, n5768, n5769, n5770,
         n5771, n5772, n5773, n5774, n5775, n5776, n5777, n5778, n5779, n5780,
         n5781, n5782, n5783, n5784, n5785, n5786, n5787, n5788, n5789, n5790,
         n5791, n5792, n5793, n5794, n5795, n5796, n5797, n5798, n5799, n5800,
         n5801, n5802, n5803, n5804, n5805, n5806, n5807, n5808, n5809, n5810,
         n5811, n5812, n5813, n5814, n5815, n5816, n5817, n5818, n5819, n5820,
         n5821, n5822, n5823, n5824, n5825, n5826, n5827, n5828, n5829, n5830,
         n5831, n5832, n5833, n5834, n5835, n5836, n5837, n5838, n5839, n5840,
         n5841, n5842, n5843, n5844, n5845, n5940, n5941, n5942, n5943, n5944,
         n5945, n5946, n5947, \add_x_22_5/carry[2] , \add_x_22_5/carry[3] ,
         \add_x_22_5/carry[4] , \add_x_22_5/carry[5] , \add_x_22_5/carry[6] ,
         \add_x_22_5/carry[7] , \add_x_22_5/carry[8] , \add_x_22_5/carry[9] ,
         \add_x_22_5/carry[10] , \add_x_22_5/carry[11] ,
         \add_x_22_5/carry[12] , \add_x_22_5/carry[13] ,
         \add_x_22_5/carry[14] , \add_x_22_5/carry[15] ,
         \add_x_22_5/carry[16] , \add_x_22_5/carry[17] ,
         \add_x_22_5/carry[18] , \add_x_22_5/carry[19] ,
         \add_x_22_5/carry[20] , \add_x_22_5/carry[21] ,
         \add_x_22_5/carry[22] , \add_x_22_5/carry[23] ,
         \add_x_22_5/carry[24] , \add_x_22_5/carry[25] ,
         \add_x_22_5/carry[26] , \add_x_22_5/carry[27] ,
         \add_x_22_5/carry[28] , \add_x_22_5/carry[29] ,
         \add_x_22_5/carry[30] , \add_x_22_5/carry[31] , \add_x_22_3/carry[2] ,
         \add_x_22_3/carry[3] , \add_x_22_3/carry[4] , \add_x_22_3/carry[5] ,
         \add_x_22_3/carry[6] , \add_x_22_3/carry[7] , \add_x_22_3/carry[8] ,
         \add_x_22_3/carry[9] , \add_x_22_3/carry[10] , \add_x_22_3/carry[11] ,
         \add_x_22_3/carry[12] , \add_x_22_3/carry[13] ,
         \add_x_22_3/carry[14] , \add_x_22_3/carry[15] ,
         \add_x_22_3/carry[16] , \add_x_22_3/carry[17] ,
         \add_x_22_3/carry[18] , \add_x_22_3/carry[19] ,
         \add_x_22_3/carry[20] , \add_x_22_3/carry[21] ,
         \add_x_22_3/carry[22] , \add_x_22_3/carry[23] ,
         \add_x_22_3/carry[24] , \add_x_22_3/carry[25] ,
         \add_x_22_3/carry[26] , \add_x_22_3/carry[27] ,
         \add_x_22_3/carry[28] , \add_x_22_3/carry[29] ,
         \add_x_22_3/carry[30] , \add_x_22_3/carry[31] , \add_x_22_2/carry[2] ,
         \add_x_22_2/carry[3] , \add_x_22_2/carry[4] , \add_x_22_2/carry[5] ,
         \add_x_22_2/carry[6] , \add_x_22_2/carry[7] , \add_x_22_2/carry[8] ,
         \add_x_22_2/carry[9] , \add_x_22_2/carry[10] , \add_x_22_2/carry[11] ,
         \add_x_22_2/carry[12] , \add_x_22_2/carry[13] ,
         \add_x_22_2/carry[14] , \add_x_22_2/carry[15] ,
         \add_x_22_2/carry[16] , \add_x_22_2/carry[17] ,
         \add_x_22_2/carry[18] , \add_x_22_2/carry[19] ,
         \add_x_22_2/carry[20] , \add_x_22_2/carry[21] ,
         \add_x_22_2/carry[22] , \add_x_22_2/carry[23] ,
         \add_x_22_2/carry[24] , \add_x_22_2/carry[25] ,
         \add_x_22_2/carry[26] , \add_x_22_2/carry[27] ,
         \add_x_22_2/carry[28] , \add_x_22_2/carry[29] ,
         \add_x_22_2/carry[30] , \add_x_22_2/carry[31] , \add_x_22_1/carry[2] ,
         \add_x_22_1/carry[3] , \add_x_22_1/carry[4] , \add_x_22_1/carry[5] ,
         \add_x_22_1/carry[6] , \add_x_22_1/carry[7] , \add_x_22_1/carry[8] ,
         \add_x_22_1/carry[9] , \add_x_22_1/carry[10] , \add_x_22_1/carry[11] ,
         \add_x_22_1/carry[12] , \add_x_22_1/carry[13] ,
         \add_x_22_1/carry[14] , \add_x_22_1/carry[15] ,
         \add_x_22_1/carry[16] , \add_x_22_1/carry[17] ,
         \add_x_22_1/carry[18] , \add_x_22_1/carry[19] ,
         \add_x_22_1/carry[20] , \add_x_22_1/carry[21] ,
         \add_x_22_1/carry[22] , \add_x_22_1/carry[23] ,
         \add_x_22_1/carry[24] , \add_x_22_1/carry[25] ,
         \add_x_22_1/carry[26] , \add_x_22_1/carry[27] ,
         \add_x_22_1/carry[28] , \add_x_22_1/carry[29] ,
         \add_x_22_1/carry[30] , \add_x_22_1/carry[31] , \add_x_22_0/carry[2] ,
         \add_x_22_0/carry[3] , \add_x_22_0/carry[4] , \add_x_22_0/carry[5] ,
         \add_x_22_0/carry[6] , \add_x_22_0/carry[7] , \add_x_22_0/carry[8] ,
         \add_x_22_0/carry[9] , \add_x_22_0/carry[10] , \add_x_22_0/carry[11] ,
         \add_x_22_0/carry[12] , \add_x_22_0/carry[13] ,
         \add_x_22_0/carry[14] , \add_x_22_0/carry[15] ,
         \add_x_22_0/carry[16] , \add_x_22_0/carry[17] ,
         \add_x_22_0/carry[18] , \add_x_22_0/carry[19] ,
         \add_x_22_0/carry[20] , \add_x_22_0/carry[21] ,
         \add_x_22_0/carry[22] , \add_x_22_0/carry[23] ,
         \add_x_22_0/carry[24] , \add_x_22_0/carry[25] ,
         \add_x_22_0/carry[26] , \add_x_22_0/carry[27] ,
         \add_x_22_0/carry[28] , \add_x_22_0/carry[29] ,
         \add_x_22_0/carry[30] , \add_x_22_0/carry[31] , n5957, n5958, n5959,
         n5960, n5961, n5962, n5963, n5964, n5965, n5966, n5967, n5968, n5969,
         n5970, n5971, n5972, n5973, n5974, n5975, n5976, n5977, n5978, n5979,
         n5980, n5981, n5982, n5983, n5984, n5985, n5986, n5987, n5988, n5989,
         n5990, n5991, n5992, n5993, n5994, n5995, n5996, n5997, n5998, n5999,
         n6000, n6001, n6002, n6003, n6004, n6005, n6006, n6007, n6008, n6009,
         n6010, n6011, n6012, n6013, n6014, n6015, n6016, n6017, n6018, n6019,
         n6020, n6021, n6022, n6023, n6024, n6025, n6026, n6027, n6028, n6029,
         n6030, n6031, n6032, n6033, n6034, n6035, n6036, n6037, n6038, n6039,
         n6040, n6041, n6042, n6043, n6044, n6045, n6046, n6047, n6048, n6049,
         n6050, n6051, n6052, n6053, n6054, n6055, n6056, n6057, n6058, n6059,
         n6060, n6061, n6062, n6063, n6064, n6065, n6066, n6067, n6068, n6069,
         n6070, n6071, n6072, n6073, n6074, n6075, n6076, n6077, n6078, n6079,
         n6080, n6081, n6082, n6083, n6084, n6085, n6086, n6087, n6088, n6089,
         n6090, n6091, n6092, n6093, n6094, n6095, n6096, n6097, n6098, n6099,
         n6100, n6101, n6102, n6103, n6104, n6105, n6106, n6107, n6108, n6109,
         n6110, n6111, n6112, n6113, n6114, n6115, n6116, n6117, n6118, n6119,
         n6120, n6121, n6122, n6123, n6124, n6125, n6126, n6127, n6128, n6129,
         n6130, n6131, n6132, n6133, n6134, n6135, n6136, n6137, n6138, n6139,
         n6140, n6141, n6142, n6143, n6144, n6145, n6146, n6147, n6148, n6149,
         n6150, n6151, n6152, n6153, n6154, n6155, n6156, n6157, n6158, n6159,
         n6160, n6161, n6162, n6163, n6164, n6165, n6166, n6167, n6168, n6169,
         n6170, n6171, n6172, n6173, n6174, n6175, n6176, n6177, n6178, n6179,
         n6180, n6181, n6182, n6183, n6184, n6185, n6186, n6187, n6188, n6189,
         n6190, n6191, n6192, n6193, n6194, n6195, n6196, n6197, n6198, n6199,
         n6200, n6201, n6202, n6203, n6204, n6205, n6206, n6211, n6212, n6213,
         n6214, n6215, n6216, n6217, n6218, n6219, n6220, n6221, n6222, n6223,
         n6224, n6225, n6226, n6227, n6228, n6229, n6230, n6231, n6232, n6233,
         n6234, n6235, n6236, n6237, n6238, n6239, n6240, n6241, n6242, n6243,
         n6244, n6245, n6246, n6247, n6248, n6249, n6250, n6251, n6252, n6253,
         n6254, n6255, n6256, n6257, n6258, n6259, n6260, n6261, n6262, n6263,
         n6264, n6265, n6266, n6267, n6268, n6269, n6270, n6271, n6272, n6273,
         n6274, n6275, n6276, n6277, n6278, n6279, n6280, n6281, n6282, n6283,
         n6284, n6285, n6286, n6287, n6288, n6289, n6290, n6291, n6292, n6293,
         n6294, n6295, n6296, n6297, n6298, n6299, n6300, n6301, n6302, n6303,
         n6304, n6305, n6306, n6307, n6308, n6309, n6310, n6311, n6312, n6313,
         n6314, n6315, n6316, n6317, n6318, n6319, n6320, n6321, n6322, n6323,
         n6324, n6325, n6326, n6327, n6328, n6329, n6330, n6331, n6332, n6333,
         n6334, n6335, n6336, n6337, n6338, n6339, n6340, n6341, n6342, n6343,
         n6344, n6345, n6346, n6347, n6348, n6349, n6350, n6351, n6352, n6353,
         n6354, n6355, n6356, n6357, n6358, n6359, n6360, n6361, n6362, n6363,
         n6364, n6365, n6366, n6367, n6368, n6369, n6370, n6371, n6372, n6373,
         n6374, n6375, n6376, n6377, n6378, n6379, n6380, n6381, n6382, n6383,
         n6384, n6385, n6386, n6387, n6388, n6389, n6390, n6391, n6392, n6393,
         n6394, n6395, n6396, n6397, n6398, n6399, n6400, n6401, n6402, n6403,
         n6404, n6405, n6406, n6407, n6408, n6409, n6410, n6411, n6412, n6413,
         n6414, n6415, n6416, n6417, n6418, n6419, n6420, n6421, n6422, n6423,
         n6424, n6425, n6426, n6427, n6428, n6429, n6430, n6431, n6432, n6433,
         n6434, n6435, n6436, n6437, n6438, n6439, n6440, n6441, n6442, n6443,
         n6444, n6445, n6446, n6447, n6448, n6449, n6450, n6451, n6452, n6453,
         n6454, n6455, n6456, n6457, n6458, n6459, n6460, n6461, n6462, n6463,
         n6464, n6465, n6466, n6467, n6468, n6469, n6470, n6471, n6472, n6473,
         n6474, n6475, n6476, n6477, n6478, n6479, n6480, n6481, n6482, n6483,
         n6484, n6485, n6486, n6487, n6488, n6489, n6490, n6491, n6492, n6493,
         n6494, n6495, n6496, n6497, n6498, n6499, n6500, n6501, n6502, n6503,
         n6504, n6505, n6506, n6507, n6508, n6509, n6510, n6511, n6512, n6513,
         n6514, n6515, n6516, n6517, n6518, n6519, n6520, n6521, n6522, n6523,
         n6524, n6525, n6526, n6527, n6528, n6529, n6530, n6531, n6532, n6533,
         n6534, n6535, n6536, n6537, n6538, n6539, n6540, n6541, n6542, n6543,
         n6544, n6545, n6546, n6547, n6548, n6549, n6550, n6551, n6552, n6553,
         n6554, n6555, n6556, n6557, n6558, n6559, n6560, n6561, n6562, n6563,
         n6564, n6565, n6566, n6567, n6568, n6569, n6570, n6571, n6572, n6573,
         n6574, n6575, n6576, n6577, n6578, n6579, n6580, n6581, n6582, n6583,
         n6584, n6585, n6586, n6587, n6588, n6589, n6590, n6591, n6592, n6593,
         n6594, n6595, n6596, n6597, n6598, n6599, n6600, n6601, n6602, n6603,
         n6604, n6605, n6606, n6607, n6608, n6609, n6610, n6611, n6612, n6613,
         n6614, n6615, n6616, n6617, n6618, n6619, n6620, n6621, n6622, n6623,
         n6624, n6625, n6626, n6627, n6628, n6629, n6630, n6631, n6632, n6633,
         n6634, n6635, n6636, n6637, n6638, n6639, n6640, n6641, n6642, n6643,
         n6644, n6645, n6646, n6647, n6648, n6649, n6650, n6651, n6652, n6653,
         n6654, n6655, n6656, n6657, n6658, n6659, n6660, n6661, n6662, n6663,
         n6664, n6665, n6666, n6667, n6668, n6669, n6670, n6671, n6672, n6673,
         n6674, n6675, n6676, n6677, n6678, n6679, n6680, n6681, n6682, n6683,
         n6684, n6685, n6686, n6687, n6688, n6689, n6724, n6725, n6726, n6727,
         n6728, n6729, n6730, n6731, n6732, n6733, n6734, n6735, n6736, n6737,
         n6738, n6739, n6740, n6741, n6742, n6743, n6744, n6745, n6746, n6747,
         n6748, n6749, n6750, n6751, n6752, n6753, n6754, n6755, n6756, n6757,
         n6758, n6759, n6760, n6761, n6762, n6763, n6764, n6765, n6766, n6767,
         n6768, n6769, n6770, n6771, n6772, n6773, n6774, n6775, n6776, n6777,
         n6778, n6779, n6780, n6781, n6782, n6783, n6784, n6785, n6786, n6787,
         n6788, n6789, n6790, n6791, n6792, n6793, n6794, n6795, n6796, n6797,
         n6798, n6799, n6800, n6801, n6802, n6803, n6804, n6805, n6806, n6807,
         n6808, n6809, n6810, n6811, n6812, n6813, n6814, n6815, n6816, n6817,
         n6818, n6819, n6820, n6821, n6822, n6823, n6824, n6825, n6826, n6827,
         n6828, n6829, n6830, n6831, n6832, n6833, n6834, n6835, n6836, n6837,
         n6838, n6839, n6840, n6841, n6842, n6843, n6844, n6845, n6846, n6847,
         n6848, n6849, n6850, n6851, n6852, n6853, n6854, n6893, n6894, n6895,
         n6896, n6897, n6898, n6899, n6900, n6901, n6902, n6903, n6904, n6905,
         n6906, n6907, n6908, n6909, n6910, n6911, n6912, n6913, n6914, n6915,
         n6916, n6917, n6918, n6919, n6920, n6921, n6922, n6923, n6924, n6925,
         n6926, n6927, n6928, n6929, n6930, n6931, n6932, n6933, n6934, n6935,
         n6936, n6937, n6938, n6939, n6940, n6941, n6942, n6943, n6944, n6945,
         n6946, n6947, n6948, n6949, n6950, n6951, n6952, n6953, n6954, n6955,
         n6956, n6957, n6958, n6959, n6960, n6961, n6962, n6963, n6964, n6965,
         n6966, n6967, n6968, n6969, n6970, n6971, n6972, n6973, n6974, n6975,
         n6976, n6977, n6978, n6979, n6980, n6981, n6982, n6983, n6984, n6985,
         n6986, n6987, n6988, n6989, n6990, n6991, n6992, n6993, n6994, n6995,
         n6996, n6997, n6998, n6999, n7000, n7001, n7002, n7003, n7004, n7005,
         n7006, n7007, n7008, n7009, n7010, n7011, n7012, n7013, n7014, n7015,
         n7016, n7017, n7018, n7019, n7020, n7021, n7022, n7023, n7024, n7025,
         n7026, n7027, n7028, n7029, n7030, n7031, n7032, n7033, n7034, n7035,
         n7036, n7037, n7038, n7039, n7040, n7041, n7042, n7043, n7044, n7045,
         n7046, n7047, n7048, n7049, n7050, n7051, n7052, n7053, n7054, n7055,
         n7056, n7057, n7058, n7059, n7060, n7061, n7062, n7063, n7064, n7065,
         n7066, n7067, n7068, n7069, n7070, n7071, n7072, n7073, n7074, n7075,
         n7076, n7077, n7078, n7079, n7080, n7081, n7082, n7083, n7084, n7085,
         n7086, n7087, n7088, n7089, n7090, n7091, n7092, n7093, n7094, n7095,
         n7096, n7097, n7098, n7099, n7100, n7101, n7102, n7103, n7104, n7105,
         n7106, n7107, n7108, n7109, n7110, n7111, n7112, n7113, n7114, n7115,
         n7116, n7117, n7118, n7119, n7120, n7121, n7122, n7123, n7124, n7125,
         n7126, n7127, n7128, n7129, n7130, n7131, n7132, n7133, n7134, n7135,
         n7136, n7137, n7138, n7139, n7140, n7141, n7142, n7143, n7144, n7145,
         n7146, n7147, n7148, n7149, n7150, n7151, n7152, n7153, n7154, n7155,
         n7156, n7157, n7158, n7159, n7160, n7161, n7162, n7163, n7164, n7165,
         n7166, n7167, n7168, n7169, n7170, n7171, n7172, n7173, n7174, n7175,
         n7176, n7177, n7178, n7179, n7180, n7181, n7182, n7183, n7184, n7185,
         n7186, n7187, n7188, n7189, n7190, n7191, n7192, n7193, n7194, n7195,
         n7196, n7197, n7198, n7199, n7200, n7201, n7202, n7203, n7204, n7205,
         n7206, n7207, n7208, n7209, n7210, n7211, n7212, n7213, n7214, n7215,
         n7216, n7217, n7218, n7219, n7220, n7221, n7222, n7223, n7224, n7225,
         n7226, n7227, n7228, n7229, n7230, n7231, n7232, n7233, n7234, n7235,
         n7236, n7237, n7238, n7239, n7240, n7241, n7242, n7243, n7244, n7245,
         n7246, n7247, n7248, n7249, n7250, n7251, n7252, n7253, n7254, n7255,
         n7256, n7257, n7258, n7259, n7260, n7261, n7262, n7263, n7264, n7265,
         n7266, n7267, n7268, n7269, n7270, n7271, n7272, n7273, n7274, n7275,
         n7276, n7277, n7278, n7279, n7280, n7281, n7282, n7283, n7284, n7285,
         n7286, n7287, n7288, n7289, n7290, n7291, n7292, n7293, n7294, n7295,
         n7296, n7297, n7298, n7299, n7300, n7301, n7302, n7303, n7304, n7305,
         n7306, n7307, n7308, n7309, n7310, n7311, n7312, n7313, n7314, n7315,
         n7316, n7317, n7318, n7319, n7320, n7321, n7322, n7323, n7324, n7325,
         n7326, n7327, n7328, n7329, n7330, n7331, n7332, n7333, n7334, n7335,
         n7336, n7337, n7338, n7339, n7340, n7341, n7342, n7343, n7344, n7345,
         n7346, n7347, n7348, n7349, n7350, n7351, n7352, n7354, n7355, n7356,
         n7357, n7358, n7359, n7360, n7361, n7362, n7363, n7364, n7365, n7366,
         n7367, n7368, n7369, n7370, n7371, n7372, n7373, n7374, n7375, n7376,
         n7377, n7379, n7380, n7381, n7382, n7383, n7384, n7385, n7386, n7387,
         n7388, n7389, n7390, n7391, n7392, n7393, n7394, n7395, n7396, n7397,
         n7398, n7399, n7400, n7401, n7402, n7403, n7404, n7405, n7406, n7407,
         n7408, n7409, n7410, n7411, n7412, n7413, n7414, n7415, n7416, n7417,
         n7418, n7419, n7420, n7421, n7422, n7423, n7424, n7425, n7426, n7427,
         n7428, n7429, n7430, n7431, n7432, n7433, n7434, n7435, n7436, n7437,
         n7438, n7439, n7440, n7441, n7442, n7443, n7444, n7445, n7446, n7447,
         n7448, n7449, n7450, n7451, n7452, n7453, n7454, n7455, n7456, n7457,
         n7458, n7459, n7460, n7461, n7462, n7463, n7464, n7465, n7466, n7467,
         n7468, n7469, n7470, n7471, n7472, n7473, n7474, n7475, n7476, n7477,
         n7478, n7479, n7480, n7481, n7482, n7483, n7484, n7485, n7486, n7487,
         n7488, n7489, n7490, n7491, n7492, n7493, n7494, n7495, n7496, n7497,
         n7498, n7499, n7500, n7501, n7502, n7503, n7504, n7505, n7506, n7507,
         n7508, n7509, n7510, n7511, n7512, n7513, n7514, n7515, n7516, n7517,
         n7518, n7519, n7520, n7521, n7522, n7523, n7524, n7525, n7526, n7527,
         n7528, n7529, n7530, n7531, n7532, n7533, n7534, n7535, n7536, n7537,
         n7538, n7539, n7540, n7541, n7542, n7543, n7544, n7545, n7546, n7547,
         n7548, n7549, n7550, n7551, n7552, n7553, n7554, n7555, n7556, n7557,
         n7558, n7559, n7560, n7561, n7562, n7563, n7564, n7565, n7566, n7567,
         n7568, n7569, n7570, n7571, n7572, n7573, n7574, n7575, n7576, n7577,
         n7578, n7579, n7580, n7581, n7582, n7583, n7584, n7585, n7586, n7587,
         n7588, n7589, n7590, n7591, n7592, n7593, n7594, n7595, n7596, n7597,
         n7598, n7599, n7600, n7601, n7602, n7603, n7604, n7605, n7606, n7607,
         n7608, n7609, n7610, n7611, n7612, n7613, n7614, n7615, n7616, n7617,
         n7618, n7619, n7620, n7621, n7622, n7623, n7624, n7625, n7626, n7627,
         n7628, n7629, n7630, n7631, n7632, n7633, n7634, n7635, n7636, n7637,
         n7638, n7639, n7640, n7641, n7642, n7643, n7644, n7645, n7646, n7647,
         n7648, n7649, n7650, n7651, n7652, n7653, n7654, n7655, n7656, n7657,
         n7658, n7659, n7660, n7661, n7662, n7663, n7664, n7665, n7666, n7667,
         n7668, n7669, n7670, n7671, n7672, n7673, n7674, n7675, n7676, n7677,
         n7678, n7679, n7680, n7681, n7682, n7683, n7684, n7685, n7686, n7687,
         n7688, n7689, n7690, n7691, n7692, n7693, n7694, n7695, n7696, n7697,
         n7698, n7699, n7700, n7701, n7702, n7703, n7704, n7705, n7706, n7707,
         n7708, n7709, n7710, n7711, n7712, n7713, n7714, n7715, n7716, n7717,
         n7718, n7719, n7720, n7721, n7722, n7723, n7724, n7725, n7726, n7727,
         n7728, n7729, n7730, n7731, n7732, n7733, n7734, n7735, n7736, n7737,
         n7738, n7739, n7740, n7741, n7742, n7743, n7744, n7745, n7746, n7747,
         n7748, n7749, n7750, n7751, n7752, n7753, n7754, n7755, n7756, n7757,
         n7758, n7759, n7760, n7761, n7762, n7763, n7764, n7765, n7766, n7767,
         n7768, n7769, n7770, n7771, n7772, n7773, n7774, n7775, n7776, n7777,
         n7778, n7779, n7780, n7781, n7782, n7783, n7784, n7785, n7786, n7787,
         n7788, n7789, n7790, n7791, n7792, n7793, n7794, n7795, n7796, n7797,
         n7798, n7799, n7800, n7801, n7802, n7803, n7804, n7805, n7806, n7807,
         n7808, n7809, n7810, n7811, n7812, n7813, n7814, n7815, n7816, n7817,
         n7818, n7819, n7820, n7821, n7822, n7823, n7824, n7825, n7826, n7827,
         n7828, n7829, n7830, n7831, n7832, n7833, n7834, n7835, n7836, n7837,
         n7838, n7839, n7840, n7841, n7842, n7843, n7844, n7845, n7846, n7847,
         n7848, n7849, n7850, n7851, n7852, n7853, n7854, n7855, n7856, n7857,
         n7858, n7859, n7860, n7861, n7862, n7863, n7864, n7865, n7866, n7867,
         n7868, n7869, n7870, n7871, n7872, n7873, n7874, n7875, n7876, n7877,
         n7878, n7879, n7880, n7881, n7882, n7883, n7884, n7885, n7886, n7887,
         n7888, n7889, n7890, n7891, n7892, n7893, n7894, n7895, n7896, n7897,
         n7898, n7899, n7900, n7901, n7902, n7903, n7904, n7905, n7906, n7907,
         n7908, n7909, n7910, n7911, n7912, n7913, n7914, n7915, n7916, n7917;
  wire   [31:0] instruction;
  wire   [31:0] fft_data_in;
  wire   [31:0] fir_data_in;

  DFFTRX1TS \fifo_from_fft/empty_det/result_reg  ( .D(n7424), .RN(n5595), .CK(
        clk), .QN(from_fft_empty) );
  DFFTRX1TS \fifo_from_fir/empty_det/result_reg  ( .D(n7424), .RN(n5575), .CK(
        clk), .QN(from_fir_empty) );
  DFFTRX1TS \mips/mips/a/accbypassA_reg  ( .D(n4310), .RN(n5165), .CK(clk), 
        .Q(acc_bypass) );
  DFFTRX1TS \mips/mips/a/fullinstructionA_reg[31]  ( .D(
        \mips/mips/accfullinstruction[31] ), .RN(n7290), .CK(clk), .Q(
        instruction[31]) );
  DFFTRX1TS \mips/mips/a/fullinstructionA_reg[30]  ( .D(
        \mips/mips/accfullinstruction[30] ), .RN(n7284), .CK(clk), .Q(
        instruction[30]) );
  DFFTRX1TS \mips/mips/a/fullinstructionA_reg[29]  ( .D(
        \mips/mips/accfullinstruction[29] ), .RN(n7284), .CK(clk), .Q(
        instruction[29]) );
  DFFTRX1TS \mips/mips/a/fullinstructionA_reg[28]  ( .D(
        \mips/mips/accfullinstruction[28] ), .RN(n7285), .CK(clk), .Q(
        instruction[28]) );
  DFFTRX1TS \mips/mips/a/fullinstructionA_reg[27]  ( .D(
        \mips/mips/accfullinstruction[27] ), .RN(n7285), .CK(clk), .Q(
        instruction[27]) );
  DFFTRX1TS \mips/mips/a/fullinstructionA_reg[26]  ( .D(
        \mips/mips/accfullinstruction[26] ), .RN(n7285), .CK(clk), .Q(
        instruction[26]) );
  DFFTRX1TS \mips/mips/a/fullinstructionA_reg[0]  ( .D(
        \mips/mips/accfullinstruction[0] ), .RN(n7285), .CK(clk), .Q(
        instruction[0]) );
  DFFTRX1TS \mips/mips/a/fullinstructionA_reg[2]  ( .D(
        \mips/mips/accfullinstruction[2] ), .RN(n7286), .CK(clk), .Q(
        instruction[2]) );
  DFFTRX1TS \mips/mips/a/fullinstructionA_reg[3]  ( .D(
        \mips/mips/accfullinstruction[3] ), .RN(n7286), .CK(clk), .Q(
        instruction[3]) );
  DFFTRX1TS \mips/mips/a/fullinstructionA_reg[4]  ( .D(
        \mips/mips/accfullinstruction[4] ), .RN(n7286), .CK(clk), .Q(
        instruction[4]) );
  DFFTRX1TS \mips/mips/a/fullinstructionA_reg[5]  ( .D(
        \mips/mips/accfullinstruction[5] ), .RN(n7286), .CK(clk), .Q(
        instruction[5]) );
  DFFTRX1TS \mips/mips/a/fullinstructionA_reg[6]  ( .D(
        \mips/mips/accfullinstruction[6] ), .RN(n7287), .CK(clk), .Q(
        instruction[6]) );
  DFFTRX1TS \mips/mips/a/fullinstructionA_reg[7]  ( .D(
        \mips/mips/accfullinstruction[7] ), .RN(n7287), .CK(clk), .Q(
        instruction[7]) );
  DFFTRX1TS \mips/mips/a/fullinstructionA_reg[8]  ( .D(
        \mips/mips/accfullinstruction[8] ), .RN(n7287), .CK(clk), .Q(
        instruction[8]) );
  DFFTRX1TS \mips/mips/a/fullinstructionA_reg[9]  ( .D(
        \mips/mips/accfullinstruction[9] ), .RN(n7287), .CK(clk), .Q(
        instruction[9]) );
  DFFTRX1TS \mips/mips/a/fullinstructionA_reg[10]  ( .D(
        \mips/mips/accfullinstruction[10] ), .RN(n7291), .CK(clk), .Q(
        instruction[10]) );
  DFFTRX1TS \mips/mips/a/fullinstructionA_reg[11]  ( .D(
        \mips/mips/accfullinstruction[11] ), .RN(n7291), .CK(clk), .Q(
        instruction[11]) );
  DFFTRX1TS \mips/mips/a/fullinstructionA_reg[12]  ( .D(
        \mips/mips/accfullinstruction[12] ), .RN(n7291), .CK(clk), .Q(
        instruction[12]) );
  DFFTRX1TS \mips/mips/a/fullinstructionA_reg[13]  ( .D(
        \mips/mips/accfullinstruction[13] ), .RN(n7288), .CK(clk), .Q(
        instruction[13]) );
  DFFTRX1TS \mips/mips/a/fullinstructionA_reg[14]  ( .D(
        \mips/mips/accfullinstruction[14] ), .RN(n7288), .CK(clk), .Q(
        instruction[14]) );
  DFFTRX1TS \mips/mips/a/fullinstructionA_reg[15]  ( .D(
        \mips/mips/accfullinstruction[15] ), .RN(n7288), .CK(clk), .Q(
        instruction[15]) );
  DFFTRX1TS \mips/mips/a/fullinstructionA_reg[16]  ( .D(
        \mips/mips/accfullinstruction[16] ), .RN(n7288), .CK(clk), .Q(
        instruction[16]) );
  DFFTRX1TS \mips/mips/a/fullinstructionA_reg[17]  ( .D(
        \mips/mips/accfullinstruction[17] ), .RN(n7290), .CK(clk), .Q(
        instruction[17]) );
  DFFTRX1TS \mips/mips/a/fullinstructionA_reg[18]  ( .D(
        \mips/mips/accfullinstruction[18] ), .RN(n7293), .CK(clk), .Q(
        instruction[18]) );
  DFFTRX1TS \mips/mips/a/fullinstructionA_reg[19]  ( .D(
        \mips/mips/accfullinstruction[19] ), .RN(n7292), .CK(clk), .Q(
        instruction[19]) );
  DFFTRX1TS \mips/mips/a/fullinstructionA_reg[20]  ( .D(
        \mips/mips/accfullinstruction[20] ), .RN(n7292), .CK(clk), .Q(
        instruction[20]) );
  DFFTRX1TS \mips/mips/a/fullinstructionA_reg[21]  ( .D(
        \mips/mips/accfullinstruction[21] ), .RN(n7289), .CK(clk), .Q(
        instruction[21]) );
  DFFTRX1TS \mips/mips/a/fullinstructionA_reg[22]  ( .D(
        \mips/mips/accfullinstruction[22] ), .RN(n7289), .CK(clk), .Q(
        instruction[22]) );
  DFFTRX1TS \mips/mips/a/fullinstructionA_reg[23]  ( .D(
        \mips/mips/accfullinstruction[23] ), .RN(n7289), .CK(clk), .Q(
        instruction[23]) );
  DFFTRX1TS \mips/mips/a/fullinstructionA_reg[24]  ( .D(
        \mips/mips/accfullinstruction[24] ), .RN(n7289), .CK(clk), .Q(
        instruction[24]) );
  DFFTRX1TS \mips/mips/a/fullinstructionA_reg[25]  ( .D(
        \mips/mips/accfullinstruction[25] ), .RN(n7284), .CK(clk), .Q(
        instruction[25]) );
  DFFTRX1TS \fifo_from_fft/fifo_cell13/hold_token_reg  ( .D(n6332), .RN(
        \fifo_from_fft/fifo_cell14/data_out/N35 ), .CK(clk), .Q(
        \fifo_from_fft/hold[13] ) );
  DFFTRX1TS \fifo_from_fft/fifo_cell12/hold_token_reg  ( .D(n6335), .RN(
        \fifo_from_fft/fifo_cell13/data_out/N35 ), .CK(clk), .Q(
        \fifo_from_fft/hold[12] ) );
  DFFTRX1TS \fifo_from_fft/fifo_cell11/hold_token_reg  ( .D(n6341), .RN(
        \fifo_from_fft/fifo_cell12/data_out/N35 ), .CK(clk), .Q(
        \fifo_from_fft/hold[11] ) );
  DFFTRX1TS \fifo_from_fft/fifo_cell10/hold_token_reg  ( .D(n6344), .RN(
        \fifo_from_fft/fifo_cell11/data_out/N35 ), .CK(clk), .Q(
        \fifo_from_fft/hold[10] ) );
  DFFTRX1TS \fifo_from_fft/fifo_cell9/hold_token_reg  ( .D(n6350), .RN(
        \fifo_from_fft/fifo_cell10/data_out/N35 ), .CK(clk), .Q(
        \fifo_from_fft/hold[9] ) );
  DFFTRX1TS \fifo_from_fft/fifo_cell8/hold_token_reg  ( .D(n6353), .RN(
        \fifo_from_fft/fifo_cell9/data_out/N35 ), .CK(clk), .Q(
        \fifo_from_fft/hold[8] ) );
  DFFTRX1TS \fifo_from_fft/fifo_cell7/hold_token_reg  ( .D(n6359), .RN(
        \fifo_from_fft/fifo_cell8/data_out/N35 ), .CK(clk), .Q(
        \fifo_from_fft/hold[7] ) );
  DFFTRX1TS \fifo_from_fft/fifo_cell6/hold_token_reg  ( .D(n6362), .RN(
        \fifo_from_fft/fifo_cell7/data_out/N35 ), .CK(clk), .Q(
        \fifo_from_fft/hold[6] ) );
  DFFTRX1TS \fifo_from_fft/fifo_cell5/hold_token_reg  ( .D(n6368), .RN(
        \fifo_from_fft/fifo_cell6/data_out/N35 ), .CK(clk), .Q(
        \fifo_from_fft/hold[5] ) );
  DFFTRX1TS \fifo_from_fft/fifo_cell4/hold_token_reg  ( .D(n6371), .RN(
        \fifo_from_fft/fifo_cell5/data_out/N35 ), .CK(clk), .Q(
        \fifo_from_fft/hold[4] ) );
  DFFTRX1TS \fifo_from_fft/fifo_cell3/hold_token_reg  ( .D(n6377), .RN(
        \fifo_from_fft/fifo_cell4/data_out/N35 ), .CK(clk), .Q(
        \fifo_from_fft/hold[3] ) );
  DFFTRX1TS \fifo_from_fft/fifo_cell2/hold_token_reg  ( .D(n6380), .RN(
        \fifo_from_fft/fifo_cell3/data_out/N35 ), .CK(clk), .Q(
        \fifo_from_fft/hold[2] ) );
  DFFTRX1TS \fifo_from_fft/fifo_cell1/hold_token_reg  ( .D(n6383), .RN(
        \fifo_from_fft/fifo_cell2/data_out/N35 ), .CK(clk), .Q(
        \fifo_from_fft/hold[1] ) );
  DFFTRX1TS \fifo_from_fft/fifo_cell0/hold_token_reg  ( .D(n6260), .RN(
        \fifo_from_fft/fifo_cell1/data_out/N35 ), .CK(clk), .Q(
        \fifo_from_fft/hold[0] ) );
  EDFFX1TS \fifo_to_fft/fifo_cell1/controller/f_i_put_reg  ( .D(n4714), .E(
        n3808), .CK(clk), .Q(\fifo_to_fft/fifo_cell1/controller/f_i_put ) );
  EDFFX1TS \fifo_to_fft/fifo_cell15/controller/f_i_put_reg  ( .D(n6687), .E(
        n4740), .CK(clk), .Q(\fifo_to_fft/fifo_cell15/controller/f_i_put ) );
  DFFTRX1TS \fifo_from_fir/fifo_cell13/hold_token_reg  ( .D(n6269), .RN(
        \fifo_from_fir/fifo_cell14/data_out/N35 ), .CK(clk), .Q(
        \fifo_from_fir/hold[13] ) );
  DFFTRX1TS \fifo_from_fir/fifo_cell12/hold_token_reg  ( .D(n6272), .RN(
        \fifo_from_fir/fifo_cell13/data_out/N35 ), .CK(clk), .Q(
        \fifo_from_fir/hold[12] ) );
  DFFTRX1TS \fifo_from_fir/fifo_cell11/hold_token_reg  ( .D(n6278), .RN(
        \fifo_from_fir/fifo_cell12/data_out/N35 ), .CK(clk), .Q(
        \fifo_from_fir/hold[11] ) );
  DFFTRX1TS \fifo_from_fir/fifo_cell10/hold_token_reg  ( .D(n6281), .RN(
        \fifo_from_fir/fifo_cell11/data_out/N35 ), .CK(clk), .Q(
        \fifo_from_fir/hold[10] ) );
  DFFTRX1TS \fifo_from_fir/fifo_cell9/hold_token_reg  ( .D(n6287), .RN(
        \fifo_from_fir/fifo_cell10/data_out/N35 ), .CK(clk), .Q(
        \fifo_from_fir/hold[9] ) );
  DFFTRX1TS \fifo_from_fir/fifo_cell8/hold_token_reg  ( .D(n6290), .RN(
        \fifo_from_fir/fifo_cell9/data_out/N35 ), .CK(clk), .Q(
        \fifo_from_fir/hold[8] ) );
  DFFTRX1TS \fifo_from_fir/fifo_cell7/hold_token_reg  ( .D(n6296), .RN(
        \fifo_from_fir/fifo_cell8/data_out/N35 ), .CK(clk), .Q(
        \fifo_from_fir/hold[7] ) );
  DFFTRX1TS \fifo_from_fir/fifo_cell6/hold_token_reg  ( .D(n6299), .RN(
        \fifo_from_fir/fifo_cell7/data_out/N35 ), .CK(clk), .Q(
        \fifo_from_fir/hold[6] ) );
  DFFTRX1TS \fifo_from_fir/fifo_cell5/hold_token_reg  ( .D(n6305), .RN(
        \fifo_from_fir/fifo_cell6/data_out/N35 ), .CK(clk), .Q(
        \fifo_from_fir/hold[5] ) );
  DFFTRX1TS \fifo_from_fir/fifo_cell4/hold_token_reg  ( .D(n6308), .RN(
        \fifo_from_fir/fifo_cell5/data_out/N35 ), .CK(clk), .Q(
        \fifo_from_fir/hold[4] ) );
  DFFTRX1TS \fifo_from_fir/fifo_cell3/hold_token_reg  ( .D(n6314), .RN(
        \fifo_from_fir/fifo_cell4/data_out/N35 ), .CK(clk), .Q(
        \fifo_from_fir/hold[3] ) );
  DFFTRX1TS \fifo_from_fir/fifo_cell2/hold_token_reg  ( .D(n6317), .RN(
        \fifo_from_fir/fifo_cell3/data_out/N35 ), .CK(clk), .Q(
        \fifo_from_fir/hold[2] ) );
  DFFTRX1TS \fifo_from_fir/fifo_cell1/hold_token_reg  ( .D(n6323), .RN(
        \fifo_from_fir/fifo_cell2/data_out/N35 ), .CK(clk), .Q(
        \fifo_from_fir/hold[1] ) );
  DFFTRX1TS \fifo_from_fir/fifo_cell0/hold_token_reg  ( .D(n6254), .RN(
        \fifo_from_fir/fifo_cell1/data_out/N35 ), .CK(clk), .Q(
        \fifo_from_fir/hold[0] ) );
  EDFFX1TS \fifo_to_fir/fifo_cell1/controller/f_i_put_reg  ( .D(n7069), .E(
        n3760), .CK(clk), .Q(\fifo_to_fir/fifo_cell1/controller/f_i_put ) );
  EDFFX1TS \fifo_to_fir/fifo_cell15/controller/f_i_put_reg  ( .D(n7066), .E(
        n4810), .CK(clk), .Q(\fifo_to_fir/fifo_cell15/controller/f_i_put ) );
  TLATXLTS \router/data_cntl/data_from_iir_reg  ( .G(\router/data_cntl/N159 ), 
        .D(\router/data_cntl/N160 ), .Q(n6899), .QN(n4725) );
  TLATXLTS \router/data_cntl/data_to_fir_reg  ( .G(\router/data_cntl/N155 ), 
        .D(\router/data_cntl/N154 ), .Q(n6898), .QN(n4794) );
  TLATXLTS \router/data_cntl/data_from_fft_reg  ( .G(\router/data_cntl/N151 ), 
        .D(\router/data_cntl/N150 ), .Q(\router/data_from_fft ), .QN(n6897) );
  TLATXLTS \router/data_cntl/data_to_fft_reg  ( .G(\router/data_cntl/N151 ), 
        .D(\router/data_cntl/N152 ), .Q(\router/data_to_fft ), .QN(n6896) );
  DFFXLTS \router/addr_calc/fft_read_calc/counter/done_reg  ( .D(n5812), .CK(
        clk), .Q(\router/fft_read_done ), .QN(n6895) );
  TLATXLTS \router/data_cntl/data_from_fir_reg  ( .G(\router/data_cntl/N155 ), 
        .D(\router/data_cntl/N156 ), .Q(\router/data_from_fir ), .QN(n6894) );
  DFFXLTS \router/addr_calc/to_fft_go_reg  ( .D(n5634), .CK(clk), .Q(n1481), 
        .QN(\router/addr_calc/N9 ) );
  DFFXLTS \router/addr_calc/from_fft_go_reg  ( .D(n5635), .CK(clk), .Q(n1417), 
        .QN(\router/addr_calc/N63 ) );
  DFFXLTS \router/addr_calc/to_fir_go_reg  ( .D(n5722), .CK(clk), .Q(n1353), 
        .QN(\router/addr_calc/N95 ) );
  DFFXLTS \router/addr_calc/from_fir_go_reg  ( .D(n5723), .CK(clk), .Q(n1289), 
        .QN(\router/addr_calc/N99 ) );
  DFFTRX2TS \router/addr_calc/from_iir_go_reg  ( .D(\router/data_cntl/N160 ), 
        .RN(n6899), .CK(clk), .Q(n1161), .QN(n6204) );
  TLATXLTS \mips/mips/a/countflag_reg  ( .G(\mips/mips/a/N50 ), .D(
        \mips/mips/a/N49 ), .Q(\mips/mips/a/countflag ), .QN(n4310) );
  DFFQX1TS \fifo_from_fft/fifo_cell0/controller/valid_read_reg  ( .D(n7404), 
        .CK(clk), .Q(\fifo_from_fft/fifo_cell0/controller/valid_read ) );
  DFFQX1TS \fifo_from_fft/fifo_cell1/controller/valid_read_reg  ( .D(n7408), 
        .CK(clk), .Q(\fifo_from_fft/fifo_cell1/controller/valid_read ) );
  DFFQX1TS \fifo_from_fft/fifo_cell2/controller/valid_read_reg  ( .D(n7405), 
        .CK(clk), .Q(\fifo_from_fft/fifo_cell2/controller/valid_read ) );
  DFFQX1TS \fifo_from_fft/fifo_cell3/controller/valid_read_reg  ( .D(n7405), 
        .CK(clk), .Q(\fifo_from_fft/fifo_cell3/controller/valid_read ) );
  DFFQX1TS \fifo_from_fft/fifo_cell4/controller/valid_read_reg  ( .D(n7405), 
        .CK(clk), .Q(\fifo_from_fft/fifo_cell4/controller/valid_read ) );
  DFFQX1TS \fifo_from_fft/fifo_cell5/controller/valid_read_reg  ( .D(n7405), 
        .CK(clk), .Q(\fifo_from_fft/fifo_cell5/controller/valid_read ) );
  DFFQX1TS \fifo_from_fft/fifo_cell6/controller/valid_read_reg  ( .D(n7406), 
        .CK(clk), .Q(\fifo_from_fft/fifo_cell6/controller/valid_read ) );
  DFFQX1TS \fifo_from_fft/fifo_cell7/controller/valid_read_reg  ( .D(n7406), 
        .CK(clk), .Q(\fifo_from_fft/fifo_cell7/controller/valid_read ) );
  DFFQX1TS \fifo_from_fft/fifo_cell8/controller/valid_read_reg  ( .D(n7406), 
        .CK(clk), .Q(\fifo_from_fft/fifo_cell8/controller/valid_read ) );
  DFFQX1TS \fifo_from_fft/fifo_cell9/controller/valid_read_reg  ( .D(n7406), 
        .CK(clk), .Q(\fifo_from_fft/fifo_cell9/controller/valid_read ) );
  DFFQX1TS \fifo_from_fft/fifo_cell10/controller/valid_read_reg  ( .D(n7407), 
        .CK(clk), .Q(\fifo_from_fft/fifo_cell10/controller/valid_read ) );
  DFFQX1TS \fifo_from_fft/fifo_cell11/controller/valid_read_reg  ( .D(n7407), 
        .CK(clk), .Q(\fifo_from_fft/fifo_cell11/controller/valid_read ) );
  DFFQX1TS \fifo_from_fft/fifo_cell12/controller/valid_read_reg  ( .D(n7407), 
        .CK(clk), .Q(\fifo_from_fft/fifo_cell12/controller/valid_read ) );
  DFFQX1TS \fifo_from_fft/fifo_cell13/controller/valid_read_reg  ( .D(n7407), 
        .CK(clk), .Q(\fifo_from_fft/fifo_cell13/controller/valid_read ) );
  DFFQX1TS \fifo_from_fft/fifo_cell14/controller/valid_read_reg  ( .D(n7413), 
        .CK(clk), .Q(\fifo_from_fft/fifo_cell14/controller/valid_read ) );
  DFFQX1TS \fifo_from_fft/fifo_cell15/controller/valid_read_reg  ( .D(n7408), 
        .CK(clk), .Q(\fifo_from_fft/fifo_cell15/controller/valid_read ) );
  DFFQX1TS \fifo_from_fir/fifo_cell0/controller/valid_read_reg  ( .D(n7413), 
        .CK(clk), .Q(\fifo_from_fir/fifo_cell0/controller/valid_read ) );
  DFFQX1TS \fifo_from_fir/fifo_cell1/controller/valid_read_reg  ( .D(n7413), 
        .CK(clk), .Q(\fifo_from_fir/fifo_cell1/controller/valid_read ) );
  DFFQX1TS \fifo_from_fir/fifo_cell2/controller/valid_read_reg  ( .D(n7413), 
        .CK(clk), .Q(\fifo_from_fir/fifo_cell2/controller/valid_read ) );
  DFFQX1TS \fifo_from_fir/fifo_cell3/controller/valid_read_reg  ( .D(n7414), 
        .CK(clk), .Q(\fifo_from_fir/fifo_cell3/controller/valid_read ) );
  DFFQX1TS \fifo_from_fir/fifo_cell4/controller/valid_read_reg  ( .D(n7414), 
        .CK(clk), .Q(\fifo_from_fir/fifo_cell4/controller/valid_read ) );
  DFFQX1TS \fifo_from_fir/fifo_cell5/controller/valid_read_reg  ( .D(n7414), 
        .CK(clk), .Q(\fifo_from_fir/fifo_cell5/controller/valid_read ) );
  DFFQX1TS \fifo_from_fir/fifo_cell6/controller/valid_read_reg  ( .D(n7414), 
        .CK(clk), .Q(\fifo_from_fir/fifo_cell6/controller/valid_read ) );
  DFFQX1TS \fifo_from_fir/fifo_cell7/controller/valid_read_reg  ( .D(n7415), 
        .CK(clk), .Q(\fifo_from_fir/fifo_cell7/controller/valid_read ) );
  DFFQX1TS \fifo_from_fir/fifo_cell8/controller/valid_read_reg  ( .D(n7415), 
        .CK(clk), .Q(\fifo_from_fir/fifo_cell8/controller/valid_read ) );
  DFFQX1TS \fifo_from_fir/fifo_cell9/controller/valid_read_reg  ( .D(n7415), 
        .CK(clk), .Q(\fifo_from_fir/fifo_cell9/controller/valid_read ) );
  DFFQX1TS \fifo_from_fir/fifo_cell10/controller/valid_read_reg  ( .D(n7415), 
        .CK(clk), .Q(\fifo_from_fir/fifo_cell10/controller/valid_read ) );
  DFFQX1TS \fifo_from_fir/fifo_cell11/controller/valid_read_reg  ( .D(n7416), 
        .CK(clk), .Q(\fifo_from_fir/fifo_cell11/controller/valid_read ) );
  DFFQX1TS \fifo_from_fir/fifo_cell12/controller/valid_read_reg  ( .D(n7416), 
        .CK(clk), .Q(\fifo_from_fir/fifo_cell12/controller/valid_read ) );
  DFFQX1TS \fifo_from_fir/fifo_cell13/controller/valid_read_reg  ( .D(n7416), 
        .CK(clk), .Q(\fifo_from_fir/fifo_cell13/controller/valid_read ) );
  DFFQX1TS \fifo_from_fir/fifo_cell14/controller/valid_read_reg  ( .D(n7416), 
        .CK(clk), .Q(\fifo_from_fir/fifo_cell14/controller/valid_read ) );
  DFFQX1TS \fifo_from_fir/fifo_cell15/controller/valid_read_reg  ( .D(n7417), 
        .CK(clk), .Q(\fifo_from_fir/fifo_cell15/controller/valid_read ) );
  DFFQX1TS \fifo_to_fft/fifo_cell0/controller/valid_read_reg  ( .D(n7417), 
        .CK(clk), .Q(\fifo_to_fft/fifo_cell0/controller/valid_read ) );
  DFFQX1TS \fifo_to_fir/fifo_cell0/controller/valid_read_reg  ( .D(n7409), 
        .CK(clk), .Q(\fifo_to_fir/fifo_cell0/controller/valid_read ) );
  DFFQX1TS \fifo_to_fft/fifo_cell1/controller/valid_read_reg  ( .D(n7408), 
        .CK(clk), .Q(\fifo_to_fft/fifo_cell1/controller/valid_read ) );
  DFFQX1TS \fifo_to_fft/fifo_cell2/controller/valid_read_reg  ( .D(n7401), 
        .CK(clk), .Q(\fifo_to_fft/fifo_cell2/controller/valid_read ) );
  DFFQX1TS \fifo_to_fft/fifo_cell3/controller/valid_read_reg  ( .D(n7401), 
        .CK(clk), .Q(\fifo_to_fft/fifo_cell3/controller/valid_read ) );
  DFFQX1TS \fifo_to_fft/fifo_cell4/controller/valid_read_reg  ( .D(n7402), 
        .CK(clk), .Q(\fifo_to_fft/fifo_cell4/controller/valid_read ) );
  DFFQX1TS \fifo_to_fft/fifo_cell5/controller/valid_read_reg  ( .D(n7402), 
        .CK(clk), .Q(\fifo_to_fft/fifo_cell5/controller/valid_read ) );
  DFFQX1TS \fifo_to_fft/fifo_cell6/controller/valid_read_reg  ( .D(n7402), 
        .CK(clk), .Q(\fifo_to_fft/fifo_cell6/controller/valid_read ) );
  DFFQX1TS \fifo_to_fft/fifo_cell7/controller/valid_read_reg  ( .D(n7402), 
        .CK(clk), .Q(\fifo_to_fft/fifo_cell7/controller/valid_read ) );
  DFFQX1TS \fifo_to_fft/fifo_cell8/controller/valid_read_reg  ( .D(n7408), 
        .CK(clk), .Q(\fifo_to_fft/fifo_cell8/controller/valid_read ) );
  DFFQX1TS \fifo_to_fft/fifo_cell9/controller/valid_read_reg  ( .D(n7403), 
        .CK(clk), .Q(\fifo_to_fft/fifo_cell9/controller/valid_read ) );
  DFFQX1TS \fifo_to_fft/fifo_cell10/controller/valid_read_reg  ( .D(n7403), 
        .CK(clk), .Q(\fifo_to_fft/fifo_cell10/controller/valid_read ) );
  DFFQX1TS \fifo_to_fft/fifo_cell11/controller/valid_read_reg  ( .D(n7403), 
        .CK(clk), .Q(\fifo_to_fft/fifo_cell11/controller/valid_read ) );
  DFFQX1TS \fifo_to_fft/fifo_cell12/controller/valid_read_reg  ( .D(n7403), 
        .CK(clk), .Q(\fifo_to_fft/fifo_cell12/controller/valid_read ) );
  DFFQX1TS \fifo_to_fft/fifo_cell13/controller/valid_read_reg  ( .D(n7404), 
        .CK(clk), .Q(\fifo_to_fft/fifo_cell13/controller/valid_read ) );
  DFFQX1TS \fifo_to_fft/fifo_cell14/controller/valid_read_reg  ( .D(n7404), 
        .CK(clk), .Q(\fifo_to_fft/fifo_cell14/controller/valid_read ) );
  DFFQX1TS \fifo_to_fft/fifo_cell15/controller/valid_read_reg  ( .D(n7404), 
        .CK(clk), .Q(\fifo_to_fft/fifo_cell15/controller/valid_read ) );
  DFFQX1TS \fifo_to_fir/fifo_cell1/controller/valid_read_reg  ( .D(n7409), 
        .CK(clk), .Q(\fifo_to_fir/fifo_cell1/controller/valid_read ) );
  DFFQX1TS \fifo_to_fir/fifo_cell2/controller/valid_read_reg  ( .D(n7409), 
        .CK(clk), .Q(\fifo_to_fir/fifo_cell2/controller/valid_read ) );
  DFFQX1TS \fifo_to_fir/fifo_cell3/controller/valid_read_reg  ( .D(n7409), 
        .CK(clk), .Q(\fifo_to_fir/fifo_cell3/controller/valid_read ) );
  DFFQX1TS \fifo_to_fir/fifo_cell4/controller/valid_read_reg  ( .D(n7410), 
        .CK(clk), .Q(\fifo_to_fir/fifo_cell4/controller/valid_read ) );
  DFFQX1TS \fifo_to_fir/fifo_cell5/controller/valid_read_reg  ( .D(n7410), 
        .CK(clk), .Q(\fifo_to_fir/fifo_cell5/controller/valid_read ) );
  DFFQX1TS \fifo_to_fir/fifo_cell6/controller/valid_read_reg  ( .D(n7410), 
        .CK(clk), .Q(\fifo_to_fir/fifo_cell6/controller/valid_read ) );
  DFFQX1TS \fifo_to_fir/fifo_cell7/controller/valid_read_reg  ( .D(n7410), 
        .CK(clk), .Q(\fifo_to_fir/fifo_cell7/controller/valid_read ) );
  DFFQX1TS \fifo_to_fir/fifo_cell8/controller/valid_read_reg  ( .D(n7411), 
        .CK(clk), .Q(\fifo_to_fir/fifo_cell8/controller/valid_read ) );
  DFFQX1TS \fifo_to_fir/fifo_cell9/controller/valid_read_reg  ( .D(n7411), 
        .CK(clk), .Q(\fifo_to_fir/fifo_cell9/controller/valid_read ) );
  DFFQX1TS \fifo_to_fir/fifo_cell10/controller/valid_read_reg  ( .D(n7411), 
        .CK(clk), .Q(\fifo_to_fir/fifo_cell10/controller/valid_read ) );
  DFFQX1TS \fifo_to_fir/fifo_cell11/controller/valid_read_reg  ( .D(n7411), 
        .CK(clk), .Q(\fifo_to_fir/fifo_cell11/controller/valid_read ) );
  DFFQX1TS \fifo_to_fir/fifo_cell12/controller/valid_read_reg  ( .D(n7412), 
        .CK(clk), .Q(\fifo_to_fir/fifo_cell12/controller/valid_read ) );
  DFFQX1TS \fifo_to_fir/fifo_cell13/controller/valid_read_reg  ( .D(n7412), 
        .CK(clk), .Q(\fifo_to_fir/fifo_cell13/controller/valid_read ) );
  DFFQX1TS \fifo_to_fir/fifo_cell14/controller/valid_read_reg  ( .D(n7412), 
        .CK(clk), .Q(\fifo_to_fir/fifo_cell14/controller/valid_read ) );
  DFFQX1TS \fifo_to_fir/fifo_cell15/controller/valid_read_reg  ( .D(n7412), 
        .CK(clk), .Q(\fifo_to_fir/fifo_cell15/controller/valid_read ) );
  DFFQX1TS \fifo_from_fft/fifo_cell15/reg_gtok/token_reg  ( .D(n5652), .CK(clk), .Q(\fifo_from_fft/fifo_cell15/reg_gtok/token ) );
  DFFQX1TS \fifo_from_fir/fifo_cell15/reg_gtok/token_reg  ( .D(n5793), .CK(clk), .Q(\fifo_from_fir/fifo_cell15/reg_gtok/token ) );
  DFFQX1TS \fifo_to_fft/fifo_cell0/reg_ptok/token_reg  ( .D(n5719), .CK(clk), 
        .Q(\fifo_to_fft/tok_xnor_put ) );
  DFFQX1TS \fifo_to_fir/fifo_cell0/reg_ptok/token_reg  ( .D(n5768), .CK(clk), 
        .Q(\fifo_to_fir/tok_xnor_put ) );
  DFFQX1TS \mips/mips/a/count_reg[0]  ( .D(n5941), .CK(clk), .Q(
        \mips/mips/a/count[0] ) );
  DFFQX1TS \fifo_to_fft/fifo_cell1/reg_ptok/token_reg  ( .D(n5718), .CK(clk), 
        .Q(\fifo_to_fft/hang[0] ) );
  DFFQX1TS \fifo_to_fir/fifo_cell1/reg_ptok/token_reg  ( .D(n5767), .CK(clk), 
        .Q(\fifo_to_fir/hang[0] ) );
  DFFQX1TS \fifo_to_fft/fifo_cell2/reg_ptok/token_reg  ( .D(n5717), .CK(clk), 
        .Q(\fifo_to_fft/hang[1] ) );
  DFFQX1TS \fifo_to_fir/fifo_cell2/reg_ptok/token_reg  ( .D(n5766), .CK(clk), 
        .Q(\fifo_to_fir/hang[1] ) );
  DFFXLTS \mips/mips/a/count_reg[1]  ( .D(n5940), .CK(clk), .QN(n5162) );
  DFFQX1TS \fifo_to_fft/fifo_cell10/reg_ptok/token_reg  ( .D(n5709), .CK(clk), 
        .Q(\fifo_to_fft/hang[9] ) );
  DFFQX1TS \fifo_to_fir/fifo_cell10/reg_ptok/token_reg  ( .D(n5758), .CK(clk), 
        .Q(\fifo_to_fir/hang[9] ) );
  DFFQX1TS \fifo_to_fft/fifo_cell15/reg_ptok/token_reg  ( .D(n5704), .CK(clk), 
        .Q(\fifo_to_fft/hang[14] ) );
  DFFQX1TS \fifo_to_fir/fifo_cell15/reg_ptok/token_reg  ( .D(n5753), .CK(clk), 
        .Q(\fifo_to_fir/hang[14] ) );
  TBUFX2TS \fifo_from_fir/fifo_cell0/data_out/do_tri[31]  ( .A(1'b0), .OE(
        n6256), .Y(fir_data_in[31]) );
  TBUFX2TS \fifo_from_fir/fifo_cell0/data_out/do_tri[25]  ( .A(1'b0), .OE(
        n6255), .Y(fir_data_in[25]) );
  TBUFX2TS \fifo_from_fir/fifo_cell0/data_out/do_tri[24]  ( .A(1'b0), .OE(
        n6256), .Y(fir_data_in[24]) );
  TBUFX2TS \fifo_from_fir/fifo_cell0/data_out/do_tri[19]  ( .A(1'b0), .OE(
        n6255), .Y(fir_data_in[19]) );
  DFFXLTS \fifo_from_fft/fifo_cell0/data_out/en_reg  ( .D(
        \fifo_from_fft/fifo_cell0/data_out/N35 ), .CK(clk), .Q(n6172), .QN(
        n6260) );
  DFFXLTS \fifo_from_fir/fifo_cell0/data_out/en_reg  ( .D(
        \fifo_from_fir/fifo_cell0/data_out/N35 ), .CK(clk), .Q(n6171), .QN(
        n6254) );
  DFFQX1TS \fifo_from_fft/fifo_cell5/reg_gtok/token_reg  ( .D(n5662), .CK(clk), 
        .Q(\fifo_from_fft/fifo_cell5/reg_gtok/token ) );
  DFFQX1TS \fifo_from_fft/fifo_cell6/reg_gtok/token_reg  ( .D(n5661), .CK(clk), 
        .Q(\fifo_from_fft/fifo_cell6/reg_gtok/token ) );
  DFFQX1TS \fifo_from_fft/fifo_cell7/reg_gtok/token_reg  ( .D(n5660), .CK(clk), 
        .Q(\fifo_from_fft/fifo_cell7/reg_gtok/token ) );
  DFFQX1TS \fifo_from_fft/fifo_cell8/reg_gtok/token_reg  ( .D(n5659), .CK(clk), 
        .Q(\fifo_from_fft/fifo_cell8/reg_gtok/token ) );
  DFFQX1TS \fifo_from_fft/fifo_cell9/reg_gtok/token_reg  ( .D(n5658), .CK(clk), 
        .Q(\fifo_from_fft/fifo_cell9/reg_gtok/token ) );
  DFFQX1TS \fifo_from_fft/fifo_cell10/reg_gtok/token_reg  ( .D(n5657), .CK(clk), .Q(\fifo_from_fft/fifo_cell10/reg_gtok/token ) );
  DFFQX1TS \fifo_from_fft/fifo_cell11/reg_gtok/token_reg  ( .D(n5656), .CK(clk), .Q(\fifo_from_fft/fifo_cell11/reg_gtok/token ) );
  DFFQX1TS \fifo_from_fft/fifo_cell12/reg_gtok/token_reg  ( .D(n5655), .CK(clk), .Q(\fifo_from_fft/fifo_cell12/reg_gtok/token ) );
  DFFQX1TS \fifo_from_fft/fifo_cell13/reg_gtok/token_reg  ( .D(n5654), .CK(clk), .Q(\fifo_from_fft/fifo_cell13/reg_gtok/token ) );
  DFFQX1TS \fifo_from_fft/fifo_cell0/reg_gtok/token_reg  ( .D(n5667), .CK(clk), 
        .Q(\fifo_from_fft/fifo_cell0/reg_gtok/token ) );
  DFFQX1TS \fifo_from_fir/fifo_cell5/reg_gtok/token_reg  ( .D(n5803), .CK(clk), 
        .Q(\fifo_from_fir/fifo_cell5/reg_gtok/token ) );
  DFFQX1TS \fifo_from_fir/fifo_cell6/reg_gtok/token_reg  ( .D(n5802), .CK(clk), 
        .Q(\fifo_from_fir/fifo_cell6/reg_gtok/token ) );
  DFFQX1TS \fifo_from_fir/fifo_cell7/reg_gtok/token_reg  ( .D(n5801), .CK(clk), 
        .Q(\fifo_from_fir/fifo_cell7/reg_gtok/token ) );
  DFFQX1TS \fifo_from_fir/fifo_cell8/reg_gtok/token_reg  ( .D(n5800), .CK(clk), 
        .Q(\fifo_from_fir/fifo_cell8/reg_gtok/token ) );
  DFFQX1TS \fifo_from_fir/fifo_cell9/reg_gtok/token_reg  ( .D(n5799), .CK(clk), 
        .Q(\fifo_from_fir/fifo_cell9/reg_gtok/token ) );
  DFFQX1TS \fifo_from_fir/fifo_cell10/reg_gtok/token_reg  ( .D(n5798), .CK(clk), .Q(\fifo_from_fir/fifo_cell10/reg_gtok/token ) );
  DFFQX1TS \fifo_from_fir/fifo_cell11/reg_gtok/token_reg  ( .D(n5797), .CK(clk), .Q(\fifo_from_fir/fifo_cell11/reg_gtok/token ) );
  DFFQX1TS \fifo_from_fir/fifo_cell12/reg_gtok/token_reg  ( .D(n5796), .CK(clk), .Q(\fifo_from_fir/fifo_cell12/reg_gtok/token ) );
  DFFQX1TS \fifo_from_fir/fifo_cell13/reg_gtok/token_reg  ( .D(n5795), .CK(clk), .Q(\fifo_from_fir/fifo_cell13/reg_gtok/token ) );
  DFFQX1TS \fifo_from_fir/fifo_cell0/reg_gtok/token_reg  ( .D(n5808), .CK(clk), 
        .Q(\fifo_from_fir/fifo_cell0/reg_gtok/token ) );
  DFFQX1TS \fifo_from_fft/fifo_cell14/reg_gtok/token_reg  ( .D(n5653), .CK(clk), .Q(\fifo_from_fft/fifo_cell14/reg_gtok/token ) );
  DFFQX1TS \fifo_from_fir/fifo_cell14/reg_gtok/token_reg  ( .D(n5794), .CK(clk), .Q(\fifo_from_fir/fifo_cell14/reg_gtok/token ) );
  DFFQX1TS \fifo_to_fft/fifo_cell7/reg_ptok/token_reg  ( .D(n5712), .CK(clk), 
        .Q(\fifo_to_fft/hang[6] ) );
  DFFQX1TS \fifo_to_fir/fifo_cell7/reg_ptok/token_reg  ( .D(n5761), .CK(clk), 
        .Q(\fifo_to_fir/hang[6] ) );
  DFFQX1TS \fifo_to_fir/empty_det/result_reg  ( .D(\fifo_to_fir/empty_det/N4 ), 
        .CK(clk), .Q(to_fir_empty) );
  DFFQX1TS \fifo_to_fft/fifo_cell11/reg_ptok/token_reg  ( .D(n5708), .CK(clk), 
        .Q(\fifo_to_fft/hang[10] ) );
  DFFQX1TS \fifo_to_fir/fifo_cell11/reg_ptok/token_reg  ( .D(n5757), .CK(clk), 
        .Q(\fifo_to_fir/hang[10] ) );
  DFFQX1TS \fifo_to_fft/empty_det/result_reg  ( .D(\fifo_to_fft/empty_det/N4 ), 
        .CK(clk), .Q(to_fft_empty) );
  DFFQX1TS \fifo_to_fft/fifo_cell4/reg_ptok/token_reg  ( .D(n5715), .CK(clk), 
        .Q(\fifo_to_fft/hang[3] ) );
  DFFQX1TS \fifo_to_fft/fifo_cell14/reg_ptok/token_reg  ( .D(n5705), .CK(clk), 
        .Q(\fifo_to_fft/hang[13] ) );
  DFFQX1TS \fifo_to_fir/fifo_cell4/reg_ptok/token_reg  ( .D(n5764), .CK(clk), 
        .Q(\fifo_to_fir/hang[3] ) );
  DFFQX1TS \fifo_to_fir/fifo_cell14/reg_ptok/token_reg  ( .D(n5754), .CK(clk), 
        .Q(\fifo_to_fir/hang[13] ) );
  DFFQX1TS \fifo_to_fft/fifo_cell5/reg_ptok/token_reg  ( .D(n5714), .CK(clk), 
        .Q(\fifo_to_fft/hang[4] ) );
  DFFQX1TS \fifo_to_fft/fifo_cell8/reg_ptok/token_reg  ( .D(n5711), .CK(clk), 
        .Q(\fifo_to_fft/hang[7] ) );
  DFFQX1TS \fifo_to_fft/fifo_cell13/reg_ptok/token_reg  ( .D(n5706), .CK(clk), 
        .Q(\fifo_to_fft/hang[12] ) );
  DFFQX1TS \fifo_to_fir/fifo_cell5/reg_ptok/token_reg  ( .D(n5763), .CK(clk), 
        .Q(\fifo_to_fir/hang[4] ) );
  DFFQX1TS \fifo_to_fir/fifo_cell8/reg_ptok/token_reg  ( .D(n5760), .CK(clk), 
        .Q(\fifo_to_fir/hang[7] ) );
  DFFQX1TS \fifo_to_fir/fifo_cell13/reg_ptok/token_reg  ( .D(n5755), .CK(clk), 
        .Q(\fifo_to_fir/hang[12] ) );
  DFFQX1TS \fifo_to_fft/fifo_cell6/reg_ptok/token_reg  ( .D(n5713), .CK(clk), 
        .Q(\fifo_to_fft/hang[5] ) );
  DFFQX1TS \fifo_to_fft/fifo_cell9/reg_ptok/token_reg  ( .D(n5710), .CK(clk), 
        .Q(\fifo_to_fft/hang[8] ) );
  DFFQX1TS \fifo_to_fft/fifo_cell12/reg_ptok/token_reg  ( .D(n5707), .CK(clk), 
        .Q(\fifo_to_fft/hang[11] ) );
  DFFQX1TS \fifo_to_fir/fifo_cell6/reg_ptok/token_reg  ( .D(n5762), .CK(clk), 
        .Q(\fifo_to_fir/hang[5] ) );
  DFFQX1TS \fifo_to_fir/fifo_cell9/reg_ptok/token_reg  ( .D(n5759), .CK(clk), 
        .Q(\fifo_to_fir/hang[8] ) );
  DFFQX1TS \fifo_to_fir/fifo_cell12/reg_ptok/token_reg  ( .D(n5756), .CK(clk), 
        .Q(\fifo_to_fir/hang[11] ) );
  DFFQX1TS \router/addr_calc/iir_write_calc/counter/hold_reg  ( .D(n5947), 
        .CK(clk), .Q(\router/addr_calc/iir_write_calc/counter/hold ) );
  DFFQX1TS \router/addr_calc/fir_read_calc/counter/hold_reg  ( .D(n5721), .CK(
        clk), .Q(\router/addr_calc/fir_read_calc/counter/hold ) );
  DFFQX1TS \router/addr_calc/fft_read_calc/counter/hold_reg  ( .D(n5601), .CK(
        clk), .Q(\router/addr_calc/fft_read_calc/counter/hold ) );
  DFFQX1TS \router/addr_calc/fft_write_calc/counter/hold_reg  ( .D(n5810), 
        .CK(clk), .Q(\router/addr_calc/fft_write_calc/counter/hold ) );
  DFFQX1TS \router/addr_calc/fir_write_calc/counter/hold_reg  ( .D(n5776), 
        .CK(clk), .Q(\router/addr_calc/fir_write_calc/counter/hold ) );
  DFFQX1TS \fifo_to_fft/fifo_cell3/reg_ptok/token_reg  ( .D(n5716), .CK(clk), 
        .Q(\fifo_to_fft/hang[2] ) );
  DFFQX1TS \fifo_to_fir/fifo_cell3/reg_ptok/token_reg  ( .D(n5765), .CK(clk), 
        .Q(\fifo_to_fir/hang[2] ) );
  DFFQX1TS \router/data_cntl/data_in_reg[0]  ( .D(n5633), .CK(clk), .Q(
        \router/data_cntl/data_in[0] ) );
  DFFQX1TS \router/data_cntl/data_in_reg[22]  ( .D(n5611), .CK(clk), .Q(
        \router/data_cntl/data_in[22] ) );
  DFFQX1TS \router/data_cntl/data_in_reg[24]  ( .D(n5609), .CK(clk), .Q(
        \router/data_cntl/data_in[24] ) );
  DFFQX1TS \router/data_cntl/data_in_reg[26]  ( .D(n5607), .CK(clk), .Q(
        \router/data_cntl/data_in[26] ) );
  DFFQX1TS \router/data_cntl/data_in_reg[28]  ( .D(n5605), .CK(clk), .Q(
        \router/data_cntl/data_in[28] ) );
  DFFQX1TS \router/data_cntl/data_in_reg[3]  ( .D(n5630), .CK(clk), .Q(
        \router/data_cntl/data_in[3] ) );
  DFFQX1TS \router/data_cntl/data_in_reg[5]  ( .D(n5628), .CK(clk), .Q(
        \router/data_cntl/data_in[5] ) );
  DFFQX1TS \router/data_cntl/data_in_reg[7]  ( .D(n5626), .CK(clk), .Q(
        \router/data_cntl/data_in[7] ) );
  DFFQX1TS \router/data_cntl/data_in_reg[9]  ( .D(n5624), .CK(clk), .Q(
        \router/data_cntl/data_in[9] ) );
  DFFQX1TS \router/data_cntl/data_in_reg[11]  ( .D(n5622), .CK(clk), .Q(
        \router/data_cntl/data_in[11] ) );
  DFFQX1TS \router/data_cntl/data_in_reg[12]  ( .D(n5621), .CK(clk), .Q(
        \router/data_cntl/data_in[12] ) );
  DFFQX1TS \router/data_cntl/data_in_reg[14]  ( .D(n5619), .CK(clk), .Q(
        \router/data_cntl/data_in[14] ) );
  DFFQX1TS \router/data_cntl/data_in_reg[16]  ( .D(n5617), .CK(clk), .Q(
        \router/data_cntl/data_in[16] ) );
  DFFQX1TS \router/data_cntl/data_in_reg[18]  ( .D(n5615), .CK(clk), .Q(
        \router/data_cntl/data_in[18] ) );
  DFFQX1TS \router/data_cntl/data_in_reg[20]  ( .D(n5613), .CK(clk), .Q(
        \router/data_cntl/data_in[20] ) );
  DFFQX1TS \router/data_cntl/data_in_reg[30]  ( .D(n5603), .CK(clk), .Q(
        \router/data_cntl/data_in[30] ) );
  DFFQX1TS \router/data_cntl/data_in_reg[31]  ( .D(n5602), .CK(clk), .Q(
        \router/data_cntl/data_in[31] ) );
  DFFQX1TS \router/data_cntl/data_in_reg[21]  ( .D(n5612), .CK(clk), .Q(
        \router/data_cntl/data_in[21] ) );
  DFFQX1TS \router/data_cntl/data_in_reg[19]  ( .D(n5614), .CK(clk), .Q(
        \router/data_cntl/data_in[19] ) );
  DFFQX1TS \router/data_cntl/data_in_reg[17]  ( .D(n5616), .CK(clk), .Q(
        \router/data_cntl/data_in[17] ) );
  DFFQX1TS \router/data_cntl/data_in_reg[15]  ( .D(n5618), .CK(clk), .Q(
        \router/data_cntl/data_in[15] ) );
  DFFQX1TS \router/data_cntl/data_in_reg[13]  ( .D(n5620), .CK(clk), .Q(
        \router/data_cntl/data_in[13] ) );
  DFFQX1TS \router/data_cntl/data_in_reg[29]  ( .D(n5604), .CK(clk), .Q(
        \router/data_cntl/data_in[29] ) );
  DFFQX1TS \router/data_cntl/data_in_reg[10]  ( .D(n5623), .CK(clk), .Q(
        \router/data_cntl/data_in[10] ) );
  DFFQX1TS \router/data_cntl/data_in_reg[8]  ( .D(n5625), .CK(clk), .Q(
        \router/data_cntl/data_in[8] ) );
  DFFQX1TS \router/data_cntl/data_in_reg[6]  ( .D(n5627), .CK(clk), .Q(
        \router/data_cntl/data_in[6] ) );
  DFFQX1TS \router/data_cntl/data_in_reg[4]  ( .D(n5629), .CK(clk), .Q(
        \router/data_cntl/data_in[4] ) );
  DFFQX1TS \router/data_cntl/data_in_reg[2]  ( .D(n5631), .CK(clk), .Q(
        \router/data_cntl/data_in[2] ) );
  DFFQX1TS \router/data_cntl/data_in_reg[1]  ( .D(n5632), .CK(clk), .Q(
        \router/data_cntl/data_in[1] ) );
  DFFQX1TS \router/data_cntl/data_in_reg[27]  ( .D(n5606), .CK(clk), .Q(
        \router/data_cntl/data_in[27] ) );
  DFFQX1TS \router/data_cntl/data_in_reg[25]  ( .D(n5608), .CK(clk), .Q(
        \router/data_cntl/data_in[25] ) );
  DFFQX1TS \router/data_cntl/data_in_reg[23]  ( .D(n5610), .CK(clk), .Q(
        \router/data_cntl/data_in[23] ) );
  DFFTRX2TS \mips/mips/a/fullinstructionA_reg[1]  ( .D(
        \mips/mips/accfullinstruction[1] ), .RN(n7284), .CK(clk), .QN(n4325)
         );
  TBUFX2TS \fifo_from_fft/fifo_cell15/data_out/do_tri[30]  ( .A(1'b0), .OE(
        n2569), .Y(fft_data_in[30]) );
  TBUFX2TS \fifo_from_fft/fifo_cell13/data_out/do_tri[30]  ( .A(1'b0), .OE(
        n6268), .Y(fft_data_in[30]) );
  TBUFX2TS \fifo_from_fft/fifo_cell12/data_out/do_tri[30]  ( .A(1'b0), .OE(
        n6277), .Y(fft_data_in[30]) );
  TBUFX2TS \fifo_from_fft/fifo_cell11/data_out/do_tri[30]  ( .A(1'b0), .OE(
        n6286), .Y(fft_data_in[30]) );
  TBUFX2TS \fifo_from_fft/fifo_cell10/data_out/do_tri[30]  ( .A(1'b0), .OE(
        n6295), .Y(fft_data_in[30]) );
  TBUFX2TS \fifo_from_fft/fifo_cell9/data_out/do_tri[30]  ( .A(1'b0), .OE(
        n6304), .Y(fft_data_in[30]) );
  TBUFX2TS \fifo_from_fft/fifo_cell8/data_out/do_tri[30]  ( .A(1'b0), .OE(
        n6313), .Y(fft_data_in[30]) );
  TBUFX2TS \fifo_from_fft/fifo_cell7/data_out/do_tri[30]  ( .A(1'b0), .OE(
        n6322), .Y(fft_data_in[30]) );
  TBUFX2TS \fifo_from_fft/fifo_cell6/data_out/do_tri[30]  ( .A(1'b0), .OE(
        n6331), .Y(fft_data_in[30]) );
  TBUFX2TS \fifo_from_fft/fifo_cell5/data_out/do_tri[30]  ( .A(1'b0), .OE(
        n6340), .Y(fft_data_in[30]) );
  TBUFX2TS \fifo_from_fft/fifo_cell4/data_out/do_tri[30]  ( .A(1'b0), .OE(
        n6349), .Y(fft_data_in[30]) );
  TBUFX2TS \fifo_from_fft/fifo_cell3/data_out/do_tri[30]  ( .A(1'b0), .OE(
        n6358), .Y(fft_data_in[30]) );
  TBUFX2TS \fifo_from_fft/fifo_cell2/data_out/do_tri[30]  ( .A(1'b0), .OE(
        n6367), .Y(fft_data_in[30]) );
  TBUFX2TS \fifo_from_fft/fifo_cell1/data_out/do_tri[30]  ( .A(1'b0), .OE(
        n6376), .Y(fft_data_in[30]) );
  TBUFX2TS \fifo_from_fft/fifo_cell0/data_out/do_tri[30]  ( .A(1'b0), .OE(
        n6262), .Y(fft_data_in[30]) );
  TBUFX2TS \fifo_from_fft/fifo_cell14/data_out/do_tri[18]  ( .A(1'b0), .OE(
        n7306), .Y(fft_data_in[18]) );
  TBUFX2TS \fifo_from_fft/fifo_cell14/data_out/do_tri[17]  ( .A(1'b0), .OE(
        n7306), .Y(fft_data_in[17]) );
  TBUFX2TS \fifo_from_fft/fifo_cell14/data_out/do_tri[16]  ( .A(1'b0), .OE(
        n7306), .Y(fft_data_in[16]) );
  TBUFX2TS \fifo_from_fft/fifo_cell0/data_out/do_tri[18]  ( .A(1'b0), .OE(
        n7182), .Y(fft_data_in[18]) );
  TBUFX2TS \fifo_from_fft/fifo_cell0/data_out/do_tri[17]  ( .A(1'b0), .OE(
        n7181), .Y(fft_data_in[17]) );
  TBUFX2TS \fifo_from_fft/fifo_cell0/data_out/do_tri[16]  ( .A(1'b0), .OE(
        n7183), .Y(fft_data_in[16]) );
  TBUFX2TS \fifo_from_fir/fifo_cell15/data_out/do_tri[30]  ( .A(1'b0), .OE(
        n3593), .Y(fir_data_in[30]) );
  TBUFX2TS \fifo_from_fir/fifo_cell13/data_out/do_tri[30]  ( .A(1'b0), .OE(
        n6250), .Y(fir_data_in[30]) );
  TBUFX2TS \fifo_from_fir/fifo_cell12/data_out/do_tri[30]  ( .A(1'b0), .OE(
        n6244), .Y(fir_data_in[30]) );
  TBUFX2TS \fifo_from_fir/fifo_cell11/data_out/do_tri[30]  ( .A(1'b0), .OE(
        n6238), .Y(fir_data_in[30]) );
  TBUFX2TS \fifo_from_fir/fifo_cell10/data_out/do_tri[30]  ( .A(1'b0), .OE(
        n6232), .Y(fir_data_in[30]) );
  TBUFX2TS \fifo_from_fir/fifo_cell9/data_out/do_tri[30]  ( .A(1'b0), .OE(
        n6226), .Y(fir_data_in[30]) );
  TBUFX2TS \fifo_from_fir/fifo_cell8/data_out/do_tri[30]  ( .A(1'b0), .OE(
        n6220), .Y(fir_data_in[30]) );
  TBUFX2TS \fifo_from_fir/fifo_cell7/data_out/do_tri[30]  ( .A(1'b0), .OE(
        n6214), .Y(fir_data_in[30]) );
  TBUFX2TS \fifo_from_fir/fifo_cell6/data_out/do_tri[30]  ( .A(1'b0), .OE(
        n6217), .Y(fir_data_in[30]) );
  TBUFX2TS \fifo_from_fir/fifo_cell5/data_out/do_tri[30]  ( .A(1'b0), .OE(
        n6223), .Y(fir_data_in[30]) );
  TBUFX2TS \fifo_from_fir/fifo_cell4/data_out/do_tri[30]  ( .A(1'b0), .OE(
        n6229), .Y(fir_data_in[30]) );
  TBUFX2TS \fifo_from_fir/fifo_cell3/data_out/do_tri[30]  ( .A(1'b0), .OE(
        n6235), .Y(fir_data_in[30]) );
  TBUFX2TS \fifo_from_fir/fifo_cell2/data_out/do_tri[30]  ( .A(1'b0), .OE(
        n6241), .Y(fir_data_in[30]) );
  TBUFX2TS \fifo_from_fir/fifo_cell1/data_out/do_tri[30]  ( .A(1'b0), .OE(
        n6247), .Y(fir_data_in[30]) );
  TBUFX2TS \fifo_from_fir/fifo_cell0/data_out/do_tri[30]  ( .A(1'b0), .OE(
        n7136), .Y(fir_data_in[30]) );
  TBUFX2TS \fifo_from_fft/fifo_cell15/data_out/do_tri[26]  ( .A(1'b0), .OE(
        n6327), .Y(fft_data_in[26]) );
  TBUFX2TS \fifo_from_fft/fifo_cell14/data_out/do_tri[15]  ( .A(1'b0), .OE(
        n7307), .Y(fft_data_in[15]) );
  TBUFX2TS \fifo_from_fft/fifo_cell14/data_out/do_tri[14]  ( .A(1'b0), .OE(
        n7307), .Y(fft_data_in[14]) );
  TBUFX2TS \fifo_from_fft/fifo_cell14/data_out/do_tri[13]  ( .A(1'b0), .OE(
        n7307), .Y(fft_data_in[13]) );
  TBUFX2TS \fifo_from_fft/fifo_cell14/data_out/do_tri[12]  ( .A(1'b0), .OE(
        n7307), .Y(fft_data_in[12]) );
  TBUFX2TS \fifo_from_fft/fifo_cell14/data_out/do_tri[11]  ( .A(1'b0), .OE(
        n7308), .Y(fft_data_in[11]) );
  TBUFX2TS \fifo_from_fft/fifo_cell14/data_out/do_tri[10]  ( .A(1'b0), .OE(
        n7308), .Y(fft_data_in[10]) );
  TBUFX2TS \fifo_from_fft/fifo_cell14/data_out/do_tri[9]  ( .A(1'b0), .OE(
        n7308), .Y(fft_data_in[9]) );
  TBUFX2TS \fifo_from_fft/fifo_cell14/data_out/do_tri[8]  ( .A(1'b0), .OE(
        n7308), .Y(fft_data_in[8]) );
  TBUFX2TS \fifo_from_fft/fifo_cell14/data_out/do_tri[7]  ( .A(1'b0), .OE(
        n7310), .Y(fft_data_in[7]) );
  TBUFX2TS \fifo_from_fft/fifo_cell14/data_out/do_tri[6]  ( .A(1'b0), .OE(
        n7310), .Y(fft_data_in[6]) );
  TBUFX2TS \fifo_from_fft/fifo_cell14/data_out/do_tri[5]  ( .A(1'b0), .OE(
        n7313), .Y(fft_data_in[5]) );
  TBUFX2TS \fifo_from_fft/fifo_cell14/data_out/do_tri[4]  ( .A(1'b0), .OE(
        n7310), .Y(fft_data_in[4]) );
  TBUFX2TS \fifo_from_fft/fifo_cell14/data_out/do_tri[3]  ( .A(1'b0), .OE(
        n7309), .Y(fft_data_in[3]) );
  TBUFX2TS \fifo_from_fft/fifo_cell14/data_out/do_tri[2]  ( .A(1'b0), .OE(
        n7309), .Y(fft_data_in[2]) );
  TBUFX2TS \fifo_from_fft/fifo_cell14/data_out/do_tri[1]  ( .A(1'b0), .OE(
        n7309), .Y(fft_data_in[1]) );
  TBUFX2TS \fifo_from_fft/fifo_cell13/data_out/do_tri[26]  ( .A(1'b0), .OE(
        n2441), .Y(fft_data_in[26]) );
  TBUFX2TS \fifo_from_fft/fifo_cell12/data_out/do_tri[26]  ( .A(1'b0), .OE(
        n2377), .Y(fft_data_in[26]) );
  TBUFX2TS \fifo_from_fft/fifo_cell11/data_out/do_tri[26]  ( .A(1'b0), .OE(
        n2313), .Y(fft_data_in[26]) );
  TBUFX2TS \fifo_from_fft/fifo_cell10/data_out/do_tri[26]  ( .A(1'b0), .OE(
        n2249), .Y(fft_data_in[26]) );
  TBUFX2TS \fifo_from_fft/fifo_cell9/data_out/do_tri[26]  ( .A(1'b0), .OE(
        n2185), .Y(fft_data_in[26]) );
  TBUFX2TS \fifo_from_fft/fifo_cell8/data_out/do_tri[26]  ( .A(1'b0), .OE(
        n2121), .Y(fft_data_in[26]) );
  TBUFX2TS \fifo_from_fft/fifo_cell7/data_out/do_tri[26]  ( .A(1'b0), .OE(
        n2057), .Y(fft_data_in[26]) );
  TBUFX2TS \fifo_from_fft/fifo_cell6/data_out/do_tri[26]  ( .A(1'b0), .OE(
        n1993), .Y(fft_data_in[26]) );
  TBUFX2TS \fifo_from_fft/fifo_cell5/data_out/do_tri[26]  ( .A(1'b0), .OE(
        n1929), .Y(fft_data_in[26]) );
  TBUFX2TS \fifo_from_fft/fifo_cell4/data_out/do_tri[26]  ( .A(1'b0), .OE(
        n1865), .Y(fft_data_in[26]) );
  TBUFX2TS \fifo_from_fft/fifo_cell3/data_out/do_tri[26]  ( .A(1'b0), .OE(
        n1801), .Y(fft_data_in[26]) );
  TBUFX2TS \fifo_from_fft/fifo_cell2/data_out/do_tri[26]  ( .A(1'b0), .OE(
        n1737), .Y(fft_data_in[26]) );
  TBUFX2TS \fifo_from_fft/fifo_cell1/data_out/do_tri[26]  ( .A(1'b0), .OE(
        n1673), .Y(fft_data_in[26]) );
  TBUFX2TS \fifo_from_fft/fifo_cell0/data_out/do_tri[26]  ( .A(1'b0), .OE(
        n1609), .Y(fft_data_in[26]) );
  TBUFX2TS \fifo_from_fft/fifo_cell0/data_out/do_tri[22]  ( .A(1'b0), .OE(
        n6262), .Y(fft_data_in[22]) );
  TBUFX2TS \fifo_from_fft/fifo_cell0/data_out/do_tri[21]  ( .A(1'b0), .OE(
        n7183), .Y(fft_data_in[21]) );
  TBUFX2TS \fifo_from_fft/fifo_cell0/data_out/do_tri[20]  ( .A(1'b0), .OE(
        n7181), .Y(fft_data_in[20]) );
  TBUFX2TS \fifo_from_fft/fifo_cell0/data_out/do_tri[15]  ( .A(1'b0), .OE(
        n7179), .Y(fft_data_in[15]) );
  TBUFX2TS \fifo_from_fft/fifo_cell0/data_out/do_tri[14]  ( .A(1'b0), .OE(
        n7179), .Y(fft_data_in[14]) );
  TBUFX2TS \fifo_from_fft/fifo_cell0/data_out/do_tri[13]  ( .A(1'b0), .OE(
        n7179), .Y(fft_data_in[13]) );
  TBUFX2TS \fifo_from_fft/fifo_cell0/data_out/do_tri[12]  ( .A(1'b0), .OE(
        n7179), .Y(fft_data_in[12]) );
  TBUFX2TS \fifo_from_fft/fifo_cell0/data_out/do_tri[11]  ( .A(1'b0), .OE(
        n6262), .Y(fft_data_in[11]) );
  TBUFX2TS \fifo_from_fft/fifo_cell0/data_out/do_tri[10]  ( .A(1'b0), .OE(
        n6172), .Y(fft_data_in[10]) );
  TBUFX2TS \fifo_from_fft/fifo_cell0/data_out/do_tri[9]  ( .A(1'b0), .OE(n6172), .Y(fft_data_in[9]) );
  TBUFX2TS \fifo_from_fft/fifo_cell0/data_out/do_tri[8]  ( .A(1'b0), .OE(n6172), .Y(fft_data_in[8]) );
  TBUFX2TS \fifo_from_fft/fifo_cell0/data_out/do_tri[7]  ( .A(1'b0), .OE(n7180), .Y(fft_data_in[7]) );
  TBUFX2TS \fifo_from_fft/fifo_cell0/data_out/do_tri[6]  ( .A(1'b0), .OE(n7180), .Y(fft_data_in[6]) );
  TBUFX2TS \fifo_from_fft/fifo_cell0/data_out/do_tri[5]  ( .A(1'b0), .OE(n7180), .Y(fft_data_in[5]) );
  TBUFX2TS \fifo_from_fft/fifo_cell0/data_out/do_tri[4]  ( .A(1'b0), .OE(n7180), .Y(fft_data_in[4]) );
  TBUFX2TS \fifo_from_fft/fifo_cell0/data_out/do_tri[3]  ( .A(1'b0), .OE(n7183), .Y(fft_data_in[3]) );
  TBUFX2TS \fifo_from_fft/fifo_cell0/data_out/do_tri[2]  ( .A(1'b0), .OE(n7181), .Y(fft_data_in[2]) );
  TBUFX2TS \fifo_from_fft/fifo_cell0/data_out/do_tri[1]  ( .A(1'b0), .OE(n7182), .Y(fft_data_in[1]) );
  TBUFX2TS \fifo_from_fir/fifo_cell14/data_out/do_tri[18]  ( .A(1'b0), .OE(
        n7296), .Y(fir_data_in[18]) );
  TBUFX2TS \fifo_from_fir/fifo_cell14/data_out/do_tri[17]  ( .A(1'b0), .OE(
        n7296), .Y(fir_data_in[17]) );
  TBUFX2TS \fifo_from_fir/fifo_cell14/data_out/do_tri[16]  ( .A(1'b0), .OE(
        n7296), .Y(fir_data_in[16]) );
  TBUFX2TS \fifo_from_fir/fifo_cell13/data_out/do_tri[18]  ( .A(1'b0), .OE(
        n3465), .Y(fir_data_in[18]) );
  TBUFX2TS \fifo_from_fir/fifo_cell13/data_out/do_tri[17]  ( .A(1'b0), .OE(
        n6200), .Y(fir_data_in[17]) );
  TBUFX2TS \fifo_from_fir/fifo_cell13/data_out/do_tri[16]  ( .A(1'b0), .OE(
        n6200), .Y(fir_data_in[16]) );
  TBUFX2TS \fifo_from_fir/fifo_cell12/data_out/do_tri[18]  ( .A(1'b0), .OE(
        n3401), .Y(fir_data_in[18]) );
  TBUFX2TS \fifo_from_fir/fifo_cell12/data_out/do_tri[17]  ( .A(1'b0), .OE(
        n6199), .Y(fir_data_in[17]) );
  TBUFX2TS \fifo_from_fir/fifo_cell12/data_out/do_tri[16]  ( .A(1'b0), .OE(
        n6199), .Y(fir_data_in[16]) );
  TBUFX2TS \fifo_from_fir/fifo_cell11/data_out/do_tri[18]  ( .A(1'b0), .OE(
        n3337), .Y(fir_data_in[18]) );
  TBUFX2TS \fifo_from_fir/fifo_cell11/data_out/do_tri[17]  ( .A(1'b0), .OE(
        n6198), .Y(fir_data_in[17]) );
  TBUFX2TS \fifo_from_fir/fifo_cell11/data_out/do_tri[16]  ( .A(1'b0), .OE(
        n6198), .Y(fir_data_in[16]) );
  TBUFX2TS \fifo_from_fir/fifo_cell10/data_out/do_tri[18]  ( .A(1'b0), .OE(
        n3273), .Y(fir_data_in[18]) );
  TBUFX2TS \fifo_from_fir/fifo_cell10/data_out/do_tri[17]  ( .A(1'b0), .OE(
        n6197), .Y(fir_data_in[17]) );
  TBUFX2TS \fifo_from_fir/fifo_cell10/data_out/do_tri[16]  ( .A(1'b0), .OE(
        n6197), .Y(fir_data_in[16]) );
  TBUFX2TS \fifo_from_fir/fifo_cell9/data_out/do_tri[18]  ( .A(1'b0), .OE(
        n3209), .Y(fir_data_in[18]) );
  TBUFX2TS \fifo_from_fir/fifo_cell9/data_out/do_tri[17]  ( .A(1'b0), .OE(
        n6196), .Y(fir_data_in[17]) );
  TBUFX2TS \fifo_from_fir/fifo_cell9/data_out/do_tri[16]  ( .A(1'b0), .OE(
        n6196), .Y(fir_data_in[16]) );
  TBUFX2TS \fifo_from_fir/fifo_cell8/data_out/do_tri[18]  ( .A(1'b0), .OE(
        n3145), .Y(fir_data_in[18]) );
  TBUFX2TS \fifo_from_fir/fifo_cell8/data_out/do_tri[17]  ( .A(1'b0), .OE(
        n6195), .Y(fir_data_in[17]) );
  TBUFX2TS \fifo_from_fir/fifo_cell8/data_out/do_tri[16]  ( .A(1'b0), .OE(
        n6195), .Y(fir_data_in[16]) );
  TBUFX2TS \fifo_from_fir/fifo_cell7/data_out/do_tri[18]  ( .A(1'b0), .OE(
        n3081), .Y(fir_data_in[18]) );
  TBUFX2TS \fifo_from_fir/fifo_cell7/data_out/do_tri[17]  ( .A(1'b0), .OE(
        n6194), .Y(fir_data_in[17]) );
  TBUFX2TS \fifo_from_fir/fifo_cell7/data_out/do_tri[16]  ( .A(1'b0), .OE(
        n6194), .Y(fir_data_in[16]) );
  TBUFX2TS \fifo_from_fir/fifo_cell6/data_out/do_tri[18]  ( .A(1'b0), .OE(
        n6193), .Y(fir_data_in[18]) );
  TBUFX2TS \fifo_from_fir/fifo_cell6/data_out/do_tri[17]  ( .A(1'b0), .OE(
        n3017), .Y(fir_data_in[17]) );
  TBUFX2TS \fifo_from_fir/fifo_cell6/data_out/do_tri[16]  ( .A(1'b0), .OE(
        n6193), .Y(fir_data_in[16]) );
  TBUFX2TS \fifo_from_fir/fifo_cell5/data_out/do_tri[18]  ( .A(1'b0), .OE(
        n6192), .Y(fir_data_in[18]) );
  TBUFX2TS \fifo_from_fir/fifo_cell5/data_out/do_tri[17]  ( .A(1'b0), .OE(
        n2953), .Y(fir_data_in[17]) );
  TBUFX2TS \fifo_from_fir/fifo_cell5/data_out/do_tri[16]  ( .A(1'b0), .OE(
        n6192), .Y(fir_data_in[16]) );
  TBUFX2TS \fifo_from_fir/fifo_cell4/data_out/do_tri[18]  ( .A(1'b0), .OE(
        n6191), .Y(fir_data_in[18]) );
  TBUFX2TS \fifo_from_fir/fifo_cell4/data_out/do_tri[17]  ( .A(1'b0), .OE(
        n2889), .Y(fir_data_in[17]) );
  TBUFX2TS \fifo_from_fir/fifo_cell4/data_out/do_tri[16]  ( .A(1'b0), .OE(
        n6191), .Y(fir_data_in[16]) );
  TBUFX2TS \fifo_from_fir/fifo_cell3/data_out/do_tri[18]  ( .A(1'b0), .OE(
        n6190), .Y(fir_data_in[18]) );
  TBUFX2TS \fifo_from_fir/fifo_cell3/data_out/do_tri[17]  ( .A(1'b0), .OE(
        n2825), .Y(fir_data_in[17]) );
  TBUFX2TS \fifo_from_fir/fifo_cell3/data_out/do_tri[16]  ( .A(1'b0), .OE(
        n6190), .Y(fir_data_in[16]) );
  TBUFX2TS \fifo_from_fir/fifo_cell2/data_out/do_tri[18]  ( .A(1'b0), .OE(
        n6189), .Y(fir_data_in[18]) );
  TBUFX2TS \fifo_from_fir/fifo_cell2/data_out/do_tri[17]  ( .A(1'b0), .OE(
        n2761), .Y(fir_data_in[17]) );
  TBUFX2TS \fifo_from_fir/fifo_cell2/data_out/do_tri[16]  ( .A(1'b0), .OE(
        n6189), .Y(fir_data_in[16]) );
  TBUFX2TS \fifo_from_fir/fifo_cell1/data_out/do_tri[18]  ( .A(1'b0), .OE(
        n6188), .Y(fir_data_in[18]) );
  TBUFX2TS \fifo_from_fir/fifo_cell1/data_out/do_tri[17]  ( .A(1'b0), .OE(
        n2697), .Y(fir_data_in[17]) );
  TBUFX2TS \fifo_from_fir/fifo_cell1/data_out/do_tri[16]  ( .A(1'b0), .OE(
        n6188), .Y(fir_data_in[16]) );
  TBUFX2TS \fifo_from_fir/fifo_cell0/data_out/do_tri[18]  ( .A(1'b0), .OE(
        n7135), .Y(fir_data_in[18]) );
  TBUFX2TS \fifo_from_fir/fifo_cell0/data_out/do_tri[17]  ( .A(1'b0), .OE(
        n7134), .Y(fir_data_in[17]) );
  TBUFX2TS \fifo_from_fir/fifo_cell0/data_out/do_tri[16]  ( .A(1'b0), .OE(
        n7136), .Y(fir_data_in[16]) );
  TBUFX2TS \fifo_from_fir/fifo_cell15/data_out/do_tri[26]  ( .A(1'b0), .OE(
        n3593), .Y(fir_data_in[26]) );
  TBUFX2TS \fifo_from_fir/fifo_cell15/data_out/do_tri[22]  ( .A(1'b0), .OE(
        n6265), .Y(fir_data_in[22]) );
  TBUFX2TS \fifo_from_fir/fifo_cell15/data_out/do_tri[21]  ( .A(1'b0), .OE(
        n6187), .Y(fir_data_in[21]) );
  TBUFX2TS \fifo_from_fir/fifo_cell15/data_out/do_tri[20]  ( .A(1'b0), .OE(
        n6253), .Y(fir_data_in[20]) );
  TBUFX2TS \fifo_from_fir/fifo_cell14/data_out/do_tri[15]  ( .A(1'b0), .OE(
        n7297), .Y(fir_data_in[15]) );
  TBUFX2TS \fifo_from_fir/fifo_cell14/data_out/do_tri[14]  ( .A(1'b0), .OE(
        n7297), .Y(fir_data_in[14]) );
  TBUFX2TS \fifo_from_fir/fifo_cell14/data_out/do_tri[13]  ( .A(1'b0), .OE(
        n7297), .Y(fir_data_in[13]) );
  TBUFX2TS \fifo_from_fir/fifo_cell14/data_out/do_tri[12]  ( .A(1'b0), .OE(
        n7297), .Y(fir_data_in[12]) );
  TBUFX2TS \fifo_from_fir/fifo_cell14/data_out/do_tri[11]  ( .A(1'b0), .OE(
        n7298), .Y(fir_data_in[11]) );
  TBUFX2TS \fifo_from_fir/fifo_cell14/data_out/do_tri[10]  ( .A(1'b0), .OE(
        n7298), .Y(fir_data_in[10]) );
  TBUFX2TS \fifo_from_fir/fifo_cell14/data_out/do_tri[9]  ( .A(1'b0), .OE(
        n7298), .Y(fir_data_in[9]) );
  TBUFX2TS \fifo_from_fir/fifo_cell14/data_out/do_tri[8]  ( .A(1'b0), .OE(
        n7298), .Y(fir_data_in[8]) );
  TBUFX2TS \fifo_from_fir/fifo_cell14/data_out/do_tri[7]  ( .A(1'b0), .OE(
        n7300), .Y(fir_data_in[7]) );
  TBUFX2TS \fifo_from_fir/fifo_cell14/data_out/do_tri[6]  ( .A(1'b0), .OE(
        n7300), .Y(fir_data_in[6]) );
  TBUFX2TS \fifo_from_fir/fifo_cell14/data_out/do_tri[5]  ( .A(1'b0), .OE(
        n7303), .Y(fir_data_in[5]) );
  TBUFX2TS \fifo_from_fir/fifo_cell14/data_out/do_tri[4]  ( .A(1'b0), .OE(
        n7300), .Y(fir_data_in[4]) );
  TBUFX2TS \fifo_from_fir/fifo_cell14/data_out/do_tri[3]  ( .A(1'b0), .OE(
        n7299), .Y(fir_data_in[3]) );
  TBUFX2TS \fifo_from_fir/fifo_cell14/data_out/do_tri[2]  ( .A(1'b0), .OE(
        n7299), .Y(fir_data_in[2]) );
  TBUFX2TS \fifo_from_fir/fifo_cell14/data_out/do_tri[1]  ( .A(1'b0), .OE(
        n7299), .Y(fir_data_in[1]) );
  TBUFX2TS \fifo_from_fir/fifo_cell13/data_out/do_tri[26]  ( .A(1'b0), .OE(
        n3465), .Y(fir_data_in[26]) );
  TBUFX2TS \fifo_from_fir/fifo_cell12/data_out/do_tri[26]  ( .A(1'b0), .OE(
        n3401), .Y(fir_data_in[26]) );
  TBUFX2TS \fifo_from_fir/fifo_cell11/data_out/do_tri[26]  ( .A(1'b0), .OE(
        n3337), .Y(fir_data_in[26]) );
  TBUFX2TS \fifo_from_fir/fifo_cell10/data_out/do_tri[26]  ( .A(1'b0), .OE(
        n3273), .Y(fir_data_in[26]) );
  TBUFX2TS \fifo_from_fir/fifo_cell9/data_out/do_tri[26]  ( .A(1'b0), .OE(
        n3209), .Y(fir_data_in[26]) );
  TBUFX2TS \fifo_from_fir/fifo_cell8/data_out/do_tri[26]  ( .A(1'b0), .OE(
        n3145), .Y(fir_data_in[26]) );
  TBUFX2TS \fifo_from_fir/fifo_cell7/data_out/do_tri[26]  ( .A(1'b0), .OE(
        n3081), .Y(fir_data_in[26]) );
  TBUFX2TS \fifo_from_fir/fifo_cell6/data_out/do_tri[26]  ( .A(1'b0), .OE(
        n3017), .Y(fir_data_in[26]) );
  TBUFX2TS \fifo_from_fir/fifo_cell5/data_out/do_tri[26]  ( .A(1'b0), .OE(
        n2953), .Y(fir_data_in[26]) );
  TBUFX2TS \fifo_from_fir/fifo_cell4/data_out/do_tri[26]  ( .A(1'b0), .OE(
        n2889), .Y(fir_data_in[26]) );
  TBUFX2TS \fifo_from_fir/fifo_cell3/data_out/do_tri[26]  ( .A(1'b0), .OE(
        n2825), .Y(fir_data_in[26]) );
  TBUFX2TS \fifo_from_fir/fifo_cell2/data_out/do_tri[26]  ( .A(1'b0), .OE(
        n2761), .Y(fir_data_in[26]) );
  TBUFX2TS \fifo_from_fir/fifo_cell1/data_out/do_tri[26]  ( .A(1'b0), .OE(
        n2697), .Y(fir_data_in[26]) );
  TBUFX2TS \fifo_from_fir/fifo_cell0/data_out/do_tri[26]  ( .A(1'b0), .OE(
        n2633), .Y(fir_data_in[26]) );
  TBUFX2TS \fifo_from_fir/fifo_cell0/data_out/do_tri[22]  ( .A(1'b0), .OE(
        n6256), .Y(fir_data_in[22]) );
  TBUFX2TS \fifo_from_fir/fifo_cell0/data_out/do_tri[21]  ( .A(1'b0), .OE(
        n7136), .Y(fir_data_in[21]) );
  TBUFX2TS \fifo_from_fir/fifo_cell0/data_out/do_tri[20]  ( .A(1'b0), .OE(
        n7134), .Y(fir_data_in[20]) );
  TBUFX2TS \fifo_from_fir/fifo_cell0/data_out/do_tri[15]  ( .A(1'b0), .OE(
        n7132), .Y(fir_data_in[15]) );
  TBUFX2TS \fifo_from_fir/fifo_cell0/data_out/do_tri[14]  ( .A(1'b0), .OE(
        n7132), .Y(fir_data_in[14]) );
  TBUFX2TS \fifo_from_fir/fifo_cell0/data_out/do_tri[13]  ( .A(1'b0), .OE(
        n7132), .Y(fir_data_in[13]) );
  TBUFX2TS \fifo_from_fir/fifo_cell0/data_out/do_tri[12]  ( .A(1'b0), .OE(
        n7132), .Y(fir_data_in[12]) );
  TBUFX2TS \fifo_from_fir/fifo_cell0/data_out/do_tri[11]  ( .A(1'b0), .OE(
        n6256), .Y(fir_data_in[11]) );
  TBUFX2TS \fifo_from_fir/fifo_cell0/data_out/do_tri[10]  ( .A(1'b0), .OE(
        n6171), .Y(fir_data_in[10]) );
  TBUFX2TS \fifo_from_fir/fifo_cell0/data_out/do_tri[9]  ( .A(1'b0), .OE(n6171), .Y(fir_data_in[9]) );
  TBUFX2TS \fifo_from_fir/fifo_cell0/data_out/do_tri[8]  ( .A(1'b0), .OE(n6171), .Y(fir_data_in[8]) );
  TBUFX2TS \fifo_from_fir/fifo_cell0/data_out/do_tri[7]  ( .A(1'b0), .OE(n7133), .Y(fir_data_in[7]) );
  TBUFX2TS \fifo_from_fir/fifo_cell0/data_out/do_tri[6]  ( .A(1'b0), .OE(n7133), .Y(fir_data_in[6]) );
  TBUFX2TS \fifo_from_fir/fifo_cell0/data_out/do_tri[5]  ( .A(1'b0), .OE(n7133), .Y(fir_data_in[5]) );
  TBUFX2TS \fifo_from_fir/fifo_cell0/data_out/do_tri[4]  ( .A(1'b0), .OE(n7133), .Y(fir_data_in[4]) );
  TBUFX2TS \fifo_from_fir/fifo_cell0/data_out/do_tri[3]  ( .A(1'b0), .OE(n7136), .Y(fir_data_in[3]) );
  TBUFX2TS \fifo_from_fir/fifo_cell0/data_out/do_tri[2]  ( .A(1'b0), .OE(n7134), .Y(fir_data_in[2]) );
  TBUFX2TS \fifo_from_fir/fifo_cell0/data_out/do_tri[1]  ( .A(1'b0), .OE(n7135), .Y(fir_data_in[1]) );
  TBUFX2TS \fifo_from_fft/fifo_cell14/data_out/do_tri[0]  ( .A(1'b0), .OE(
        n7313), .Y(fft_data_in[0]) );
  TBUFX2TS \fifo_from_fft/fifo_cell0/data_out/do_tri[0]  ( .A(1'b0), .OE(n7181), .Y(fft_data_in[0]) );
  TBUFX2TS \fifo_from_fft/fifo_cell15/data_out/do_tri[27]  ( .A(1'b0), .OE(
        n6328), .Y(fft_data_in[27]) );
  TBUFX2TS \fifo_from_fft/fifo_cell15/data_out/do_tri[23]  ( .A(1'b0), .OE(
        n6327), .Y(fft_data_in[23]) );
  TBUFX2TS \fifo_from_fft/fifo_cell13/data_out/do_tri[27]  ( .A(1'b0), .OE(
        n6267), .Y(fft_data_in[27]) );
  TBUFX2TS \fifo_from_fft/fifo_cell12/data_out/do_tri[27]  ( .A(1'b0), .OE(
        n6276), .Y(fft_data_in[27]) );
  TBUFX2TS \fifo_from_fft/fifo_cell11/data_out/do_tri[27]  ( .A(1'b0), .OE(
        n6285), .Y(fft_data_in[27]) );
  TBUFX2TS \fifo_from_fft/fifo_cell10/data_out/do_tri[27]  ( .A(1'b0), .OE(
        n6294), .Y(fft_data_in[27]) );
  TBUFX2TS \fifo_from_fft/fifo_cell9/data_out/do_tri[27]  ( .A(1'b0), .OE(
        n6303), .Y(fft_data_in[27]) );
  TBUFX2TS \fifo_from_fft/fifo_cell8/data_out/do_tri[27]  ( .A(1'b0), .OE(
        n6312), .Y(fft_data_in[27]) );
  TBUFX2TS \fifo_from_fft/fifo_cell7/data_out/do_tri[27]  ( .A(1'b0), .OE(
        n6321), .Y(fft_data_in[27]) );
  TBUFX2TS \fifo_from_fft/fifo_cell6/data_out/do_tri[27]  ( .A(1'b0), .OE(
        n6330), .Y(fft_data_in[27]) );
  TBUFX2TS \fifo_from_fft/fifo_cell5/data_out/do_tri[27]  ( .A(1'b0), .OE(
        n6339), .Y(fft_data_in[27]) );
  TBUFX2TS \fifo_from_fft/fifo_cell4/data_out/do_tri[27]  ( .A(1'b0), .OE(
        n6348), .Y(fft_data_in[27]) );
  TBUFX2TS \fifo_from_fft/fifo_cell3/data_out/do_tri[27]  ( .A(1'b0), .OE(
        n6357), .Y(fft_data_in[27]) );
  TBUFX2TS \fifo_from_fft/fifo_cell2/data_out/do_tri[27]  ( .A(1'b0), .OE(
        n6366), .Y(fft_data_in[27]) );
  TBUFX2TS \fifo_from_fft/fifo_cell1/data_out/do_tri[27]  ( .A(1'b0), .OE(
        n6375), .Y(fft_data_in[27]) );
  TBUFX2TS \fifo_from_fft/fifo_cell0/data_out/do_tri[27]  ( .A(1'b0), .OE(
        n7183), .Y(fft_data_in[27]) );
  TBUFX2TS \fifo_from_fft/fifo_cell0/data_out/do_tri[23]  ( .A(1'b0), .OE(
        n7182), .Y(fft_data_in[23]) );
  TBUFX2TS \fifo_from_fir/fifo_cell15/data_out/do_tri[27]  ( .A(1'b0), .OE(
        n6265), .Y(fir_data_in[27]) );
  TBUFX2TS \fifo_from_fir/fifo_cell15/data_out/do_tri[23]  ( .A(1'b0), .OE(
        n6264), .Y(fir_data_in[23]) );
  TBUFX2TS \fifo_from_fir/fifo_cell13/data_out/do_tri[27]  ( .A(1'b0), .OE(
        n6249), .Y(fir_data_in[27]) );
  TBUFX2TS \fifo_from_fir/fifo_cell12/data_out/do_tri[27]  ( .A(1'b0), .OE(
        n6243), .Y(fir_data_in[27]) );
  TBUFX2TS \fifo_from_fir/fifo_cell11/data_out/do_tri[27]  ( .A(1'b0), .OE(
        n6237), .Y(fir_data_in[27]) );
  TBUFX2TS \fifo_from_fir/fifo_cell10/data_out/do_tri[27]  ( .A(1'b0), .OE(
        n6231), .Y(fir_data_in[27]) );
  TBUFX2TS \fifo_from_fir/fifo_cell9/data_out/do_tri[27]  ( .A(1'b0), .OE(
        n6225), .Y(fir_data_in[27]) );
  TBUFX2TS \fifo_from_fir/fifo_cell8/data_out/do_tri[27]  ( .A(1'b0), .OE(
        n6219), .Y(fir_data_in[27]) );
  TBUFX2TS \fifo_from_fir/fifo_cell7/data_out/do_tri[27]  ( .A(1'b0), .OE(
        n6213), .Y(fir_data_in[27]) );
  TBUFX2TS \fifo_from_fir/fifo_cell6/data_out/do_tri[27]  ( .A(1'b0), .OE(
        n6216), .Y(fir_data_in[27]) );
  TBUFX2TS \fifo_from_fir/fifo_cell5/data_out/do_tri[27]  ( .A(1'b0), .OE(
        n6222), .Y(fir_data_in[27]) );
  TBUFX2TS \fifo_from_fir/fifo_cell4/data_out/do_tri[27]  ( .A(1'b0), .OE(
        n6228), .Y(fir_data_in[27]) );
  TBUFX2TS \fifo_from_fir/fifo_cell3/data_out/do_tri[27]  ( .A(1'b0), .OE(
        n6234), .Y(fir_data_in[27]) );
  TBUFX2TS \fifo_from_fir/fifo_cell2/data_out/do_tri[27]  ( .A(1'b0), .OE(
        n6240), .Y(fir_data_in[27]) );
  TBUFX2TS \fifo_from_fir/fifo_cell1/data_out/do_tri[27]  ( .A(1'b0), .OE(
        n6246), .Y(fir_data_in[27]) );
  TBUFX2TS \fifo_from_fir/fifo_cell0/data_out/do_tri[27]  ( .A(1'b0), .OE(
        n6256), .Y(fir_data_in[27]) );
  TBUFX2TS \fifo_from_fir/fifo_cell0/data_out/do_tri[23]  ( .A(1'b0), .OE(
        n7135), .Y(fir_data_in[23]) );
  TBUFX2TS \fifo_from_fft/fifo_cell15/data_out/do_tri[29]  ( .A(1'b0), .OE(
        n6328), .Y(fft_data_in[29]) );
  TBUFX2TS \fifo_from_fft/fifo_cell15/data_out/do_tri[28]  ( .A(1'b0), .OE(
        n6327), .Y(fft_data_in[28]) );
  TBUFX2TS \fifo_from_fft/fifo_cell14/data_out/do_tri[29]  ( .A(1'b0), .OE(
        n7312), .Y(fft_data_in[29]) );
  TBUFX2TS \fifo_from_fft/fifo_cell14/data_out/do_tri[28]  ( .A(1'b0), .OE(
        n7312), .Y(fft_data_in[28]) );
  TBUFX2TS \fifo_from_fft/fifo_cell13/data_out/do_tri[29]  ( .A(1'b0), .OE(
        n6333), .Y(fft_data_in[29]) );
  TBUFX2TS \fifo_from_fft/fifo_cell13/data_out/do_tri[28]  ( .A(1'b0), .OE(
        n6268), .Y(fft_data_in[28]) );
  TBUFX2TS \fifo_from_fft/fifo_cell12/data_out/do_tri[29]  ( .A(1'b0), .OE(
        n6336), .Y(fft_data_in[29]) );
  TBUFX2TS \fifo_from_fft/fifo_cell12/data_out/do_tri[28]  ( .A(1'b0), .OE(
        n6277), .Y(fft_data_in[28]) );
  TBUFX2TS \fifo_from_fft/fifo_cell11/data_out/do_tri[29]  ( .A(1'b0), .OE(
        n6342), .Y(fft_data_in[29]) );
  TBUFX2TS \fifo_from_fft/fifo_cell11/data_out/do_tri[28]  ( .A(1'b0), .OE(
        n6286), .Y(fft_data_in[28]) );
  TBUFX2TS \fifo_from_fft/fifo_cell10/data_out/do_tri[29]  ( .A(1'b0), .OE(
        n6345), .Y(fft_data_in[29]) );
  TBUFX2TS \fifo_from_fft/fifo_cell10/data_out/do_tri[28]  ( .A(1'b0), .OE(
        n6295), .Y(fft_data_in[28]) );
  TBUFX2TS \fifo_from_fft/fifo_cell9/data_out/do_tri[29]  ( .A(1'b0), .OE(
        n6351), .Y(fft_data_in[29]) );
  TBUFX2TS \fifo_from_fft/fifo_cell9/data_out/do_tri[28]  ( .A(1'b0), .OE(
        n6304), .Y(fft_data_in[28]) );
  TBUFX2TS \fifo_from_fft/fifo_cell8/data_out/do_tri[29]  ( .A(1'b0), .OE(
        n6354), .Y(fft_data_in[29]) );
  TBUFX2TS \fifo_from_fft/fifo_cell8/data_out/do_tri[28]  ( .A(1'b0), .OE(
        n6313), .Y(fft_data_in[28]) );
  TBUFX2TS \fifo_from_fft/fifo_cell7/data_out/do_tri[29]  ( .A(1'b0), .OE(
        n6360), .Y(fft_data_in[29]) );
  TBUFX2TS \fifo_from_fft/fifo_cell7/data_out/do_tri[28]  ( .A(1'b0), .OE(
        n6322), .Y(fft_data_in[28]) );
  TBUFX2TS \fifo_from_fft/fifo_cell6/data_out/do_tri[29]  ( .A(1'b0), .OE(
        n6363), .Y(fft_data_in[29]) );
  TBUFX2TS \fifo_from_fft/fifo_cell6/data_out/do_tri[28]  ( .A(1'b0), .OE(
        n6331), .Y(fft_data_in[28]) );
  TBUFX2TS \fifo_from_fft/fifo_cell5/data_out/do_tri[29]  ( .A(1'b0), .OE(
        n6369), .Y(fft_data_in[29]) );
  TBUFX2TS \fifo_from_fft/fifo_cell5/data_out/do_tri[28]  ( .A(1'b0), .OE(
        n6340), .Y(fft_data_in[28]) );
  TBUFX2TS \fifo_from_fft/fifo_cell4/data_out/do_tri[29]  ( .A(1'b0), .OE(
        n6372), .Y(fft_data_in[29]) );
  TBUFX2TS \fifo_from_fft/fifo_cell4/data_out/do_tri[28]  ( .A(1'b0), .OE(
        n6349), .Y(fft_data_in[28]) );
  TBUFX2TS \fifo_from_fft/fifo_cell3/data_out/do_tri[29]  ( .A(1'b0), .OE(
        n6378), .Y(fft_data_in[29]) );
  TBUFX2TS \fifo_from_fft/fifo_cell3/data_out/do_tri[28]  ( .A(1'b0), .OE(
        n6358), .Y(fft_data_in[28]) );
  TBUFX2TS \fifo_from_fft/fifo_cell2/data_out/do_tri[29]  ( .A(1'b0), .OE(
        n6381), .Y(fft_data_in[29]) );
  TBUFX2TS \fifo_from_fft/fifo_cell2/data_out/do_tri[28]  ( .A(1'b0), .OE(
        n6367), .Y(fft_data_in[28]) );
  TBUFX2TS \fifo_from_fft/fifo_cell1/data_out/do_tri[29]  ( .A(1'b0), .OE(
        n6384), .Y(fft_data_in[29]) );
  TBUFX2TS \fifo_from_fft/fifo_cell1/data_out/do_tri[28]  ( .A(1'b0), .OE(
        n6376), .Y(fft_data_in[28]) );
  TBUFX2TS \fifo_from_fft/fifo_cell0/data_out/do_tri[29]  ( .A(1'b0), .OE(
        n6261), .Y(fft_data_in[29]) );
  TBUFX2TS \fifo_from_fft/fifo_cell0/data_out/do_tri[28]  ( .A(1'b0), .OE(
        n6261), .Y(fft_data_in[28]) );
  TBUFX2TS \fifo_from_fft/fifo_cell15/data_out/do_tri[31]  ( .A(1'b0), .OE(
        n2569), .Y(fft_data_in[31]) );
  TBUFX2TS \fifo_from_fft/fifo_cell15/data_out/do_tri[25]  ( .A(1'b0), .OE(
        n2569), .Y(fft_data_in[25]) );
  TBUFX2TS \fifo_from_fft/fifo_cell15/data_out/do_tri[24]  ( .A(1'b0), .OE(
        n2569), .Y(fft_data_in[24]) );
  TBUFX2TS \fifo_from_fft/fifo_cell14/data_out/do_tri[19]  ( .A(1'b0), .OE(
        n7306), .Y(fft_data_in[19]) );
  TBUFX2TS \fifo_from_fft/fifo_cell13/data_out/do_tri[31]  ( .A(1'b0), .OE(
        n6334), .Y(fft_data_in[31]) );
  TBUFX2TS \fifo_from_fft/fifo_cell13/data_out/do_tri[25]  ( .A(1'b0), .OE(
        n6334), .Y(fft_data_in[25]) );
  TBUFX2TS \fifo_from_fft/fifo_cell13/data_out/do_tri[24]  ( .A(1'b0), .OE(
        n6333), .Y(fft_data_in[24]) );
  TBUFX2TS \fifo_from_fft/fifo_cell13/data_out/do_tri[19]  ( .A(1'b0), .OE(
        n6333), .Y(fft_data_in[19]) );
  TBUFX2TS \fifo_from_fft/fifo_cell12/data_out/do_tri[31]  ( .A(1'b0), .OE(
        n6337), .Y(fft_data_in[31]) );
  TBUFX2TS \fifo_from_fft/fifo_cell12/data_out/do_tri[25]  ( .A(1'b0), .OE(
        n6337), .Y(fft_data_in[25]) );
  TBUFX2TS \fifo_from_fft/fifo_cell12/data_out/do_tri[24]  ( .A(1'b0), .OE(
        n6336), .Y(fft_data_in[24]) );
  TBUFX2TS \fifo_from_fft/fifo_cell12/data_out/do_tri[19]  ( .A(1'b0), .OE(
        n6336), .Y(fft_data_in[19]) );
  TBUFX2TS \fifo_from_fft/fifo_cell11/data_out/do_tri[31]  ( .A(1'b0), .OE(
        n6343), .Y(fft_data_in[31]) );
  TBUFX2TS \fifo_from_fft/fifo_cell11/data_out/do_tri[25]  ( .A(1'b0), .OE(
        n6343), .Y(fft_data_in[25]) );
  TBUFX2TS \fifo_from_fft/fifo_cell11/data_out/do_tri[24]  ( .A(1'b0), .OE(
        n6342), .Y(fft_data_in[24]) );
  TBUFX2TS \fifo_from_fft/fifo_cell11/data_out/do_tri[19]  ( .A(1'b0), .OE(
        n6342), .Y(fft_data_in[19]) );
  TBUFX2TS \fifo_from_fft/fifo_cell10/data_out/do_tri[31]  ( .A(1'b0), .OE(
        n6346), .Y(fft_data_in[31]) );
  TBUFX2TS \fifo_from_fft/fifo_cell10/data_out/do_tri[25]  ( .A(1'b0), .OE(
        n6346), .Y(fft_data_in[25]) );
  TBUFX2TS \fifo_from_fft/fifo_cell10/data_out/do_tri[24]  ( .A(1'b0), .OE(
        n6345), .Y(fft_data_in[24]) );
  TBUFX2TS \fifo_from_fft/fifo_cell10/data_out/do_tri[19]  ( .A(1'b0), .OE(
        n6345), .Y(fft_data_in[19]) );
  TBUFX2TS \fifo_from_fft/fifo_cell9/data_out/do_tri[31]  ( .A(1'b0), .OE(
        n6352), .Y(fft_data_in[31]) );
  TBUFX2TS \fifo_from_fft/fifo_cell9/data_out/do_tri[25]  ( .A(1'b0), .OE(
        n6352), .Y(fft_data_in[25]) );
  TBUFX2TS \fifo_from_fft/fifo_cell9/data_out/do_tri[24]  ( .A(1'b0), .OE(
        n6351), .Y(fft_data_in[24]) );
  TBUFX2TS \fifo_from_fft/fifo_cell9/data_out/do_tri[19]  ( .A(1'b0), .OE(
        n6351), .Y(fft_data_in[19]) );
  TBUFX2TS \fifo_from_fft/fifo_cell8/data_out/do_tri[31]  ( .A(1'b0), .OE(
        n6355), .Y(fft_data_in[31]) );
  TBUFX2TS \fifo_from_fft/fifo_cell8/data_out/do_tri[25]  ( .A(1'b0), .OE(
        n6355), .Y(fft_data_in[25]) );
  TBUFX2TS \fifo_from_fft/fifo_cell8/data_out/do_tri[24]  ( .A(1'b0), .OE(
        n6354), .Y(fft_data_in[24]) );
  TBUFX2TS \fifo_from_fft/fifo_cell8/data_out/do_tri[19]  ( .A(1'b0), .OE(
        n6354), .Y(fft_data_in[19]) );
  TBUFX2TS \fifo_from_fft/fifo_cell7/data_out/do_tri[31]  ( .A(1'b0), .OE(
        n6361), .Y(fft_data_in[31]) );
  TBUFX2TS \fifo_from_fft/fifo_cell7/data_out/do_tri[25]  ( .A(1'b0), .OE(
        n6361), .Y(fft_data_in[25]) );
  TBUFX2TS \fifo_from_fft/fifo_cell7/data_out/do_tri[24]  ( .A(1'b0), .OE(
        n6360), .Y(fft_data_in[24]) );
  TBUFX2TS \fifo_from_fft/fifo_cell7/data_out/do_tri[19]  ( .A(1'b0), .OE(
        n6360), .Y(fft_data_in[19]) );
  TBUFX2TS \fifo_from_fft/fifo_cell6/data_out/do_tri[31]  ( .A(1'b0), .OE(
        n6364), .Y(fft_data_in[31]) );
  TBUFX2TS \fifo_from_fft/fifo_cell6/data_out/do_tri[25]  ( .A(1'b0), .OE(
        n6364), .Y(fft_data_in[25]) );
  TBUFX2TS \fifo_from_fft/fifo_cell6/data_out/do_tri[24]  ( .A(1'b0), .OE(
        n6363), .Y(fft_data_in[24]) );
  TBUFX2TS \fifo_from_fft/fifo_cell6/data_out/do_tri[19]  ( .A(1'b0), .OE(
        n6363), .Y(fft_data_in[19]) );
  TBUFX2TS \fifo_from_fft/fifo_cell5/data_out/do_tri[31]  ( .A(1'b0), .OE(
        n6370), .Y(fft_data_in[31]) );
  TBUFX2TS \fifo_from_fft/fifo_cell5/data_out/do_tri[25]  ( .A(1'b0), .OE(
        n6370), .Y(fft_data_in[25]) );
  TBUFX2TS \fifo_from_fft/fifo_cell5/data_out/do_tri[24]  ( .A(1'b0), .OE(
        n6369), .Y(fft_data_in[24]) );
  TBUFX2TS \fifo_from_fft/fifo_cell5/data_out/do_tri[19]  ( .A(1'b0), .OE(
        n6369), .Y(fft_data_in[19]) );
  TBUFX2TS \fifo_from_fft/fifo_cell4/data_out/do_tri[31]  ( .A(1'b0), .OE(
        n6373), .Y(fft_data_in[31]) );
  TBUFX2TS \fifo_from_fft/fifo_cell4/data_out/do_tri[25]  ( .A(1'b0), .OE(
        n6373), .Y(fft_data_in[25]) );
  TBUFX2TS \fifo_from_fft/fifo_cell4/data_out/do_tri[24]  ( .A(1'b0), .OE(
        n6372), .Y(fft_data_in[24]) );
  TBUFX2TS \fifo_from_fft/fifo_cell4/data_out/do_tri[19]  ( .A(1'b0), .OE(
        n6372), .Y(fft_data_in[19]) );
  TBUFX2TS \fifo_from_fft/fifo_cell3/data_out/do_tri[31]  ( .A(1'b0), .OE(
        n6379), .Y(fft_data_in[31]) );
  TBUFX2TS \fifo_from_fft/fifo_cell3/data_out/do_tri[25]  ( .A(1'b0), .OE(
        n6379), .Y(fft_data_in[25]) );
  TBUFX2TS \fifo_from_fft/fifo_cell3/data_out/do_tri[24]  ( .A(1'b0), .OE(
        n6378), .Y(fft_data_in[24]) );
  TBUFX2TS \fifo_from_fft/fifo_cell3/data_out/do_tri[19]  ( .A(1'b0), .OE(
        n6378), .Y(fft_data_in[19]) );
  TBUFX2TS \fifo_from_fft/fifo_cell2/data_out/do_tri[31]  ( .A(1'b0), .OE(
        n6382), .Y(fft_data_in[31]) );
  TBUFX2TS \fifo_from_fft/fifo_cell2/data_out/do_tri[25]  ( .A(1'b0), .OE(
        n6382), .Y(fft_data_in[25]) );
  TBUFX2TS \fifo_from_fft/fifo_cell2/data_out/do_tri[24]  ( .A(1'b0), .OE(
        n6381), .Y(fft_data_in[24]) );
  TBUFX2TS \fifo_from_fft/fifo_cell2/data_out/do_tri[19]  ( .A(1'b0), .OE(
        n6381), .Y(fft_data_in[19]) );
  TBUFX2TS \fifo_from_fft/fifo_cell1/data_out/do_tri[31]  ( .A(1'b0), .OE(
        n6385), .Y(fft_data_in[31]) );
  TBUFX2TS \fifo_from_fft/fifo_cell1/data_out/do_tri[25]  ( .A(1'b0), .OE(
        n6385), .Y(fft_data_in[25]) );
  TBUFX2TS \fifo_from_fft/fifo_cell1/data_out/do_tri[24]  ( .A(1'b0), .OE(
        n6384), .Y(fft_data_in[24]) );
  TBUFX2TS \fifo_from_fft/fifo_cell1/data_out/do_tri[19]  ( .A(1'b0), .OE(
        n6384), .Y(fft_data_in[19]) );
  TBUFX2TS \fifo_from_fft/fifo_cell0/data_out/do_tri[31]  ( .A(1'b0), .OE(
        n6262), .Y(fft_data_in[31]) );
  TBUFX2TS \fifo_from_fft/fifo_cell0/data_out/do_tri[25]  ( .A(1'b0), .OE(
        n6262), .Y(fft_data_in[25]) );
  TBUFX2TS \fifo_from_fft/fifo_cell0/data_out/do_tri[24]  ( .A(1'b0), .OE(
        n6261), .Y(fft_data_in[24]) );
  TBUFX2TS \fifo_from_fft/fifo_cell0/data_out/do_tri[19]  ( .A(1'b0), .OE(
        n6261), .Y(fft_data_in[19]) );
  TBUFX2TS \fifo_from_fir/fifo_cell15/data_out/do_tri[29]  ( .A(1'b0), .OE(
        n6265), .Y(fir_data_in[29]) );
  TBUFX2TS \fifo_from_fir/fifo_cell15/data_out/do_tri[28]  ( .A(1'b0), .OE(
        n6264), .Y(fir_data_in[28]) );
  TBUFX2TS \fifo_from_fir/fifo_cell14/data_out/do_tri[29]  ( .A(1'b0), .OE(
        n7302), .Y(fir_data_in[29]) );
  TBUFX2TS \fifo_from_fir/fifo_cell14/data_out/do_tri[28]  ( .A(1'b0), .OE(
        n7302), .Y(fir_data_in[28]) );
  TBUFX2TS \fifo_from_fir/fifo_cell13/data_out/do_tri[29]  ( .A(1'b0), .OE(
        n6270), .Y(fir_data_in[29]) );
  TBUFX2TS \fifo_from_fir/fifo_cell13/data_out/do_tri[28]  ( .A(1'b0), .OE(
        n6250), .Y(fir_data_in[28]) );
  TBUFX2TS \fifo_from_fir/fifo_cell12/data_out/do_tri[29]  ( .A(1'b0), .OE(
        n6273), .Y(fir_data_in[29]) );
  TBUFX2TS \fifo_from_fir/fifo_cell12/data_out/do_tri[28]  ( .A(1'b0), .OE(
        n6244), .Y(fir_data_in[28]) );
  TBUFX2TS \fifo_from_fir/fifo_cell11/data_out/do_tri[29]  ( .A(1'b0), .OE(
        n6279), .Y(fir_data_in[29]) );
  TBUFX2TS \fifo_from_fir/fifo_cell11/data_out/do_tri[28]  ( .A(1'b0), .OE(
        n6238), .Y(fir_data_in[28]) );
  TBUFX2TS \fifo_from_fir/fifo_cell10/data_out/do_tri[29]  ( .A(1'b0), .OE(
        n6282), .Y(fir_data_in[29]) );
  TBUFX2TS \fifo_from_fir/fifo_cell10/data_out/do_tri[28]  ( .A(1'b0), .OE(
        n6232), .Y(fir_data_in[28]) );
  TBUFX2TS \fifo_from_fir/fifo_cell9/data_out/do_tri[29]  ( .A(1'b0), .OE(
        n6288), .Y(fir_data_in[29]) );
  TBUFX2TS \fifo_from_fir/fifo_cell9/data_out/do_tri[28]  ( .A(1'b0), .OE(
        n6226), .Y(fir_data_in[28]) );
  TBUFX2TS \fifo_from_fir/fifo_cell8/data_out/do_tri[29]  ( .A(1'b0), .OE(
        n6291), .Y(fir_data_in[29]) );
  TBUFX2TS \fifo_from_fir/fifo_cell8/data_out/do_tri[28]  ( .A(1'b0), .OE(
        n6220), .Y(fir_data_in[28]) );
  TBUFX2TS \fifo_from_fir/fifo_cell7/data_out/do_tri[29]  ( .A(1'b0), .OE(
        n6297), .Y(fir_data_in[29]) );
  TBUFX2TS \fifo_from_fir/fifo_cell7/data_out/do_tri[28]  ( .A(1'b0), .OE(
        n6214), .Y(fir_data_in[28]) );
  TBUFX2TS \fifo_from_fir/fifo_cell6/data_out/do_tri[29]  ( .A(1'b0), .OE(
        n6300), .Y(fir_data_in[29]) );
  TBUFX2TS \fifo_from_fir/fifo_cell6/data_out/do_tri[28]  ( .A(1'b0), .OE(
        n6217), .Y(fir_data_in[28]) );
  TBUFX2TS \fifo_from_fir/fifo_cell5/data_out/do_tri[29]  ( .A(1'b0), .OE(
        n6306), .Y(fir_data_in[29]) );
  TBUFX2TS \fifo_from_fir/fifo_cell5/data_out/do_tri[28]  ( .A(1'b0), .OE(
        n6223), .Y(fir_data_in[28]) );
  TBUFX2TS \fifo_from_fir/fifo_cell4/data_out/do_tri[29]  ( .A(1'b0), .OE(
        n6309), .Y(fir_data_in[29]) );
  TBUFX2TS \fifo_from_fir/fifo_cell4/data_out/do_tri[28]  ( .A(1'b0), .OE(
        n6229), .Y(fir_data_in[28]) );
  TBUFX2TS \fifo_from_fir/fifo_cell3/data_out/do_tri[29]  ( .A(1'b0), .OE(
        n6315), .Y(fir_data_in[29]) );
  TBUFX2TS \fifo_from_fir/fifo_cell3/data_out/do_tri[28]  ( .A(1'b0), .OE(
        n6235), .Y(fir_data_in[28]) );
  TBUFX2TS \fifo_from_fir/fifo_cell2/data_out/do_tri[29]  ( .A(1'b0), .OE(
        n6318), .Y(fir_data_in[29]) );
  TBUFX2TS \fifo_from_fir/fifo_cell2/data_out/do_tri[28]  ( .A(1'b0), .OE(
        n6241), .Y(fir_data_in[28]) );
  TBUFX2TS \fifo_from_fir/fifo_cell1/data_out/do_tri[29]  ( .A(1'b0), .OE(
        n6324), .Y(fir_data_in[29]) );
  TBUFX2TS \fifo_from_fir/fifo_cell1/data_out/do_tri[28]  ( .A(1'b0), .OE(
        n6247), .Y(fir_data_in[28]) );
  TBUFX2TS \fifo_from_fir/fifo_cell0/data_out/do_tri[29]  ( .A(1'b0), .OE(
        n6255), .Y(fir_data_in[29]) );
  TBUFX2TS \fifo_from_fir/fifo_cell0/data_out/do_tri[28]  ( .A(1'b0), .OE(
        n6255), .Y(fir_data_in[28]) );
  TBUFX2TS \fifo_from_fir/fifo_cell15/data_out/do_tri[31]  ( .A(1'b0), .OE(
        n3593), .Y(fir_data_in[31]) );
  TBUFX2TS \fifo_from_fir/fifo_cell15/data_out/do_tri[25]  ( .A(1'b0), .OE(
        n3593), .Y(fir_data_in[25]) );
  TBUFX2TS \fifo_from_fir/fifo_cell15/data_out/do_tri[24]  ( .A(1'b0), .OE(
        n6264), .Y(fir_data_in[24]) );
  TBUFX2TS \fifo_from_fir/fifo_cell14/data_out/do_tri[19]  ( .A(1'b0), .OE(
        n7296), .Y(fir_data_in[19]) );
  TBUFX2TS \fifo_from_fir/fifo_cell13/data_out/do_tri[31]  ( .A(1'b0), .OE(
        n6271), .Y(fir_data_in[31]) );
  TBUFX2TS \fifo_from_fir/fifo_cell13/data_out/do_tri[25]  ( .A(1'b0), .OE(
        n6270), .Y(fir_data_in[25]) );
  TBUFX2TS \fifo_from_fir/fifo_cell13/data_out/do_tri[24]  ( .A(1'b0), .OE(
        n6271), .Y(fir_data_in[24]) );
  TBUFX2TS \fifo_from_fir/fifo_cell13/data_out/do_tri[19]  ( .A(1'b0), .OE(
        n6270), .Y(fir_data_in[19]) );
  TBUFX2TS \fifo_from_fir/fifo_cell12/data_out/do_tri[31]  ( .A(1'b0), .OE(
        n6274), .Y(fir_data_in[31]) );
  TBUFX2TS \fifo_from_fir/fifo_cell12/data_out/do_tri[25]  ( .A(1'b0), .OE(
        n6273), .Y(fir_data_in[25]) );
  TBUFX2TS \fifo_from_fir/fifo_cell12/data_out/do_tri[24]  ( .A(1'b0), .OE(
        n6274), .Y(fir_data_in[24]) );
  TBUFX2TS \fifo_from_fir/fifo_cell12/data_out/do_tri[19]  ( .A(1'b0), .OE(
        n6273), .Y(fir_data_in[19]) );
  TBUFX2TS \fifo_from_fir/fifo_cell11/data_out/do_tri[31]  ( .A(1'b0), .OE(
        n6280), .Y(fir_data_in[31]) );
  TBUFX2TS \fifo_from_fir/fifo_cell11/data_out/do_tri[25]  ( .A(1'b0), .OE(
        n6279), .Y(fir_data_in[25]) );
  TBUFX2TS \fifo_from_fir/fifo_cell11/data_out/do_tri[24]  ( .A(1'b0), .OE(
        n6280), .Y(fir_data_in[24]) );
  TBUFX2TS \fifo_from_fir/fifo_cell11/data_out/do_tri[19]  ( .A(1'b0), .OE(
        n6279), .Y(fir_data_in[19]) );
  TBUFX2TS \fifo_from_fir/fifo_cell10/data_out/do_tri[31]  ( .A(1'b0), .OE(
        n6283), .Y(fir_data_in[31]) );
  TBUFX2TS \fifo_from_fir/fifo_cell10/data_out/do_tri[25]  ( .A(1'b0), .OE(
        n6282), .Y(fir_data_in[25]) );
  TBUFX2TS \fifo_from_fir/fifo_cell10/data_out/do_tri[24]  ( .A(1'b0), .OE(
        n6283), .Y(fir_data_in[24]) );
  TBUFX2TS \fifo_from_fir/fifo_cell10/data_out/do_tri[19]  ( .A(1'b0), .OE(
        n6282), .Y(fir_data_in[19]) );
  TBUFX2TS \fifo_from_fir/fifo_cell9/data_out/do_tri[31]  ( .A(1'b0), .OE(
        n6289), .Y(fir_data_in[31]) );
  TBUFX2TS \fifo_from_fir/fifo_cell9/data_out/do_tri[25]  ( .A(1'b0), .OE(
        n6288), .Y(fir_data_in[25]) );
  TBUFX2TS \fifo_from_fir/fifo_cell9/data_out/do_tri[24]  ( .A(1'b0), .OE(
        n6289), .Y(fir_data_in[24]) );
  TBUFX2TS \fifo_from_fir/fifo_cell9/data_out/do_tri[19]  ( .A(1'b0), .OE(
        n6288), .Y(fir_data_in[19]) );
  TBUFX2TS \fifo_from_fir/fifo_cell8/data_out/do_tri[31]  ( .A(1'b0), .OE(
        n6292), .Y(fir_data_in[31]) );
  TBUFX2TS \fifo_from_fir/fifo_cell8/data_out/do_tri[25]  ( .A(1'b0), .OE(
        n6291), .Y(fir_data_in[25]) );
  TBUFX2TS \fifo_from_fir/fifo_cell8/data_out/do_tri[24]  ( .A(1'b0), .OE(
        n6292), .Y(fir_data_in[24]) );
  TBUFX2TS \fifo_from_fir/fifo_cell8/data_out/do_tri[19]  ( .A(1'b0), .OE(
        n6291), .Y(fir_data_in[19]) );
  TBUFX2TS \fifo_from_fir/fifo_cell7/data_out/do_tri[31]  ( .A(1'b0), .OE(
        n6298), .Y(fir_data_in[31]) );
  TBUFX2TS \fifo_from_fir/fifo_cell7/data_out/do_tri[25]  ( .A(1'b0), .OE(
        n6297), .Y(fir_data_in[25]) );
  TBUFX2TS \fifo_from_fir/fifo_cell7/data_out/do_tri[24]  ( .A(1'b0), .OE(
        n6298), .Y(fir_data_in[24]) );
  TBUFX2TS \fifo_from_fir/fifo_cell7/data_out/do_tri[19]  ( .A(1'b0), .OE(
        n6297), .Y(fir_data_in[19]) );
  TBUFX2TS \fifo_from_fir/fifo_cell6/data_out/do_tri[31]  ( .A(1'b0), .OE(
        n6301), .Y(fir_data_in[31]) );
  TBUFX2TS \fifo_from_fir/fifo_cell6/data_out/do_tri[25]  ( .A(1'b0), .OE(
        n6300), .Y(fir_data_in[25]) );
  TBUFX2TS \fifo_from_fir/fifo_cell6/data_out/do_tri[24]  ( .A(1'b0), .OE(
        n6301), .Y(fir_data_in[24]) );
  TBUFX2TS \fifo_from_fir/fifo_cell6/data_out/do_tri[19]  ( .A(1'b0), .OE(
        n6300), .Y(fir_data_in[19]) );
  TBUFX2TS \fifo_from_fir/fifo_cell5/data_out/do_tri[31]  ( .A(1'b0), .OE(
        n6307), .Y(fir_data_in[31]) );
  TBUFX2TS \fifo_from_fir/fifo_cell5/data_out/do_tri[25]  ( .A(1'b0), .OE(
        n6306), .Y(fir_data_in[25]) );
  TBUFX2TS \fifo_from_fir/fifo_cell5/data_out/do_tri[24]  ( .A(1'b0), .OE(
        n6307), .Y(fir_data_in[24]) );
  TBUFX2TS \fifo_from_fir/fifo_cell5/data_out/do_tri[19]  ( .A(1'b0), .OE(
        n6306), .Y(fir_data_in[19]) );
  TBUFX2TS \fifo_from_fir/fifo_cell4/data_out/do_tri[31]  ( .A(1'b0), .OE(
        n6310), .Y(fir_data_in[31]) );
  TBUFX2TS \fifo_from_fir/fifo_cell4/data_out/do_tri[25]  ( .A(1'b0), .OE(
        n6309), .Y(fir_data_in[25]) );
  TBUFX2TS \fifo_from_fir/fifo_cell4/data_out/do_tri[24]  ( .A(1'b0), .OE(
        n6310), .Y(fir_data_in[24]) );
  TBUFX2TS \fifo_from_fir/fifo_cell4/data_out/do_tri[19]  ( .A(1'b0), .OE(
        n6309), .Y(fir_data_in[19]) );
  TBUFX2TS \fifo_from_fir/fifo_cell3/data_out/do_tri[31]  ( .A(1'b0), .OE(
        n6316), .Y(fir_data_in[31]) );
  TBUFX2TS \fifo_from_fir/fifo_cell3/data_out/do_tri[25]  ( .A(1'b0), .OE(
        n6315), .Y(fir_data_in[25]) );
  TBUFX2TS \fifo_from_fir/fifo_cell3/data_out/do_tri[24]  ( .A(1'b0), .OE(
        n6316), .Y(fir_data_in[24]) );
  TBUFX2TS \fifo_from_fir/fifo_cell3/data_out/do_tri[19]  ( .A(1'b0), .OE(
        n6315), .Y(fir_data_in[19]) );
  TBUFX2TS \fifo_from_fir/fifo_cell2/data_out/do_tri[31]  ( .A(1'b0), .OE(
        n6319), .Y(fir_data_in[31]) );
  TBUFX2TS \fifo_from_fir/fifo_cell2/data_out/do_tri[25]  ( .A(1'b0), .OE(
        n6318), .Y(fir_data_in[25]) );
  TBUFX2TS \fifo_from_fir/fifo_cell2/data_out/do_tri[24]  ( .A(1'b0), .OE(
        n6319), .Y(fir_data_in[24]) );
  TBUFX2TS \fifo_from_fir/fifo_cell2/data_out/do_tri[19]  ( .A(1'b0), .OE(
        n6318), .Y(fir_data_in[19]) );
  TBUFX2TS \fifo_from_fir/fifo_cell1/data_out/do_tri[31]  ( .A(1'b0), .OE(
        n6325), .Y(fir_data_in[31]) );
  TBUFX2TS \fifo_from_fir/fifo_cell1/data_out/do_tri[25]  ( .A(1'b0), .OE(
        n6324), .Y(fir_data_in[25]) );
  TBUFX2TS \fifo_from_fir/fifo_cell1/data_out/do_tri[24]  ( .A(1'b0), .OE(
        n6325), .Y(fir_data_in[24]) );
  TBUFX2TS \fifo_from_fir/fifo_cell1/data_out/do_tri[19]  ( .A(1'b0), .OE(
        n6324), .Y(fir_data_in[19]) );
  TBUFX2TS \fifo_from_fir/fifo_cell14/data_out/do_tri[0]  ( .A(1'b0), .OE(
        n7303), .Y(fir_data_in[0]) );
  TBUFX2TS \fifo_from_fir/fifo_cell13/data_out/do_tri[0]  ( .A(1'b0), .OE(
        n6249), .Y(fir_data_in[0]) );
  TBUFX2TS \fifo_from_fir/fifo_cell12/data_out/do_tri[0]  ( .A(1'b0), .OE(
        n6243), .Y(fir_data_in[0]) );
  TBUFX2TS \fifo_from_fir/fifo_cell11/data_out/do_tri[0]  ( .A(1'b0), .OE(
        n6237), .Y(fir_data_in[0]) );
  TBUFX2TS \fifo_from_fir/fifo_cell10/data_out/do_tri[0]  ( .A(1'b0), .OE(
        n6231), .Y(fir_data_in[0]) );
  TBUFX2TS \fifo_from_fir/fifo_cell9/data_out/do_tri[0]  ( .A(1'b0), .OE(n6225), .Y(fir_data_in[0]) );
  TBUFX2TS \fifo_from_fir/fifo_cell8/data_out/do_tri[0]  ( .A(1'b0), .OE(n6219), .Y(fir_data_in[0]) );
  TBUFX2TS \fifo_from_fir/fifo_cell7/data_out/do_tri[0]  ( .A(1'b0), .OE(n6213), .Y(fir_data_in[0]) );
  TBUFX2TS \fifo_from_fir/fifo_cell6/data_out/do_tri[0]  ( .A(1'b0), .OE(n6300), .Y(fir_data_in[0]) );
  TBUFX2TS \fifo_from_fir/fifo_cell5/data_out/do_tri[0]  ( .A(1'b0), .OE(n6306), .Y(fir_data_in[0]) );
  TBUFX2TS \fifo_from_fir/fifo_cell4/data_out/do_tri[0]  ( .A(1'b0), .OE(n6309), .Y(fir_data_in[0]) );
  TBUFX2TS \fifo_from_fir/fifo_cell3/data_out/do_tri[0]  ( .A(1'b0), .OE(n6315), .Y(fir_data_in[0]) );
  TBUFX2TS \fifo_from_fir/fifo_cell2/data_out/do_tri[0]  ( .A(1'b0), .OE(n6318), .Y(fir_data_in[0]) );
  TBUFX2TS \fifo_from_fir/fifo_cell1/data_out/do_tri[0]  ( .A(1'b0), .OE(n6324), .Y(fir_data_in[0]) );
  TBUFX2TS \fifo_from_fir/fifo_cell0/data_out/do_tri[0]  ( .A(1'b0), .OE(n7134), .Y(fir_data_in[0]) );
  DFFQX1TS \fifo_from_fft/fifo_cell15/hold_token_reg  ( .D(
        \fifo_from_fft/fifo_cell15/N7 ), .CK(clk), .Q(\fifo_from_fft/hold[15] ) );
  DFFQX1TS \fifo_from_fir/fifo_cell15/hold_token_reg  ( .D(
        \fifo_from_fir/fifo_cell15/N7 ), .CK(clk), .Q(\fifo_from_fir/hold[15] ) );
  DFFQX1TS \router/pla_top/instruction_valid_reg  ( .D(\router/pla_top/N60 ), 
        .CK(clk), .Q(\router/pla_top/instruction_valid ) );
  DFFQX1TS \fifo_from_fft/fifo_cell14/hold_token_reg  ( .D(
        \fifo_from_fft/fifo_cell14/N7 ), .CK(clk), .Q(\fifo_from_fft/hold[14] ) );
  DFFQX1TS \fifo_from_fir/fifo_cell14/hold_token_reg  ( .D(
        \fifo_from_fir/fifo_cell14/N7 ), .CK(clk), .Q(\fifo_from_fir/hold[14] ) );
  DFFQX1TS \fifo_from_fft/fifo_cell5/controller/f_i_get_reg  ( .D(n5646), .CK(
        clk), .Q(\fifo_from_fft/fifo_cell5/controller/f_i_get ) );
  DFFQX1TS \fifo_from_fir/fifo_cell5/controller/f_i_get_reg  ( .D(n5787), .CK(
        clk), .Q(\fifo_from_fir/fifo_cell5/controller/f_i_get ) );
  DFFQX1TS \fifo_from_fft/fifo_cell4/controller/f_i_get_reg  ( .D(n5647), .CK(
        clk), .Q(\fifo_from_fft/fifo_cell4/controller/f_i_get ) );
  DFFQX1TS \fifo_from_fir/fifo_cell4/controller/f_i_get_reg  ( .D(n5788), .CK(
        clk), .Q(\fifo_from_fir/fifo_cell4/controller/f_i_get ) );
  DFFQX1TS \fifo_from_fft/fifo_cell2/controller/f_i_get_reg  ( .D(n5649), .CK(
        clk), .Q(\fifo_from_fft/fifo_cell2/controller/f_i_get ) );
  DFFQX1TS \fifo_from_fir/fifo_cell2/controller/f_i_get_reg  ( .D(n5790), .CK(
        clk), .Q(\fifo_from_fir/fifo_cell2/controller/f_i_get ) );
  DFFQX1TS \fifo_from_fft/fifo_cell1/reg_gtok/token_reg  ( .D(n5666), .CK(clk), 
        .Q(\fifo_from_fft/fifo_cell1/reg_gtok/token ) );
  DFFQX1TS \fifo_from_fft/fifo_cell2/reg_gtok/token_reg  ( .D(n5665), .CK(clk), 
        .Q(\fifo_from_fft/fifo_cell2/reg_gtok/token ) );
  DFFQX1TS \fifo_from_fft/fifo_cell3/reg_gtok/token_reg  ( .D(n5664), .CK(clk), 
        .Q(\fifo_from_fft/fifo_cell3/reg_gtok/token ) );
  DFFQX1TS \fifo_from_fft/fifo_cell4/reg_gtok/token_reg  ( .D(n5663), .CK(clk), 
        .Q(\fifo_from_fft/fifo_cell4/reg_gtok/token ) );
  DFFQX1TS \fifo_from_fir/fifo_cell1/reg_gtok/token_reg  ( .D(n5807), .CK(clk), 
        .Q(\fifo_from_fir/fifo_cell1/reg_gtok/token ) );
  DFFQX1TS \fifo_from_fir/fifo_cell2/reg_gtok/token_reg  ( .D(n5806), .CK(clk), 
        .Q(\fifo_from_fir/fifo_cell2/reg_gtok/token ) );
  DFFQX1TS \fifo_from_fir/fifo_cell3/reg_gtok/token_reg  ( .D(n5805), .CK(clk), 
        .Q(\fifo_from_fir/fifo_cell3/reg_gtok/token ) );
  DFFQX1TS \fifo_from_fir/fifo_cell4/reg_gtok/token_reg  ( .D(n5804), .CK(clk), 
        .Q(\fifo_from_fir/fifo_cell4/reg_gtok/token ) );
  DFFQX1TS \router/data_cntl/fir_put_req_reg  ( .D(n5769), .CK(clk), .Q(
        \router/fir_put_req_reg ) );
  DFFQX1TS \fifo_from_fft/fifo_cell6/controller/f_i_get_reg  ( .D(n5645), .CK(
        clk), .Q(\fifo_from_fft/fifo_cell6/controller/f_i_get ) );
  DFFQX1TS \fifo_from_fir/fifo_cell6/controller/f_i_get_reg  ( .D(n5786), .CK(
        clk), .Q(\fifo_from_fir/fifo_cell6/controller/f_i_get ) );
  DFFQX1TS \fifo_from_fft/fifo_cell14/controller/f_i_get_reg  ( .D(n5637), 
        .CK(clk), .Q(\fifo_from_fft/fifo_cell14/controller/f_i_get ) );
  DFFQX1TS \fifo_from_fir/fifo_cell14/controller/f_i_get_reg  ( .D(n5778), 
        .CK(clk), .Q(\fifo_from_fir/fifo_cell14/controller/f_i_get ) );
  DFFQX1TS \fifo_from_fft/fifo_cell1/controller/f_i_get_reg  ( .D(n5650), .CK(
        clk), .Q(\fifo_from_fft/fifo_cell1/controller/f_i_get ) );
  DFFQX1TS \fifo_from_fft/fifo_cell15/controller/f_i_get_reg  ( .D(n5636), 
        .CK(clk), .Q(\fifo_from_fft/fifo_cell15/controller/f_i_get ) );
  DFFQX1TS \fifo_from_fir/fifo_cell1/controller/f_i_get_reg  ( .D(n5791), .CK(
        clk), .Q(\fifo_from_fir/fifo_cell1/controller/f_i_get ) );
  DFFQX1TS \fifo_from_fir/fifo_cell15/controller/f_i_get_reg  ( .D(n5777), 
        .CK(clk), .Q(\fifo_from_fir/fifo_cell15/controller/f_i_get ) );
  DFFQX1TS \fifo_from_fft/fifo_cell8/controller/f_i_get_reg  ( .D(n5643), .CK(
        clk), .Q(\fifo_from_fft/fifo_cell8/controller/f_i_get ) );
  DFFQX1TS \fifo_from_fir/fifo_cell8/controller/f_i_get_reg  ( .D(n5784), .CK(
        clk), .Q(\fifo_from_fir/fifo_cell8/controller/f_i_get ) );
  DFFQX1TS \fifo_from_fft/fifo_cell9/controller/f_i_get_reg  ( .D(n5642), .CK(
        clk), .Q(\fifo_from_fft/fifo_cell9/controller/f_i_get ) );
  DFFQX1TS \fifo_from_fir/fifo_cell9/controller/f_i_get_reg  ( .D(n5783), .CK(
        clk), .Q(\fifo_from_fir/fifo_cell9/controller/f_i_get ) );
  DFFQX1TS \fifo_from_fft/fifo_cell3/controller/f_i_get_reg  ( .D(n5648), .CK(
        clk), .Q(\fifo_from_fft/fifo_cell3/controller/f_i_get ) );
  DFFQX1TS \fifo_from_fft/fifo_cell13/controller/f_i_get_reg  ( .D(n5638), 
        .CK(clk), .Q(\fifo_from_fft/fifo_cell13/controller/f_i_get ) );
  DFFQX1TS \fifo_from_fir/fifo_cell3/controller/f_i_get_reg  ( .D(n5789), .CK(
        clk), .Q(\fifo_from_fir/fifo_cell3/controller/f_i_get ) );
  DFFQX1TS \fifo_from_fir/fifo_cell13/controller/f_i_get_reg  ( .D(n5779), 
        .CK(clk), .Q(\fifo_from_fir/fifo_cell13/controller/f_i_get ) );
  TBUFX2TS \router/data_cntl/data_bus_tri[30]  ( .A(
        \router/data_cntl/data_in[30] ), .OE(n7185), .Y(data_bus[30]) );
  TBUFX2TS \router/data_cntl/data_bus_tri[29]  ( .A(
        \router/data_cntl/data_in[29] ), .OE(n7185), .Y(data_bus[29]) );
  TBUFX2TS \router/data_cntl/data_bus_tri[28]  ( .A(
        \router/data_cntl/data_in[28] ), .OE(n7185), .Y(data_bus[28]) );
  TBUFX2TS \router/data_cntl/data_bus_tri[21]  ( .A(
        \router/data_cntl/data_in[21] ), .OE(n1545), .Y(data_bus[21]) );
  TBUFX2TS \router/data_cntl/data_bus_tri[20]  ( .A(
        \router/data_cntl/data_in[20] ), .OE(n1545), .Y(data_bus[20]) );
  DFFQX1TS \router/data_cntl/fft_put_req_reg  ( .D(n5672), .CK(clk), .Q(
        \router/fft_put_req_reg ) );
  DFFQX1TS \router/addr_calc/iir_write_calc/counter/done_reg  ( .D(n5946), 
        .CK(clk), .Q(\router/iir_write_done ) );
  DFFQX1TS \router/addr_calc/iir_read_calc/counter/done_reg  ( .D(n5944), .CK(
        clk), .Q(\router/iir_read_done ) );
  DFFTRX2TS \fifo_from_fft/fifo_cell13/data_out/en_reg  ( .D(n7085), .RN(
        \fifo_from_fft/fifo_cell12/reg_gtok/token ), .CK(clk), .Q(n6186), .QN(
        n6332) );
  DFFTRX2TS \fifo_from_fft/fifo_cell12/data_out/en_reg  ( .D(n7085), .RN(
        \fifo_from_fft/fifo_cell11/reg_gtok/token ), .CK(clk), .Q(n6185), .QN(
        n6335) );
  DFFTRX2TS \fifo_from_fft/fifo_cell11/data_out/en_reg  ( .D(n7089), .RN(
        \fifo_from_fft/fifo_cell10/reg_gtok/token ), .CK(clk), .Q(n6184), .QN(
        n6341) );
  DFFTRX2TS \fifo_from_fft/fifo_cell10/data_out/en_reg  ( .D(n7086), .RN(
        \fifo_from_fft/fifo_cell9/reg_gtok/token ), .CK(clk), .Q(n6183), .QN(
        n6344) );
  DFFTRX2TS \fifo_from_fft/fifo_cell9/data_out/en_reg  ( .D(n7086), .RN(
        \fifo_from_fft/fifo_cell8/reg_gtok/token ), .CK(clk), .Q(n6182), .QN(
        n6350) );
  DFFTRX2TS \fifo_from_fft/fifo_cell8/data_out/en_reg  ( .D(n7086), .RN(
        \fifo_from_fft/fifo_cell7/reg_gtok/token ), .CK(clk), .Q(n6181), .QN(
        n6353) );
  DFFTRX2TS \fifo_from_fft/fifo_cell7/data_out/en_reg  ( .D(n7088), .RN(
        \fifo_from_fft/fifo_cell6/reg_gtok/token ), .CK(clk), .Q(n6180), .QN(
        n6359) );
  DFFTRX2TS \fifo_from_fft/fifo_cell6/data_out/en_reg  ( .D(n7084), .RN(
        \fifo_from_fft/fifo_cell5/reg_gtok/token ), .CK(clk), .Q(n6179), .QN(
        n6362) );
  DFFTRX2TS \fifo_from_fft/fifo_cell5/data_out/en_reg  ( .D(n7084), .RN(
        \fifo_from_fft/fifo_cell4/reg_gtok/token ), .CK(clk), .Q(n6178), .QN(
        n6368) );
  DFFTRX2TS \fifo_from_fft/fifo_cell4/data_out/en_reg  ( .D(n7084), .RN(
        \fifo_from_fft/fifo_cell3/reg_gtok/token ), .CK(clk), .Q(n6177), .QN(
        n6371) );
  DFFTRX2TS \fifo_from_fft/fifo_cell3/data_out/en_reg  ( .D(n7084), .RN(
        \fifo_from_fft/fifo_cell2/reg_gtok/token ), .CK(clk), .Q(n6176), .QN(
        n6377) );
  DFFTRX2TS \fifo_from_fft/fifo_cell2/data_out/en_reg  ( .D(n7083), .RN(
        \fifo_from_fft/fifo_cell1/reg_gtok/token ), .CK(clk), .Q(n6175), .QN(
        n6380) );
  DFFTRX2TS \fifo_from_fft/fifo_cell1/data_out/en_reg  ( .D(n7083), .RN(
        \fifo_from_fft/fifo_cell0/reg_gtok/token ), .CK(clk), .Q(n6174), .QN(
        n6383) );
  DFFTRX2TS \fifo_from_fir/fifo_cell13/data_out/en_reg  ( .D(n7075), .RN(
        \fifo_from_fir/fifo_cell12/reg_gtok/token ), .CK(clk), .Q(n6200), .QN(
        n6269) );
  DFFTRX2TS \fifo_from_fir/fifo_cell12/data_out/en_reg  ( .D(n7075), .RN(
        \fifo_from_fir/fifo_cell11/reg_gtok/token ), .CK(clk), .Q(n6199), .QN(
        n6272) );
  DFFTRX2TS \fifo_from_fir/fifo_cell11/data_out/en_reg  ( .D(n7078), .RN(
        \fifo_from_fir/fifo_cell10/reg_gtok/token ), .CK(clk), .Q(n6198), .QN(
        n6278) );
  DFFTRX2TS \fifo_from_fir/fifo_cell10/data_out/en_reg  ( .D(n7076), .RN(
        \fifo_from_fir/fifo_cell9/reg_gtok/token ), .CK(clk), .Q(n6197), .QN(
        n6281) );
  DFFTRX2TS \fifo_from_fir/fifo_cell9/data_out/en_reg  ( .D(n7076), .RN(
        \fifo_from_fir/fifo_cell8/reg_gtok/token ), .CK(clk), .Q(n6196), .QN(
        n6287) );
  DFFTRX2TS \fifo_from_fir/fifo_cell8/data_out/en_reg  ( .D(n7076), .RN(
        \fifo_from_fir/fifo_cell7/reg_gtok/token ), .CK(clk), .Q(n6195), .QN(
        n6290) );
  DFFTRX2TS \fifo_from_fir/fifo_cell7/data_out/en_reg  ( .D(n7079), .RN(
        \fifo_from_fir/fifo_cell6/reg_gtok/token ), .CK(clk), .Q(n6194), .QN(
        n6296) );
  DFFTRX2TS \fifo_from_fir/fifo_cell6/data_out/en_reg  ( .D(n7074), .RN(
        \fifo_from_fir/fifo_cell5/reg_gtok/token ), .CK(clk), .Q(n6193), .QN(
        n6299) );
  DFFTRX2TS \fifo_from_fir/fifo_cell5/data_out/en_reg  ( .D(n7074), .RN(
        \fifo_from_fir/fifo_cell4/reg_gtok/token ), .CK(clk), .Q(n6192), .QN(
        n6305) );
  DFFTRX2TS \fifo_from_fir/fifo_cell4/data_out/en_reg  ( .D(n7074), .RN(
        \fifo_from_fir/fifo_cell3/reg_gtok/token ), .CK(clk), .Q(n6191), .QN(
        n6308) );
  DFFTRX2TS \fifo_from_fir/fifo_cell3/data_out/en_reg  ( .D(n7074), .RN(
        \fifo_from_fir/fifo_cell2/reg_gtok/token ), .CK(clk), .Q(n6190), .QN(
        n6314) );
  DFFTRX2TS \fifo_from_fir/fifo_cell2/data_out/en_reg  ( .D(n7073), .RN(
        \fifo_from_fir/fifo_cell1/reg_gtok/token ), .CK(clk), .Q(n6189), .QN(
        n6317) );
  DFFTRX2TS \fifo_from_fir/fifo_cell1/data_out/en_reg  ( .D(n7073), .RN(
        \fifo_from_fir/fifo_cell0/reg_gtok/token ), .CK(clk), .Q(n6188), .QN(
        n6323) );
  DFFTRX2TS \fifo_from_fft/fifo_cell15/data_out/en_reg  ( .D(n7085), .RN(
        \fifo_from_fft/fifo_cell14/reg_gtok/token ), .CK(clk), .Q(n6173), .QN(
        n6326) );
  DFFTRX2TS \fifo_from_fir/fifo_cell15/data_out/en_reg  ( .D(n7075), .RN(
        \fifo_from_fir/fifo_cell14/reg_gtok/token ), .CK(clk), .Q(n6187), .QN(
        n6263) );
  TBUFX2TS \router/addr_calc/addr_tri[27]  ( .A(
        \router/addr_calc/fft_read_addr[27] ), .OE(n7194), .Y(addr[27]) );
  TBUFX2TS \router/addr_calc/addr_tri[26]  ( .A(n6627), .OE(n7194), .Y(
        addr[26]) );
  TBUFX2TS \router/addr_calc/addr_tri[25]  ( .A(n6095), .OE(n7194), .Y(
        addr[25]) );
  TBUFX2TS \router/addr_calc/addr_tri[24]  ( .A(n6631), .OE(n7194), .Y(
        addr[24]) );
  TBUFX2TS \router/addr_calc/addr_tri2[27]  ( .A(
        \router/addr_calc/fft_write_addr[27] ), .OE(n7202), .Y(addr[27]) );
  TBUFX2TS \router/addr_calc/addr_tri2[26]  ( .A(n6577), .OE(n7202), .Y(
        addr[26]) );
  TBUFX2TS \router/addr_calc/addr_tri2[25]  ( .A(n6140), .OE(n7202), .Y(
        addr[25]) );
  TBUFX2TS \router/addr_calc/addr_tri2[24]  ( .A(n6581), .OE(n7202), .Y(
        addr[24]) );
  TBUFX2TS \router/addr_calc/addr_tri3[27]  ( .A(
        \router/addr_calc/fir_read_addr[27] ), .OE(n7210), .Y(addr[27]) );
  TBUFX2TS \router/addr_calc/addr_tri3[26]  ( .A(n6531), .OE(n7210), .Y(
        addr[26]) );
  TBUFX2TS \router/addr_calc/addr_tri3[25]  ( .A(n6139), .OE(n7210), .Y(
        addr[25]) );
  TBUFX2TS \router/addr_calc/addr_tri3[24]  ( .A(n6535), .OE(n7210), .Y(
        addr[24]) );
  TBUFX2TS \router/addr_calc/addr_tri4[27]  ( .A(
        \router/addr_calc/fir_write_addr[27] ), .OE(n7218), .Y(addr[27]) );
  TBUFX2TS \router/addr_calc/addr_tri4[26]  ( .A(n6479), .OE(n7218), .Y(
        addr[26]) );
  TBUFX2TS \router/addr_calc/addr_tri4[25]  ( .A(n6138), .OE(n7218), .Y(
        addr[25]) );
  TBUFX2TS \router/addr_calc/addr_tri4[24]  ( .A(n6487), .OE(n7218), .Y(
        addr[24]) );
  TBUFX2TS \router/addr_calc/addr_tri5[27]  ( .A(
        \router/addr_calc/iir_read_calc/count[27] ), .OE(1'b0), .Y(addr[27])
         );
  TBUFX2TS \router/addr_calc/addr_tri5[26]  ( .A(
        \router/addr_calc/iir_read_calc/count[26] ), .OE(1'b0), .Y(addr[26])
         );
  TBUFX2TS \router/addr_calc/addr_tri5[25]  ( .A(
        \router/addr_calc/iir_read_calc/count[25] ), .OE(1'b0), .Y(addr[25])
         );
  TBUFX2TS \router/addr_calc/addr_tri5[24]  ( .A(
        \router/addr_calc/iir_read_calc/count[24] ), .OE(1'b0), .Y(addr[24])
         );
  TBUFX2TS \router/addr_calc/addr_tri5[19]  ( .A(
        \router/addr_calc/iir_read_calc/count[19] ), .OE(1'b0), .Y(addr[19])
         );
  TBUFX2TS \router/addr_calc/addr_tri5[18]  ( .A(
        \router/addr_calc/iir_read_calc/count[18] ), .OE(1'b0), .Y(addr[18])
         );
  TBUFX2TS \router/addr_calc/addr_tri5[17]  ( .A(
        \router/addr_calc/iir_read_calc/count[17] ), .OE(1'b0), .Y(addr[17])
         );
  TBUFX2TS \router/addr_calc/addr_tri5[16]  ( .A(
        \router/addr_calc/iir_read_calc/count[16] ), .OE(1'b0), .Y(addr[16])
         );
  TBUFX2TS \router/addr_calc/addr_tri5[15]  ( .A(
        \router/addr_calc/iir_read_calc/count[15] ), .OE(1'b0), .Y(addr[15])
         );
  TBUFX2TS \router/addr_calc/addr_tri5[14]  ( .A(
        \router/addr_calc/iir_read_calc/count[14] ), .OE(1'b0), .Y(addr[14])
         );
  TBUFX2TS \router/addr_calc/addr_tri5[13]  ( .A(
        \router/addr_calc/iir_read_calc/count[13] ), .OE(1'b0), .Y(addr[13])
         );
  TBUFX2TS \router/addr_calc/addr_tri5[12]  ( .A(
        \router/addr_calc/iir_read_calc/count[12] ), .OE(1'b0), .Y(addr[12])
         );
  TBUFX2TS \router/addr_calc/addr_tri5[11]  ( .A(
        \router/addr_calc/iir_read_calc/count[11] ), .OE(1'b0), .Y(addr[11])
         );
  TBUFX2TS \router/addr_calc/addr_tri5[10]  ( .A(
        \router/addr_calc/iir_read_calc/count[10] ), .OE(1'b0), .Y(addr[10])
         );
  TBUFX2TS \router/addr_calc/addr_tri5[9]  ( .A(
        \router/addr_calc/iir_read_calc/count[9] ), .OE(1'b0), .Y(addr[9]) );
  TBUFX2TS \router/addr_calc/addr_tri5[8]  ( .A(
        \router/addr_calc/iir_read_calc/count[8] ), .OE(1'b0), .Y(addr[8]) );
  TBUFX2TS \router/addr_calc/addr_tri5[7]  ( .A(
        \router/addr_calc/iir_read_calc/count[7] ), .OE(1'b0), .Y(addr[7]) );
  TBUFX2TS \router/addr_calc/addr_tri5[6]  ( .A(
        \router/addr_calc/iir_read_calc/count[6] ), .OE(1'b0), .Y(addr[6]) );
  TBUFX2TS \router/addr_calc/addr_tri5[5]  ( .A(
        \router/addr_calc/iir_read_calc/count[5] ), .OE(1'b0), .Y(addr[5]) );
  TBUFX2TS \router/addr_calc/addr_tri5[4]  ( .A(
        \router/addr_calc/iir_read_calc/count[4] ), .OE(1'b0), .Y(addr[4]) );
  TBUFX2TS \router/addr_calc/addr_tri5[3]  ( .A(
        \router/addr_calc/iir_read_calc/count[3] ), .OE(1'b0), .Y(addr[3]) );
  TBUFX2TS \router/addr_calc/addr_tri5[2]  ( .A(
        \router/addr_calc/iir_read_calc/count[2] ), .OE(1'b0), .Y(addr[2]) );
  TBUFX2TS \router/addr_calc/addr_tri5[1]  ( .A(
        \router/addr_calc/iir_read_calc/count[1] ), .OE(1'b0), .Y(addr[1]) );
  TBUFX2TS \router/addr_calc/addr_tri5[0]  ( .A(
        \router/addr_calc/iir_read_calc/count[0] ), .OE(1'b0), .Y(addr[0]) );
  TBUFX2TS \router/addr_calc/addr_tri6[27]  ( .A(
        \router/addr_calc/iir_write_addr[27] ), .OE(n7226), .Y(addr[27]) );
  TBUFX2TS \router/addr_calc/addr_tri6[26]  ( .A(n6389), .OE(n7226), .Y(
        addr[26]) );
  TBUFX2TS \router/addr_calc/addr_tri6[25]  ( .A(n6158), .OE(n7226), .Y(
        addr[25]) );
  TBUFX2TS \router/addr_calc/addr_tri6[24]  ( .A(n6391), .OE(n7226), .Y(
        addr[24]) );
  TBUFX2TS \router/addr_calc/addr_tri5[22]  ( .A(
        \router/addr_calc/iir_read_calc/count[22] ), .OE(1'b0), .Y(addr[22])
         );
  TBUFX2TS \router/addr_calc/addr_tri5[21]  ( .A(
        \router/addr_calc/iir_read_calc/count[21] ), .OE(1'b0), .Y(addr[21])
         );
  TBUFX2TS \router/addr_calc/addr_tri5[20]  ( .A(
        \router/addr_calc/iir_read_calc/count[20] ), .OE(1'b0), .Y(addr[20])
         );
  TBUFX2TS \router/addr_calc/addr_tri[31]  ( .A(n6621), .OE(n1481), .Y(
        addr[31]) );
  TBUFX2TS \router/addr_calc/addr_tri[23]  ( .A(
        \router/addr_calc/fft_read_addr[23] ), .OE(n6206), .Y(addr[23]) );
  TBUFX2TS \router/addr_calc/addr_tri2[31]  ( .A(
        \router/addr_calc/fft_write_addr[31] ), .OE(n1417), .Y(addr[31]) );
  TBUFX2TS \router/addr_calc/addr_tri2[23]  ( .A(
        \router/addr_calc/fft_write_addr[23] ), .OE(n6203), .Y(addr[23]) );
  TBUFX2TS \router/addr_calc/addr_tri3[31]  ( .A(n6525), .OE(n1353), .Y(
        addr[31]) );
  TBUFX2TS \router/addr_calc/addr_tri3[23]  ( .A(
        \router/addr_calc/fir_read_addr[23] ), .OE(n6201), .Y(addr[23]) );
  TBUFX2TS \router/addr_calc/addr_tri4[31]  ( .A(n6467), .OE(n1289), .Y(
        addr[31]) );
  TBUFX2TS \router/addr_calc/addr_tri4[23]  ( .A(
        \router/addr_calc/fir_write_addr[23] ), .OE(n6202), .Y(addr[23]) );
  TBUFX2TS \router/addr_calc/addr_tri5[31]  ( .A(
        \router/addr_calc/iir_read_calc/count[31] ), .OE(1'b0), .Y(addr[31])
         );
  TBUFX2TS \router/addr_calc/addr_tri5[23]  ( .A(
        \router/addr_calc/iir_read_calc/count[23] ), .OE(1'b0), .Y(addr[23])
         );
  TBUFX2TS \router/addr_calc/addr_tri6[31]  ( .A(n6401), .OE(n1161), .Y(
        addr[31]) );
  TBUFX2TS \router/addr_calc/addr_tri6[23]  ( .A(
        \router/addr_calc/iir_write_addr[23] ), .OE(n6205), .Y(addr[23]) );
  TBUFX2TS \router/addr_calc/addr_tri[30]  ( .A(
        \router/addr_calc/fft_read_addr[30] ), .OE(n6206), .Y(addr[30]) );
  TBUFX2TS \router/addr_calc/addr_tri[29]  ( .A(n6169), .OE(n6206), .Y(
        addr[29]) );
  TBUFX2TS \router/addr_calc/addr_tri[28]  ( .A(n6625), .OE(n6206), .Y(
        addr[28]) );
  TBUFX2TS \router/addr_calc/addr_tri2[30]  ( .A(n6573), .OE(n6203), .Y(
        addr[30]) );
  TBUFX2TS \router/addr_calc/addr_tri2[29]  ( .A(n6168), .OE(n6203), .Y(
        addr[29]) );
  TBUFX2TS \router/addr_calc/addr_tri2[28]  ( .A(
        \router/addr_calc/fft_write_addr[28] ), .OE(n6203), .Y(addr[28]) );
  TBUFX2TS \router/addr_calc/addr_tri3[30]  ( .A(
        \router/addr_calc/fir_read_addr[30] ), .OE(n6201), .Y(addr[30]) );
  TBUFX2TS \router/addr_calc/addr_tri3[29]  ( .A(n6167), .OE(n6201), .Y(
        addr[29]) );
  TBUFX2TS \router/addr_calc/addr_tri3[28]  ( .A(n6529), .OE(n6201), .Y(
        addr[28]) );
  TBUFX2TS \router/addr_calc/addr_tri4[30]  ( .A(
        \router/addr_calc/fir_write_addr[30] ), .OE(n6202), .Y(addr[30]) );
  TBUFX2TS \router/addr_calc/addr_tri4[29]  ( .A(n6166), .OE(n6202), .Y(
        addr[29]) );
  TBUFX2TS \router/addr_calc/addr_tri4[28]  ( .A(n6475), .OE(n6202), .Y(
        addr[28]) );
  TBUFX2TS \router/addr_calc/addr_tri5[30]  ( .A(
        \router/addr_calc/iir_read_calc/count[30] ), .OE(1'b0), .Y(addr[30])
         );
  TBUFX2TS \router/addr_calc/addr_tri5[29]  ( .A(
        \router/addr_calc/iir_read_calc/count[29] ), .OE(1'b0), .Y(addr[29])
         );
  TBUFX2TS \router/addr_calc/addr_tri5[28]  ( .A(
        \router/addr_calc/iir_read_calc/count[28] ), .OE(1'b0), .Y(addr[28])
         );
  TBUFX2TS \router/addr_calc/addr_tri6[29]  ( .A(n6397), .OE(n6205), .Y(
        addr[29]) );
  TBUFX2TS \router/addr_calc/addr_tri6[28]  ( .A(n6393), .OE(n6205), .Y(
        addr[28]) );
  DFFTRX2TS \fifo_from_fft/fifo_cell14/data_out/en_reg  ( .D(n7085), .RN(
        \fifo_from_fft/fifo_cell13/reg_gtok/token ), .CK(clk), .Q(
        \fifo_from_fft/fifo_cell14/control_signal ) );
  DFFTRX2TS \fifo_from_fir/fifo_cell14/data_out/en_reg  ( .D(n7075), .RN(
        \fifo_from_fir/fifo_cell13/reg_gtok/token ), .CK(clk), .Q(
        \fifo_from_fir/fifo_cell14/control_signal ) );
  TBUFX2TS \fifo_from_fft/fifo_cell14/data_out/do_tri[30]  ( .A(1'b0), .OE(
        n7311), .Y(fft_data_in[30]) );
  TBUFX2TS \fifo_from_fft/fifo_cell15/data_out/do_tri[18]  ( .A(1'b0), .OE(
        n7137), .Y(fft_data_in[18]) );
  TBUFX2TS \fifo_from_fft/fifo_cell15/data_out/do_tri[17]  ( .A(1'b0), .OE(
        n7137), .Y(fft_data_in[17]) );
  TBUFX2TS \fifo_from_fft/fifo_cell15/data_out/do_tri[16]  ( .A(1'b0), .OE(
        n7137), .Y(fft_data_in[16]) );
  TBUFX2TS \fifo_from_fft/fifo_cell13/data_out/do_tri[18]  ( .A(1'b0), .OE(
        n6186), .Y(fft_data_in[18]) );
  TBUFX2TS \fifo_from_fft/fifo_cell13/data_out/do_tri[17]  ( .A(1'b0), .OE(
        n2441), .Y(fft_data_in[17]) );
  TBUFX2TS \fifo_from_fft/fifo_cell13/data_out/do_tri[16]  ( .A(1'b0), .OE(
        n6186), .Y(fft_data_in[16]) );
  TBUFX2TS \fifo_from_fft/fifo_cell12/data_out/do_tri[18]  ( .A(1'b0), .OE(
        n6185), .Y(fft_data_in[18]) );
  TBUFX2TS \fifo_from_fft/fifo_cell12/data_out/do_tri[17]  ( .A(1'b0), .OE(
        n2377), .Y(fft_data_in[17]) );
  TBUFX2TS \fifo_from_fft/fifo_cell12/data_out/do_tri[16]  ( .A(1'b0), .OE(
        n6185), .Y(fft_data_in[16]) );
  TBUFX2TS \fifo_from_fft/fifo_cell11/data_out/do_tri[18]  ( .A(1'b0), .OE(
        n6184), .Y(fft_data_in[18]) );
  TBUFX2TS \fifo_from_fft/fifo_cell11/data_out/do_tri[17]  ( .A(1'b0), .OE(
        n2313), .Y(fft_data_in[17]) );
  TBUFX2TS \fifo_from_fft/fifo_cell11/data_out/do_tri[16]  ( .A(1'b0), .OE(
        n6184), .Y(fft_data_in[16]) );
  TBUFX2TS \fifo_from_fft/fifo_cell10/data_out/do_tri[18]  ( .A(1'b0), .OE(
        n6183), .Y(fft_data_in[18]) );
  TBUFX2TS \fifo_from_fft/fifo_cell10/data_out/do_tri[17]  ( .A(1'b0), .OE(
        n2249), .Y(fft_data_in[17]) );
  TBUFX2TS \fifo_from_fft/fifo_cell10/data_out/do_tri[16]  ( .A(1'b0), .OE(
        n6183), .Y(fft_data_in[16]) );
  TBUFX2TS \fifo_from_fft/fifo_cell9/data_out/do_tri[18]  ( .A(1'b0), .OE(
        n6182), .Y(fft_data_in[18]) );
  TBUFX2TS \fifo_from_fft/fifo_cell9/data_out/do_tri[17]  ( .A(1'b0), .OE(
        n2185), .Y(fft_data_in[17]) );
  TBUFX2TS \fifo_from_fft/fifo_cell9/data_out/do_tri[16]  ( .A(1'b0), .OE(
        n6182), .Y(fft_data_in[16]) );
  TBUFX2TS \fifo_from_fft/fifo_cell8/data_out/do_tri[18]  ( .A(1'b0), .OE(
        n6181), .Y(fft_data_in[18]) );
  TBUFX2TS \fifo_from_fft/fifo_cell8/data_out/do_tri[17]  ( .A(1'b0), .OE(
        n2121), .Y(fft_data_in[17]) );
  TBUFX2TS \fifo_from_fft/fifo_cell8/data_out/do_tri[16]  ( .A(1'b0), .OE(
        n6181), .Y(fft_data_in[16]) );
  TBUFX2TS \fifo_from_fft/fifo_cell7/data_out/do_tri[18]  ( .A(1'b0), .OE(
        n6180), .Y(fft_data_in[18]) );
  TBUFX2TS \fifo_from_fft/fifo_cell7/data_out/do_tri[17]  ( .A(1'b0), .OE(
        n2057), .Y(fft_data_in[17]) );
  TBUFX2TS \fifo_from_fft/fifo_cell7/data_out/do_tri[16]  ( .A(1'b0), .OE(
        n6180), .Y(fft_data_in[16]) );
  TBUFX2TS \fifo_from_fft/fifo_cell6/data_out/do_tri[18]  ( .A(1'b0), .OE(
        n6179), .Y(fft_data_in[18]) );
  TBUFX2TS \fifo_from_fft/fifo_cell6/data_out/do_tri[17]  ( .A(1'b0), .OE(
        n1993), .Y(fft_data_in[17]) );
  TBUFX2TS \fifo_from_fft/fifo_cell6/data_out/do_tri[16]  ( .A(1'b0), .OE(
        n6179), .Y(fft_data_in[16]) );
  TBUFX2TS \fifo_from_fft/fifo_cell5/data_out/do_tri[18]  ( .A(1'b0), .OE(
        n6178), .Y(fft_data_in[18]) );
  TBUFX2TS \fifo_from_fft/fifo_cell5/data_out/do_tri[17]  ( .A(1'b0), .OE(
        n1929), .Y(fft_data_in[17]) );
  TBUFX2TS \fifo_from_fft/fifo_cell5/data_out/do_tri[16]  ( .A(1'b0), .OE(
        n6178), .Y(fft_data_in[16]) );
  TBUFX2TS \fifo_from_fft/fifo_cell4/data_out/do_tri[18]  ( .A(1'b0), .OE(
        n6177), .Y(fft_data_in[18]) );
  TBUFX2TS \fifo_from_fft/fifo_cell4/data_out/do_tri[17]  ( .A(1'b0), .OE(
        n1865), .Y(fft_data_in[17]) );
  TBUFX2TS \fifo_from_fft/fifo_cell4/data_out/do_tri[16]  ( .A(1'b0), .OE(
        n6177), .Y(fft_data_in[16]) );
  TBUFX2TS \fifo_from_fft/fifo_cell3/data_out/do_tri[18]  ( .A(1'b0), .OE(
        n6176), .Y(fft_data_in[18]) );
  TBUFX2TS \fifo_from_fft/fifo_cell3/data_out/do_tri[17]  ( .A(1'b0), .OE(
        n1801), .Y(fft_data_in[17]) );
  TBUFX2TS \fifo_from_fft/fifo_cell3/data_out/do_tri[16]  ( .A(1'b0), .OE(
        n6176), .Y(fft_data_in[16]) );
  TBUFX2TS \fifo_from_fft/fifo_cell2/data_out/do_tri[18]  ( .A(1'b0), .OE(
        n6175), .Y(fft_data_in[18]) );
  TBUFX2TS \fifo_from_fft/fifo_cell2/data_out/do_tri[17]  ( .A(1'b0), .OE(
        n1737), .Y(fft_data_in[17]) );
  TBUFX2TS \fifo_from_fft/fifo_cell2/data_out/do_tri[16]  ( .A(1'b0), .OE(
        n6175), .Y(fft_data_in[16]) );
  TBUFX2TS \fifo_from_fft/fifo_cell1/data_out/do_tri[18]  ( .A(1'b0), .OE(
        n6174), .Y(fft_data_in[18]) );
  TBUFX2TS \fifo_from_fft/fifo_cell1/data_out/do_tri[17]  ( .A(1'b0), .OE(
        n1673), .Y(fft_data_in[17]) );
  TBUFX2TS \fifo_from_fft/fifo_cell1/data_out/do_tri[16]  ( .A(1'b0), .OE(
        n6174), .Y(fft_data_in[16]) );
  TBUFX2TS \fifo_from_fir/fifo_cell14/data_out/do_tri[30]  ( .A(1'b0), .OE(
        n7301), .Y(fir_data_in[30]) );
  TBUFX2TS \fifo_from_fft/fifo_cell15/data_out/do_tri[22]  ( .A(1'b0), .OE(
        n6327), .Y(fft_data_in[22]) );
  TBUFX2TS \fifo_from_fft/fifo_cell15/data_out/do_tri[21]  ( .A(1'b0), .OE(
        n6173), .Y(fft_data_in[21]) );
  TBUFX2TS \fifo_from_fft/fifo_cell15/data_out/do_tri[20]  ( .A(1'b0), .OE(
        n6259), .Y(fft_data_in[20]) );
  TBUFX2TS \fifo_from_fft/fifo_cell15/data_out/do_tri[15]  ( .A(1'b0), .OE(
        n6258), .Y(fft_data_in[15]) );
  TBUFX2TS \fifo_from_fft/fifo_cell15/data_out/do_tri[14]  ( .A(1'b0), .OE(
        n6259), .Y(fft_data_in[14]) );
  TBUFX2TS \fifo_from_fft/fifo_cell15/data_out/do_tri[13]  ( .A(1'b0), .OE(
        n6258), .Y(fft_data_in[13]) );
  TBUFX2TS \fifo_from_fft/fifo_cell15/data_out/do_tri[12]  ( .A(1'b0), .OE(
        n6259), .Y(fft_data_in[12]) );
  TBUFX2TS \fifo_from_fft/fifo_cell15/data_out/do_tri[11]  ( .A(1'b0), .OE(
        n7138), .Y(fft_data_in[11]) );
  TBUFX2TS \fifo_from_fft/fifo_cell15/data_out/do_tri[10]  ( .A(1'b0), .OE(
        n7138), .Y(fft_data_in[10]) );
  TBUFX2TS \fifo_from_fft/fifo_cell15/data_out/do_tri[9]  ( .A(1'b0), .OE(
        n7138), .Y(fft_data_in[9]) );
  TBUFX2TS \fifo_from_fft/fifo_cell15/data_out/do_tri[8]  ( .A(1'b0), .OE(
        n7138), .Y(fft_data_in[8]) );
  TBUFX2TS \fifo_from_fft/fifo_cell15/data_out/do_tri[7]  ( .A(1'b0), .OE(
        n6328), .Y(fft_data_in[7]) );
  TBUFX2TS \fifo_from_fft/fifo_cell15/data_out/do_tri[6]  ( .A(1'b0), .OE(
        n6328), .Y(fft_data_in[6]) );
  TBUFX2TS \fifo_from_fft/fifo_cell15/data_out/do_tri[5]  ( .A(1'b0), .OE(
        n6173), .Y(fft_data_in[5]) );
  TBUFX2TS \fifo_from_fft/fifo_cell15/data_out/do_tri[4]  ( .A(1'b0), .OE(
        n6259), .Y(fft_data_in[4]) );
  TBUFX2TS \fifo_from_fft/fifo_cell15/data_out/do_tri[3]  ( .A(1'b0), .OE(
        n7139), .Y(fft_data_in[3]) );
  TBUFX2TS \fifo_from_fft/fifo_cell15/data_out/do_tri[2]  ( .A(1'b0), .OE(
        n7139), .Y(fft_data_in[2]) );
  TBUFX2TS \fifo_from_fft/fifo_cell15/data_out/do_tri[1]  ( .A(1'b0), .OE(
        n7139), .Y(fft_data_in[1]) );
  TBUFX2TS \fifo_from_fft/fifo_cell14/data_out/do_tri[26]  ( .A(1'b0), .OE(
        n7304), .Y(fft_data_in[26]) );
  TBUFX2TS \fifo_from_fft/fifo_cell14/data_out/do_tri[22]  ( .A(1'b0), .OE(
        n7305), .Y(fft_data_in[22]) );
  TBUFX2TS \fifo_from_fft/fifo_cell14/data_out/do_tri[21]  ( .A(1'b0), .OE(
        n7305), .Y(fft_data_in[21]) );
  TBUFX2TS \fifo_from_fft/fifo_cell14/data_out/do_tri[20]  ( .A(1'b0), .OE(
        n7305), .Y(fft_data_in[20]) );
  TBUFX2TS \fifo_from_fft/fifo_cell13/data_out/do_tri[22]  ( .A(1'b0), .OE(
        n7140), .Y(fft_data_in[22]) );
  TBUFX2TS \fifo_from_fft/fifo_cell13/data_out/do_tri[21]  ( .A(1'b0), .OE(
        n7140), .Y(fft_data_in[21]) );
  TBUFX2TS \fifo_from_fft/fifo_cell13/data_out/do_tri[20]  ( .A(1'b0), .OE(
        n7140), .Y(fft_data_in[20]) );
  TBUFX2TS \fifo_from_fft/fifo_cell13/data_out/do_tri[15]  ( .A(1'b0), .OE(
        n7141), .Y(fft_data_in[15]) );
  TBUFX2TS \fifo_from_fft/fifo_cell13/data_out/do_tri[14]  ( .A(1'b0), .OE(
        n7141), .Y(fft_data_in[14]) );
  TBUFX2TS \fifo_from_fft/fifo_cell13/data_out/do_tri[13]  ( .A(1'b0), .OE(
        n7141), .Y(fft_data_in[13]) );
  TBUFX2TS \fifo_from_fft/fifo_cell13/data_out/do_tri[12]  ( .A(1'b0), .OE(
        n7141), .Y(fft_data_in[12]) );
  TBUFX2TS \fifo_from_fft/fifo_cell13/data_out/do_tri[11]  ( .A(1'b0), .OE(
        n6267), .Y(fft_data_in[11]) );
  TBUFX2TS \fifo_from_fft/fifo_cell13/data_out/do_tri[10]  ( .A(1'b0), .OE(
        n6268), .Y(fft_data_in[10]) );
  TBUFX2TS \fifo_from_fft/fifo_cell13/data_out/do_tri[9]  ( .A(1'b0), .OE(
        n6267), .Y(fft_data_in[9]) );
  TBUFX2TS \fifo_from_fft/fifo_cell13/data_out/do_tri[8]  ( .A(1'b0), .OE(
        n6268), .Y(fft_data_in[8]) );
  TBUFX2TS \fifo_from_fft/fifo_cell13/data_out/do_tri[7]  ( .A(1'b0), .OE(
        n7142), .Y(fft_data_in[7]) );
  TBUFX2TS \fifo_from_fft/fifo_cell13/data_out/do_tri[6]  ( .A(1'b0), .OE(
        n7142), .Y(fft_data_in[6]) );
  TBUFX2TS \fifo_from_fft/fifo_cell13/data_out/do_tri[5]  ( .A(1'b0), .OE(
        n7142), .Y(fft_data_in[5]) );
  TBUFX2TS \fifo_from_fft/fifo_cell13/data_out/do_tri[4]  ( .A(1'b0), .OE(
        n7142), .Y(fft_data_in[4]) );
  TBUFX2TS \fifo_from_fft/fifo_cell13/data_out/do_tri[3]  ( .A(1'b0), .OE(
        n6186), .Y(fft_data_in[3]) );
  TBUFX2TS \fifo_from_fft/fifo_cell13/data_out/do_tri[2]  ( .A(1'b0), .OE(
        n2441), .Y(fft_data_in[2]) );
  TBUFX2TS \fifo_from_fft/fifo_cell13/data_out/do_tri[1]  ( .A(1'b0), .OE(
        n6334), .Y(fft_data_in[1]) );
  TBUFX2TS \fifo_from_fft/fifo_cell12/data_out/do_tri[22]  ( .A(1'b0), .OE(
        n7143), .Y(fft_data_in[22]) );
  TBUFX2TS \fifo_from_fft/fifo_cell12/data_out/do_tri[21]  ( .A(1'b0), .OE(
        n7143), .Y(fft_data_in[21]) );
  TBUFX2TS \fifo_from_fft/fifo_cell12/data_out/do_tri[20]  ( .A(1'b0), .OE(
        n7143), .Y(fft_data_in[20]) );
  TBUFX2TS \fifo_from_fft/fifo_cell12/data_out/do_tri[15]  ( .A(1'b0), .OE(
        n7144), .Y(fft_data_in[15]) );
  TBUFX2TS \fifo_from_fft/fifo_cell12/data_out/do_tri[14]  ( .A(1'b0), .OE(
        n7144), .Y(fft_data_in[14]) );
  TBUFX2TS \fifo_from_fft/fifo_cell12/data_out/do_tri[13]  ( .A(1'b0), .OE(
        n7144), .Y(fft_data_in[13]) );
  TBUFX2TS \fifo_from_fft/fifo_cell12/data_out/do_tri[12]  ( .A(1'b0), .OE(
        n7144), .Y(fft_data_in[12]) );
  TBUFX2TS \fifo_from_fft/fifo_cell12/data_out/do_tri[11]  ( .A(1'b0), .OE(
        n6276), .Y(fft_data_in[11]) );
  TBUFX2TS \fifo_from_fft/fifo_cell12/data_out/do_tri[10]  ( .A(1'b0), .OE(
        n6277), .Y(fft_data_in[10]) );
  TBUFX2TS \fifo_from_fft/fifo_cell12/data_out/do_tri[9]  ( .A(1'b0), .OE(
        n6276), .Y(fft_data_in[9]) );
  TBUFX2TS \fifo_from_fft/fifo_cell12/data_out/do_tri[8]  ( .A(1'b0), .OE(
        n6277), .Y(fft_data_in[8]) );
  TBUFX2TS \fifo_from_fft/fifo_cell12/data_out/do_tri[7]  ( .A(1'b0), .OE(
        n7145), .Y(fft_data_in[7]) );
  TBUFX2TS \fifo_from_fft/fifo_cell12/data_out/do_tri[6]  ( .A(1'b0), .OE(
        n7145), .Y(fft_data_in[6]) );
  TBUFX2TS \fifo_from_fft/fifo_cell12/data_out/do_tri[5]  ( .A(1'b0), .OE(
        n7145), .Y(fft_data_in[5]) );
  TBUFX2TS \fifo_from_fft/fifo_cell12/data_out/do_tri[4]  ( .A(1'b0), .OE(
        n7145), .Y(fft_data_in[4]) );
  TBUFX2TS \fifo_from_fft/fifo_cell12/data_out/do_tri[3]  ( .A(1'b0), .OE(
        n6185), .Y(fft_data_in[3]) );
  TBUFX2TS \fifo_from_fft/fifo_cell12/data_out/do_tri[2]  ( .A(1'b0), .OE(
        n2377), .Y(fft_data_in[2]) );
  TBUFX2TS \fifo_from_fft/fifo_cell12/data_out/do_tri[1]  ( .A(1'b0), .OE(
        n6337), .Y(fft_data_in[1]) );
  TBUFX2TS \fifo_from_fft/fifo_cell11/data_out/do_tri[22]  ( .A(1'b0), .OE(
        n7146), .Y(fft_data_in[22]) );
  TBUFX2TS \fifo_from_fft/fifo_cell11/data_out/do_tri[21]  ( .A(1'b0), .OE(
        n7146), .Y(fft_data_in[21]) );
  TBUFX2TS \fifo_from_fft/fifo_cell11/data_out/do_tri[20]  ( .A(1'b0), .OE(
        n7146), .Y(fft_data_in[20]) );
  TBUFX2TS \fifo_from_fft/fifo_cell11/data_out/do_tri[15]  ( .A(1'b0), .OE(
        n7147), .Y(fft_data_in[15]) );
  TBUFX2TS \fifo_from_fft/fifo_cell11/data_out/do_tri[14]  ( .A(1'b0), .OE(
        n7147), .Y(fft_data_in[14]) );
  TBUFX2TS \fifo_from_fft/fifo_cell11/data_out/do_tri[13]  ( .A(1'b0), .OE(
        n7147), .Y(fft_data_in[13]) );
  TBUFX2TS \fifo_from_fft/fifo_cell11/data_out/do_tri[12]  ( .A(1'b0), .OE(
        n7147), .Y(fft_data_in[12]) );
  TBUFX2TS \fifo_from_fft/fifo_cell11/data_out/do_tri[11]  ( .A(1'b0), .OE(
        n6285), .Y(fft_data_in[11]) );
  TBUFX2TS \fifo_from_fft/fifo_cell11/data_out/do_tri[10]  ( .A(1'b0), .OE(
        n6286), .Y(fft_data_in[10]) );
  TBUFX2TS \fifo_from_fft/fifo_cell11/data_out/do_tri[9]  ( .A(1'b0), .OE(
        n6285), .Y(fft_data_in[9]) );
  TBUFX2TS \fifo_from_fft/fifo_cell11/data_out/do_tri[8]  ( .A(1'b0), .OE(
        n6286), .Y(fft_data_in[8]) );
  TBUFX2TS \fifo_from_fft/fifo_cell11/data_out/do_tri[7]  ( .A(1'b0), .OE(
        n7148), .Y(fft_data_in[7]) );
  TBUFX2TS \fifo_from_fft/fifo_cell11/data_out/do_tri[6]  ( .A(1'b0), .OE(
        n7148), .Y(fft_data_in[6]) );
  TBUFX2TS \fifo_from_fft/fifo_cell11/data_out/do_tri[5]  ( .A(1'b0), .OE(
        n7148), .Y(fft_data_in[5]) );
  TBUFX2TS \fifo_from_fft/fifo_cell11/data_out/do_tri[4]  ( .A(1'b0), .OE(
        n7148), .Y(fft_data_in[4]) );
  TBUFX2TS \fifo_from_fft/fifo_cell11/data_out/do_tri[3]  ( .A(1'b0), .OE(
        n6184), .Y(fft_data_in[3]) );
  TBUFX2TS \fifo_from_fft/fifo_cell11/data_out/do_tri[2]  ( .A(1'b0), .OE(
        n2313), .Y(fft_data_in[2]) );
  TBUFX2TS \fifo_from_fft/fifo_cell11/data_out/do_tri[1]  ( .A(1'b0), .OE(
        n6343), .Y(fft_data_in[1]) );
  TBUFX2TS \fifo_from_fft/fifo_cell10/data_out/do_tri[22]  ( .A(1'b0), .OE(
        n7149), .Y(fft_data_in[22]) );
  TBUFX2TS \fifo_from_fft/fifo_cell10/data_out/do_tri[21]  ( .A(1'b0), .OE(
        n7149), .Y(fft_data_in[21]) );
  TBUFX2TS \fifo_from_fft/fifo_cell10/data_out/do_tri[20]  ( .A(1'b0), .OE(
        n7149), .Y(fft_data_in[20]) );
  TBUFX2TS \fifo_from_fft/fifo_cell10/data_out/do_tri[15]  ( .A(1'b0), .OE(
        n7150), .Y(fft_data_in[15]) );
  TBUFX2TS \fifo_from_fft/fifo_cell10/data_out/do_tri[14]  ( .A(1'b0), .OE(
        n7150), .Y(fft_data_in[14]) );
  TBUFX2TS \fifo_from_fft/fifo_cell10/data_out/do_tri[13]  ( .A(1'b0), .OE(
        n7150), .Y(fft_data_in[13]) );
  TBUFX2TS \fifo_from_fft/fifo_cell10/data_out/do_tri[12]  ( .A(1'b0), .OE(
        n7150), .Y(fft_data_in[12]) );
  TBUFX2TS \fifo_from_fft/fifo_cell10/data_out/do_tri[11]  ( .A(1'b0), .OE(
        n6294), .Y(fft_data_in[11]) );
  TBUFX2TS \fifo_from_fft/fifo_cell10/data_out/do_tri[10]  ( .A(1'b0), .OE(
        n6295), .Y(fft_data_in[10]) );
  TBUFX2TS \fifo_from_fft/fifo_cell10/data_out/do_tri[9]  ( .A(1'b0), .OE(
        n6294), .Y(fft_data_in[9]) );
  TBUFX2TS \fifo_from_fft/fifo_cell10/data_out/do_tri[8]  ( .A(1'b0), .OE(
        n6295), .Y(fft_data_in[8]) );
  TBUFX2TS \fifo_from_fft/fifo_cell10/data_out/do_tri[7]  ( .A(1'b0), .OE(
        n7151), .Y(fft_data_in[7]) );
  TBUFX2TS \fifo_from_fft/fifo_cell10/data_out/do_tri[6]  ( .A(1'b0), .OE(
        n7151), .Y(fft_data_in[6]) );
  TBUFX2TS \fifo_from_fft/fifo_cell10/data_out/do_tri[5]  ( .A(1'b0), .OE(
        n7151), .Y(fft_data_in[5]) );
  TBUFX2TS \fifo_from_fft/fifo_cell10/data_out/do_tri[4]  ( .A(1'b0), .OE(
        n7151), .Y(fft_data_in[4]) );
  TBUFX2TS \fifo_from_fft/fifo_cell10/data_out/do_tri[3]  ( .A(1'b0), .OE(
        n6183), .Y(fft_data_in[3]) );
  TBUFX2TS \fifo_from_fft/fifo_cell10/data_out/do_tri[2]  ( .A(1'b0), .OE(
        n2249), .Y(fft_data_in[2]) );
  TBUFX2TS \fifo_from_fft/fifo_cell10/data_out/do_tri[1]  ( .A(1'b0), .OE(
        n6346), .Y(fft_data_in[1]) );
  TBUFX2TS \fifo_from_fft/fifo_cell9/data_out/do_tri[22]  ( .A(1'b0), .OE(
        n7152), .Y(fft_data_in[22]) );
  TBUFX2TS \fifo_from_fft/fifo_cell9/data_out/do_tri[21]  ( .A(1'b0), .OE(
        n7152), .Y(fft_data_in[21]) );
  TBUFX2TS \fifo_from_fft/fifo_cell9/data_out/do_tri[20]  ( .A(1'b0), .OE(
        n7152), .Y(fft_data_in[20]) );
  TBUFX2TS \fifo_from_fft/fifo_cell9/data_out/do_tri[15]  ( .A(1'b0), .OE(
        n7153), .Y(fft_data_in[15]) );
  TBUFX2TS \fifo_from_fft/fifo_cell9/data_out/do_tri[14]  ( .A(1'b0), .OE(
        n7153), .Y(fft_data_in[14]) );
  TBUFX2TS \fifo_from_fft/fifo_cell9/data_out/do_tri[13]  ( .A(1'b0), .OE(
        n7153), .Y(fft_data_in[13]) );
  TBUFX2TS \fifo_from_fft/fifo_cell9/data_out/do_tri[12]  ( .A(1'b0), .OE(
        n7153), .Y(fft_data_in[12]) );
  TBUFX2TS \fifo_from_fft/fifo_cell9/data_out/do_tri[11]  ( .A(1'b0), .OE(
        n6303), .Y(fft_data_in[11]) );
  TBUFX2TS \fifo_from_fft/fifo_cell9/data_out/do_tri[10]  ( .A(1'b0), .OE(
        n6304), .Y(fft_data_in[10]) );
  TBUFX2TS \fifo_from_fft/fifo_cell9/data_out/do_tri[9]  ( .A(1'b0), .OE(n6303), .Y(fft_data_in[9]) );
  TBUFX2TS \fifo_from_fft/fifo_cell9/data_out/do_tri[8]  ( .A(1'b0), .OE(n6304), .Y(fft_data_in[8]) );
  TBUFX2TS \fifo_from_fft/fifo_cell9/data_out/do_tri[7]  ( .A(1'b0), .OE(n7154), .Y(fft_data_in[7]) );
  TBUFX2TS \fifo_from_fft/fifo_cell9/data_out/do_tri[6]  ( .A(1'b0), .OE(n7154), .Y(fft_data_in[6]) );
  TBUFX2TS \fifo_from_fft/fifo_cell9/data_out/do_tri[5]  ( .A(1'b0), .OE(n7154), .Y(fft_data_in[5]) );
  TBUFX2TS \fifo_from_fft/fifo_cell9/data_out/do_tri[4]  ( .A(1'b0), .OE(n7154), .Y(fft_data_in[4]) );
  TBUFX2TS \fifo_from_fft/fifo_cell9/data_out/do_tri[3]  ( .A(1'b0), .OE(n6182), .Y(fft_data_in[3]) );
  TBUFX2TS \fifo_from_fft/fifo_cell9/data_out/do_tri[2]  ( .A(1'b0), .OE(n2185), .Y(fft_data_in[2]) );
  TBUFX2TS \fifo_from_fft/fifo_cell9/data_out/do_tri[1]  ( .A(1'b0), .OE(n6352), .Y(fft_data_in[1]) );
  TBUFX2TS \fifo_from_fft/fifo_cell8/data_out/do_tri[22]  ( .A(1'b0), .OE(
        n7155), .Y(fft_data_in[22]) );
  TBUFX2TS \fifo_from_fft/fifo_cell8/data_out/do_tri[21]  ( .A(1'b0), .OE(
        n7155), .Y(fft_data_in[21]) );
  TBUFX2TS \fifo_from_fft/fifo_cell8/data_out/do_tri[20]  ( .A(1'b0), .OE(
        n7155), .Y(fft_data_in[20]) );
  TBUFX2TS \fifo_from_fft/fifo_cell8/data_out/do_tri[15]  ( .A(1'b0), .OE(
        n7156), .Y(fft_data_in[15]) );
  TBUFX2TS \fifo_from_fft/fifo_cell8/data_out/do_tri[14]  ( .A(1'b0), .OE(
        n7156), .Y(fft_data_in[14]) );
  TBUFX2TS \fifo_from_fft/fifo_cell8/data_out/do_tri[13]  ( .A(1'b0), .OE(
        n7156), .Y(fft_data_in[13]) );
  TBUFX2TS \fifo_from_fft/fifo_cell8/data_out/do_tri[12]  ( .A(1'b0), .OE(
        n7156), .Y(fft_data_in[12]) );
  TBUFX2TS \fifo_from_fft/fifo_cell8/data_out/do_tri[11]  ( .A(1'b0), .OE(
        n6312), .Y(fft_data_in[11]) );
  TBUFX2TS \fifo_from_fft/fifo_cell8/data_out/do_tri[10]  ( .A(1'b0), .OE(
        n6313), .Y(fft_data_in[10]) );
  TBUFX2TS \fifo_from_fft/fifo_cell8/data_out/do_tri[9]  ( .A(1'b0), .OE(n6312), .Y(fft_data_in[9]) );
  TBUFX2TS \fifo_from_fft/fifo_cell8/data_out/do_tri[8]  ( .A(1'b0), .OE(n6313), .Y(fft_data_in[8]) );
  TBUFX2TS \fifo_from_fft/fifo_cell8/data_out/do_tri[7]  ( .A(1'b0), .OE(n7157), .Y(fft_data_in[7]) );
  TBUFX2TS \fifo_from_fft/fifo_cell8/data_out/do_tri[6]  ( .A(1'b0), .OE(n7157), .Y(fft_data_in[6]) );
  TBUFX2TS \fifo_from_fft/fifo_cell8/data_out/do_tri[5]  ( .A(1'b0), .OE(n7157), .Y(fft_data_in[5]) );
  TBUFX2TS \fifo_from_fft/fifo_cell8/data_out/do_tri[4]  ( .A(1'b0), .OE(n7157), .Y(fft_data_in[4]) );
  TBUFX2TS \fifo_from_fft/fifo_cell8/data_out/do_tri[3]  ( .A(1'b0), .OE(n6181), .Y(fft_data_in[3]) );
  TBUFX2TS \fifo_from_fft/fifo_cell8/data_out/do_tri[2]  ( .A(1'b0), .OE(n2121), .Y(fft_data_in[2]) );
  TBUFX2TS \fifo_from_fft/fifo_cell8/data_out/do_tri[1]  ( .A(1'b0), .OE(n6355), .Y(fft_data_in[1]) );
  TBUFX2TS \fifo_from_fft/fifo_cell7/data_out/do_tri[22]  ( .A(1'b0), .OE(
        n7158), .Y(fft_data_in[22]) );
  TBUFX2TS \fifo_from_fft/fifo_cell7/data_out/do_tri[21]  ( .A(1'b0), .OE(
        n7158), .Y(fft_data_in[21]) );
  TBUFX2TS \fifo_from_fft/fifo_cell7/data_out/do_tri[20]  ( .A(1'b0), .OE(
        n7158), .Y(fft_data_in[20]) );
  TBUFX2TS \fifo_from_fft/fifo_cell7/data_out/do_tri[15]  ( .A(1'b0), .OE(
        n7159), .Y(fft_data_in[15]) );
  TBUFX2TS \fifo_from_fft/fifo_cell7/data_out/do_tri[14]  ( .A(1'b0), .OE(
        n7159), .Y(fft_data_in[14]) );
  TBUFX2TS \fifo_from_fft/fifo_cell7/data_out/do_tri[13]  ( .A(1'b0), .OE(
        n7159), .Y(fft_data_in[13]) );
  TBUFX2TS \fifo_from_fft/fifo_cell7/data_out/do_tri[12]  ( .A(1'b0), .OE(
        n7159), .Y(fft_data_in[12]) );
  TBUFX2TS \fifo_from_fft/fifo_cell7/data_out/do_tri[11]  ( .A(1'b0), .OE(
        n6321), .Y(fft_data_in[11]) );
  TBUFX2TS \fifo_from_fft/fifo_cell7/data_out/do_tri[10]  ( .A(1'b0), .OE(
        n6322), .Y(fft_data_in[10]) );
  TBUFX2TS \fifo_from_fft/fifo_cell7/data_out/do_tri[9]  ( .A(1'b0), .OE(n6321), .Y(fft_data_in[9]) );
  TBUFX2TS \fifo_from_fft/fifo_cell7/data_out/do_tri[8]  ( .A(1'b0), .OE(n6322), .Y(fft_data_in[8]) );
  TBUFX2TS \fifo_from_fft/fifo_cell7/data_out/do_tri[7]  ( .A(1'b0), .OE(n7160), .Y(fft_data_in[7]) );
  TBUFX2TS \fifo_from_fft/fifo_cell7/data_out/do_tri[6]  ( .A(1'b0), .OE(n7160), .Y(fft_data_in[6]) );
  TBUFX2TS \fifo_from_fft/fifo_cell7/data_out/do_tri[5]  ( .A(1'b0), .OE(n7160), .Y(fft_data_in[5]) );
  TBUFX2TS \fifo_from_fft/fifo_cell7/data_out/do_tri[4]  ( .A(1'b0), .OE(n7160), .Y(fft_data_in[4]) );
  TBUFX2TS \fifo_from_fft/fifo_cell7/data_out/do_tri[3]  ( .A(1'b0), .OE(n6180), .Y(fft_data_in[3]) );
  TBUFX2TS \fifo_from_fft/fifo_cell7/data_out/do_tri[2]  ( .A(1'b0), .OE(n2057), .Y(fft_data_in[2]) );
  TBUFX2TS \fifo_from_fft/fifo_cell7/data_out/do_tri[1]  ( .A(1'b0), .OE(n6361), .Y(fft_data_in[1]) );
  TBUFX2TS \fifo_from_fft/fifo_cell6/data_out/do_tri[22]  ( .A(1'b0), .OE(
        n7161), .Y(fft_data_in[22]) );
  TBUFX2TS \fifo_from_fft/fifo_cell6/data_out/do_tri[21]  ( .A(1'b0), .OE(
        n7161), .Y(fft_data_in[21]) );
  TBUFX2TS \fifo_from_fft/fifo_cell6/data_out/do_tri[20]  ( .A(1'b0), .OE(
        n7161), .Y(fft_data_in[20]) );
  TBUFX2TS \fifo_from_fft/fifo_cell6/data_out/do_tri[15]  ( .A(1'b0), .OE(
        n7162), .Y(fft_data_in[15]) );
  TBUFX2TS \fifo_from_fft/fifo_cell6/data_out/do_tri[14]  ( .A(1'b0), .OE(
        n7162), .Y(fft_data_in[14]) );
  TBUFX2TS \fifo_from_fft/fifo_cell6/data_out/do_tri[13]  ( .A(1'b0), .OE(
        n7162), .Y(fft_data_in[13]) );
  TBUFX2TS \fifo_from_fft/fifo_cell6/data_out/do_tri[12]  ( .A(1'b0), .OE(
        n7162), .Y(fft_data_in[12]) );
  TBUFX2TS \fifo_from_fft/fifo_cell6/data_out/do_tri[11]  ( .A(1'b0), .OE(
        n6330), .Y(fft_data_in[11]) );
  TBUFX2TS \fifo_from_fft/fifo_cell6/data_out/do_tri[10]  ( .A(1'b0), .OE(
        n6331), .Y(fft_data_in[10]) );
  TBUFX2TS \fifo_from_fft/fifo_cell6/data_out/do_tri[9]  ( .A(1'b0), .OE(n6330), .Y(fft_data_in[9]) );
  TBUFX2TS \fifo_from_fft/fifo_cell6/data_out/do_tri[8]  ( .A(1'b0), .OE(n6331), .Y(fft_data_in[8]) );
  TBUFX2TS \fifo_from_fft/fifo_cell6/data_out/do_tri[7]  ( .A(1'b0), .OE(n7163), .Y(fft_data_in[7]) );
  TBUFX2TS \fifo_from_fft/fifo_cell6/data_out/do_tri[6]  ( .A(1'b0), .OE(n7163), .Y(fft_data_in[6]) );
  TBUFX2TS \fifo_from_fft/fifo_cell6/data_out/do_tri[5]  ( .A(1'b0), .OE(n7163), .Y(fft_data_in[5]) );
  TBUFX2TS \fifo_from_fft/fifo_cell6/data_out/do_tri[4]  ( .A(1'b0), .OE(n7163), .Y(fft_data_in[4]) );
  TBUFX2TS \fifo_from_fft/fifo_cell6/data_out/do_tri[3]  ( .A(1'b0), .OE(n6179), .Y(fft_data_in[3]) );
  TBUFX2TS \fifo_from_fft/fifo_cell6/data_out/do_tri[2]  ( .A(1'b0), .OE(n1993), .Y(fft_data_in[2]) );
  TBUFX2TS \fifo_from_fft/fifo_cell6/data_out/do_tri[1]  ( .A(1'b0), .OE(n6364), .Y(fft_data_in[1]) );
  TBUFX2TS \fifo_from_fft/fifo_cell5/data_out/do_tri[22]  ( .A(1'b0), .OE(
        n7164), .Y(fft_data_in[22]) );
  TBUFX2TS \fifo_from_fft/fifo_cell5/data_out/do_tri[21]  ( .A(1'b0), .OE(
        n7164), .Y(fft_data_in[21]) );
  TBUFX2TS \fifo_from_fft/fifo_cell5/data_out/do_tri[20]  ( .A(1'b0), .OE(
        n7164), .Y(fft_data_in[20]) );
  TBUFX2TS \fifo_from_fft/fifo_cell5/data_out/do_tri[15]  ( .A(1'b0), .OE(
        n7165), .Y(fft_data_in[15]) );
  TBUFX2TS \fifo_from_fft/fifo_cell5/data_out/do_tri[14]  ( .A(1'b0), .OE(
        n7165), .Y(fft_data_in[14]) );
  TBUFX2TS \fifo_from_fft/fifo_cell5/data_out/do_tri[13]  ( .A(1'b0), .OE(
        n7165), .Y(fft_data_in[13]) );
  TBUFX2TS \fifo_from_fft/fifo_cell5/data_out/do_tri[12]  ( .A(1'b0), .OE(
        n7165), .Y(fft_data_in[12]) );
  TBUFX2TS \fifo_from_fft/fifo_cell5/data_out/do_tri[11]  ( .A(1'b0), .OE(
        n6339), .Y(fft_data_in[11]) );
  TBUFX2TS \fifo_from_fft/fifo_cell5/data_out/do_tri[10]  ( .A(1'b0), .OE(
        n6340), .Y(fft_data_in[10]) );
  TBUFX2TS \fifo_from_fft/fifo_cell5/data_out/do_tri[9]  ( .A(1'b0), .OE(n6339), .Y(fft_data_in[9]) );
  TBUFX2TS \fifo_from_fft/fifo_cell5/data_out/do_tri[8]  ( .A(1'b0), .OE(n6340), .Y(fft_data_in[8]) );
  TBUFX2TS \fifo_from_fft/fifo_cell5/data_out/do_tri[7]  ( .A(1'b0), .OE(n7166), .Y(fft_data_in[7]) );
  TBUFX2TS \fifo_from_fft/fifo_cell5/data_out/do_tri[6]  ( .A(1'b0), .OE(n7166), .Y(fft_data_in[6]) );
  TBUFX2TS \fifo_from_fft/fifo_cell5/data_out/do_tri[5]  ( .A(1'b0), .OE(n7166), .Y(fft_data_in[5]) );
  TBUFX2TS \fifo_from_fft/fifo_cell5/data_out/do_tri[4]  ( .A(1'b0), .OE(n7166), .Y(fft_data_in[4]) );
  TBUFX2TS \fifo_from_fft/fifo_cell5/data_out/do_tri[3]  ( .A(1'b0), .OE(n6178), .Y(fft_data_in[3]) );
  TBUFX2TS \fifo_from_fft/fifo_cell5/data_out/do_tri[2]  ( .A(1'b0), .OE(n1929), .Y(fft_data_in[2]) );
  TBUFX2TS \fifo_from_fft/fifo_cell5/data_out/do_tri[1]  ( .A(1'b0), .OE(n6370), .Y(fft_data_in[1]) );
  TBUFX2TS \fifo_from_fft/fifo_cell4/data_out/do_tri[22]  ( .A(1'b0), .OE(
        n7167), .Y(fft_data_in[22]) );
  TBUFX2TS \fifo_from_fft/fifo_cell4/data_out/do_tri[21]  ( .A(1'b0), .OE(
        n7167), .Y(fft_data_in[21]) );
  TBUFX2TS \fifo_from_fft/fifo_cell4/data_out/do_tri[20]  ( .A(1'b0), .OE(
        n7167), .Y(fft_data_in[20]) );
  TBUFX2TS \fifo_from_fft/fifo_cell4/data_out/do_tri[15]  ( .A(1'b0), .OE(
        n7168), .Y(fft_data_in[15]) );
  TBUFX2TS \fifo_from_fft/fifo_cell4/data_out/do_tri[14]  ( .A(1'b0), .OE(
        n7168), .Y(fft_data_in[14]) );
  TBUFX2TS \fifo_from_fft/fifo_cell4/data_out/do_tri[13]  ( .A(1'b0), .OE(
        n7168), .Y(fft_data_in[13]) );
  TBUFX2TS \fifo_from_fft/fifo_cell4/data_out/do_tri[12]  ( .A(1'b0), .OE(
        n7168), .Y(fft_data_in[12]) );
  TBUFX2TS \fifo_from_fft/fifo_cell4/data_out/do_tri[11]  ( .A(1'b0), .OE(
        n6348), .Y(fft_data_in[11]) );
  TBUFX2TS \fifo_from_fft/fifo_cell4/data_out/do_tri[10]  ( .A(1'b0), .OE(
        n6349), .Y(fft_data_in[10]) );
  TBUFX2TS \fifo_from_fft/fifo_cell4/data_out/do_tri[9]  ( .A(1'b0), .OE(n6348), .Y(fft_data_in[9]) );
  TBUFX2TS \fifo_from_fft/fifo_cell4/data_out/do_tri[8]  ( .A(1'b0), .OE(n6349), .Y(fft_data_in[8]) );
  TBUFX2TS \fifo_from_fft/fifo_cell4/data_out/do_tri[7]  ( .A(1'b0), .OE(n7169), .Y(fft_data_in[7]) );
  TBUFX2TS \fifo_from_fft/fifo_cell4/data_out/do_tri[6]  ( .A(1'b0), .OE(n7169), .Y(fft_data_in[6]) );
  TBUFX2TS \fifo_from_fft/fifo_cell4/data_out/do_tri[5]  ( .A(1'b0), .OE(n7169), .Y(fft_data_in[5]) );
  TBUFX2TS \fifo_from_fft/fifo_cell4/data_out/do_tri[4]  ( .A(1'b0), .OE(n7169), .Y(fft_data_in[4]) );
  TBUFX2TS \fifo_from_fft/fifo_cell4/data_out/do_tri[3]  ( .A(1'b0), .OE(n6177), .Y(fft_data_in[3]) );
  TBUFX2TS \fifo_from_fft/fifo_cell4/data_out/do_tri[2]  ( .A(1'b0), .OE(n1865), .Y(fft_data_in[2]) );
  TBUFX2TS \fifo_from_fft/fifo_cell4/data_out/do_tri[1]  ( .A(1'b0), .OE(n6373), .Y(fft_data_in[1]) );
  TBUFX2TS \fifo_from_fft/fifo_cell3/data_out/do_tri[22]  ( .A(1'b0), .OE(
        n7170), .Y(fft_data_in[22]) );
  TBUFX2TS \fifo_from_fft/fifo_cell3/data_out/do_tri[21]  ( .A(1'b0), .OE(
        n7170), .Y(fft_data_in[21]) );
  TBUFX2TS \fifo_from_fft/fifo_cell3/data_out/do_tri[20]  ( .A(1'b0), .OE(
        n7170), .Y(fft_data_in[20]) );
  TBUFX2TS \fifo_from_fft/fifo_cell3/data_out/do_tri[15]  ( .A(1'b0), .OE(
        n7171), .Y(fft_data_in[15]) );
  TBUFX2TS \fifo_from_fft/fifo_cell3/data_out/do_tri[14]  ( .A(1'b0), .OE(
        n7171), .Y(fft_data_in[14]) );
  TBUFX2TS \fifo_from_fft/fifo_cell3/data_out/do_tri[13]  ( .A(1'b0), .OE(
        n7171), .Y(fft_data_in[13]) );
  TBUFX2TS \fifo_from_fft/fifo_cell3/data_out/do_tri[12]  ( .A(1'b0), .OE(
        n7171), .Y(fft_data_in[12]) );
  TBUFX2TS \fifo_from_fft/fifo_cell3/data_out/do_tri[11]  ( .A(1'b0), .OE(
        n6357), .Y(fft_data_in[11]) );
  TBUFX2TS \fifo_from_fft/fifo_cell3/data_out/do_tri[10]  ( .A(1'b0), .OE(
        n6358), .Y(fft_data_in[10]) );
  TBUFX2TS \fifo_from_fft/fifo_cell3/data_out/do_tri[9]  ( .A(1'b0), .OE(n6357), .Y(fft_data_in[9]) );
  TBUFX2TS \fifo_from_fft/fifo_cell3/data_out/do_tri[8]  ( .A(1'b0), .OE(n6358), .Y(fft_data_in[8]) );
  TBUFX2TS \fifo_from_fft/fifo_cell3/data_out/do_tri[7]  ( .A(1'b0), .OE(n7172), .Y(fft_data_in[7]) );
  TBUFX2TS \fifo_from_fft/fifo_cell3/data_out/do_tri[6]  ( .A(1'b0), .OE(n7172), .Y(fft_data_in[6]) );
  TBUFX2TS \fifo_from_fft/fifo_cell3/data_out/do_tri[5]  ( .A(1'b0), .OE(n7172), .Y(fft_data_in[5]) );
  TBUFX2TS \fifo_from_fft/fifo_cell3/data_out/do_tri[4]  ( .A(1'b0), .OE(n7172), .Y(fft_data_in[4]) );
  TBUFX2TS \fifo_from_fft/fifo_cell3/data_out/do_tri[3]  ( .A(1'b0), .OE(n6176), .Y(fft_data_in[3]) );
  TBUFX2TS \fifo_from_fft/fifo_cell3/data_out/do_tri[2]  ( .A(1'b0), .OE(n1801), .Y(fft_data_in[2]) );
  TBUFX2TS \fifo_from_fft/fifo_cell3/data_out/do_tri[1]  ( .A(1'b0), .OE(n6379), .Y(fft_data_in[1]) );
  TBUFX2TS \fifo_from_fft/fifo_cell2/data_out/do_tri[22]  ( .A(1'b0), .OE(
        n7173), .Y(fft_data_in[22]) );
  TBUFX2TS \fifo_from_fft/fifo_cell2/data_out/do_tri[21]  ( .A(1'b0), .OE(
        n7173), .Y(fft_data_in[21]) );
  TBUFX2TS \fifo_from_fft/fifo_cell2/data_out/do_tri[20]  ( .A(1'b0), .OE(
        n7173), .Y(fft_data_in[20]) );
  TBUFX2TS \fifo_from_fft/fifo_cell2/data_out/do_tri[15]  ( .A(1'b0), .OE(
        n7174), .Y(fft_data_in[15]) );
  TBUFX2TS \fifo_from_fft/fifo_cell2/data_out/do_tri[14]  ( .A(1'b0), .OE(
        n7174), .Y(fft_data_in[14]) );
  TBUFX2TS \fifo_from_fft/fifo_cell2/data_out/do_tri[13]  ( .A(1'b0), .OE(
        n7174), .Y(fft_data_in[13]) );
  TBUFX2TS \fifo_from_fft/fifo_cell2/data_out/do_tri[12]  ( .A(1'b0), .OE(
        n7174), .Y(fft_data_in[12]) );
  TBUFX2TS \fifo_from_fft/fifo_cell2/data_out/do_tri[11]  ( .A(1'b0), .OE(
        n6366), .Y(fft_data_in[11]) );
  TBUFX2TS \fifo_from_fft/fifo_cell2/data_out/do_tri[10]  ( .A(1'b0), .OE(
        n6367), .Y(fft_data_in[10]) );
  TBUFX2TS \fifo_from_fft/fifo_cell2/data_out/do_tri[9]  ( .A(1'b0), .OE(n6366), .Y(fft_data_in[9]) );
  TBUFX2TS \fifo_from_fft/fifo_cell2/data_out/do_tri[8]  ( .A(1'b0), .OE(n6367), .Y(fft_data_in[8]) );
  TBUFX2TS \fifo_from_fft/fifo_cell2/data_out/do_tri[7]  ( .A(1'b0), .OE(n7175), .Y(fft_data_in[7]) );
  TBUFX2TS \fifo_from_fft/fifo_cell2/data_out/do_tri[6]  ( .A(1'b0), .OE(n7175), .Y(fft_data_in[6]) );
  TBUFX2TS \fifo_from_fft/fifo_cell2/data_out/do_tri[5]  ( .A(1'b0), .OE(n7175), .Y(fft_data_in[5]) );
  TBUFX2TS \fifo_from_fft/fifo_cell2/data_out/do_tri[4]  ( .A(1'b0), .OE(n7175), .Y(fft_data_in[4]) );
  TBUFX2TS \fifo_from_fft/fifo_cell2/data_out/do_tri[3]  ( .A(1'b0), .OE(n6175), .Y(fft_data_in[3]) );
  TBUFX2TS \fifo_from_fft/fifo_cell2/data_out/do_tri[2]  ( .A(1'b0), .OE(n1737), .Y(fft_data_in[2]) );
  TBUFX2TS \fifo_from_fft/fifo_cell2/data_out/do_tri[1]  ( .A(1'b0), .OE(n6382), .Y(fft_data_in[1]) );
  TBUFX2TS \fifo_from_fft/fifo_cell1/data_out/do_tri[22]  ( .A(1'b0), .OE(
        n7176), .Y(fft_data_in[22]) );
  TBUFX2TS \fifo_from_fft/fifo_cell1/data_out/do_tri[21]  ( .A(1'b0), .OE(
        n7176), .Y(fft_data_in[21]) );
  TBUFX2TS \fifo_from_fft/fifo_cell1/data_out/do_tri[20]  ( .A(1'b0), .OE(
        n7176), .Y(fft_data_in[20]) );
  TBUFX2TS \fifo_from_fft/fifo_cell1/data_out/do_tri[15]  ( .A(1'b0), .OE(
        n7177), .Y(fft_data_in[15]) );
  TBUFX2TS \fifo_from_fft/fifo_cell1/data_out/do_tri[14]  ( .A(1'b0), .OE(
        n7177), .Y(fft_data_in[14]) );
  TBUFX2TS \fifo_from_fft/fifo_cell1/data_out/do_tri[13]  ( .A(1'b0), .OE(
        n7177), .Y(fft_data_in[13]) );
  TBUFX2TS \fifo_from_fft/fifo_cell1/data_out/do_tri[12]  ( .A(1'b0), .OE(
        n7177), .Y(fft_data_in[12]) );
  TBUFX2TS \fifo_from_fft/fifo_cell1/data_out/do_tri[11]  ( .A(1'b0), .OE(
        n6375), .Y(fft_data_in[11]) );
  TBUFX2TS \fifo_from_fft/fifo_cell1/data_out/do_tri[10]  ( .A(1'b0), .OE(
        n6376), .Y(fft_data_in[10]) );
  TBUFX2TS \fifo_from_fft/fifo_cell1/data_out/do_tri[9]  ( .A(1'b0), .OE(n6375), .Y(fft_data_in[9]) );
  TBUFX2TS \fifo_from_fft/fifo_cell1/data_out/do_tri[8]  ( .A(1'b0), .OE(n6376), .Y(fft_data_in[8]) );
  TBUFX2TS \fifo_from_fft/fifo_cell1/data_out/do_tri[7]  ( .A(1'b0), .OE(n7178), .Y(fft_data_in[7]) );
  TBUFX2TS \fifo_from_fft/fifo_cell1/data_out/do_tri[6]  ( .A(1'b0), .OE(n7178), .Y(fft_data_in[6]) );
  TBUFX2TS \fifo_from_fft/fifo_cell1/data_out/do_tri[5]  ( .A(1'b0), .OE(n7178), .Y(fft_data_in[5]) );
  TBUFX2TS \fifo_from_fft/fifo_cell1/data_out/do_tri[4]  ( .A(1'b0), .OE(n7178), .Y(fft_data_in[4]) );
  TBUFX2TS \fifo_from_fft/fifo_cell1/data_out/do_tri[3]  ( .A(1'b0), .OE(n6174), .Y(fft_data_in[3]) );
  TBUFX2TS \fifo_from_fft/fifo_cell1/data_out/do_tri[2]  ( .A(1'b0), .OE(n1673), .Y(fft_data_in[2]) );
  TBUFX2TS \fifo_from_fft/fifo_cell1/data_out/do_tri[1]  ( .A(1'b0), .OE(n6385), .Y(fft_data_in[1]) );
  TBUFX2TS \fifo_from_fir/fifo_cell15/data_out/do_tri[18]  ( .A(1'b0), .OE(
        n7090), .Y(fir_data_in[18]) );
  TBUFX2TS \fifo_from_fir/fifo_cell15/data_out/do_tri[17]  ( .A(1'b0), .OE(
        n7090), .Y(fir_data_in[17]) );
  TBUFX2TS \fifo_from_fir/fifo_cell15/data_out/do_tri[16]  ( .A(1'b0), .OE(
        n7090), .Y(fir_data_in[16]) );
  TBUFX2TS \fifo_from_fir/fifo_cell15/data_out/do_tri[15]  ( .A(1'b0), .OE(
        n6264), .Y(fir_data_in[15]) );
  TBUFX2TS \fifo_from_fir/fifo_cell15/data_out/do_tri[14]  ( .A(1'b0), .OE(
        n6265), .Y(fir_data_in[14]) );
  TBUFX2TS \fifo_from_fir/fifo_cell15/data_out/do_tri[13]  ( .A(1'b0), .OE(
        n6187), .Y(fir_data_in[13]) );
  TBUFX2TS \fifo_from_fir/fifo_cell15/data_out/do_tri[12]  ( .A(1'b0), .OE(
        n6253), .Y(fir_data_in[12]) );
  TBUFX2TS \fifo_from_fir/fifo_cell15/data_out/do_tri[11]  ( .A(1'b0), .OE(
        n7091), .Y(fir_data_in[11]) );
  TBUFX2TS \fifo_from_fir/fifo_cell15/data_out/do_tri[10]  ( .A(1'b0), .OE(
        n7091), .Y(fir_data_in[10]) );
  TBUFX2TS \fifo_from_fir/fifo_cell15/data_out/do_tri[9]  ( .A(1'b0), .OE(
        n7091), .Y(fir_data_in[9]) );
  TBUFX2TS \fifo_from_fir/fifo_cell15/data_out/do_tri[8]  ( .A(1'b0), .OE(
        n7091), .Y(fir_data_in[8]) );
  TBUFX2TS \fifo_from_fir/fifo_cell15/data_out/do_tri[7]  ( .A(1'b0), .OE(
        n6252), .Y(fir_data_in[7]) );
  TBUFX2TS \fifo_from_fir/fifo_cell15/data_out/do_tri[6]  ( .A(1'b0), .OE(
        n6253), .Y(fir_data_in[6]) );
  TBUFX2TS \fifo_from_fir/fifo_cell15/data_out/do_tri[5]  ( .A(1'b0), .OE(
        n6252), .Y(fir_data_in[5]) );
  TBUFX2TS \fifo_from_fir/fifo_cell15/data_out/do_tri[4]  ( .A(1'b0), .OE(
        n6253), .Y(fir_data_in[4]) );
  TBUFX2TS \fifo_from_fir/fifo_cell15/data_out/do_tri[3]  ( .A(1'b0), .OE(
        n7092), .Y(fir_data_in[3]) );
  TBUFX2TS \fifo_from_fir/fifo_cell15/data_out/do_tri[2]  ( .A(1'b0), .OE(
        n7092), .Y(fir_data_in[2]) );
  TBUFX2TS \fifo_from_fir/fifo_cell15/data_out/do_tri[1]  ( .A(1'b0), .OE(
        n7092), .Y(fir_data_in[1]) );
  TBUFX2TS \fifo_from_fir/fifo_cell14/data_out/do_tri[26]  ( .A(1'b0), .OE(
        n7294), .Y(fir_data_in[26]) );
  TBUFX2TS \fifo_from_fir/fifo_cell14/data_out/do_tri[22]  ( .A(1'b0), .OE(
        n7295), .Y(fir_data_in[22]) );
  TBUFX2TS \fifo_from_fir/fifo_cell14/data_out/do_tri[21]  ( .A(1'b0), .OE(
        n7295), .Y(fir_data_in[21]) );
  TBUFX2TS \fifo_from_fir/fifo_cell14/data_out/do_tri[20]  ( .A(1'b0), .OE(
        n7295), .Y(fir_data_in[20]) );
  TBUFX2TS \fifo_from_fir/fifo_cell13/data_out/do_tri[22]  ( .A(1'b0), .OE(
        n7093), .Y(fir_data_in[22]) );
  TBUFX2TS \fifo_from_fir/fifo_cell13/data_out/do_tri[21]  ( .A(1'b0), .OE(
        n7093), .Y(fir_data_in[21]) );
  TBUFX2TS \fifo_from_fir/fifo_cell13/data_out/do_tri[20]  ( .A(1'b0), .OE(
        n7093), .Y(fir_data_in[20]) );
  TBUFX2TS \fifo_from_fir/fifo_cell13/data_out/do_tri[15]  ( .A(1'b0), .OE(
        n7094), .Y(fir_data_in[15]) );
  TBUFX2TS \fifo_from_fir/fifo_cell13/data_out/do_tri[14]  ( .A(1'b0), .OE(
        n7094), .Y(fir_data_in[14]) );
  TBUFX2TS \fifo_from_fir/fifo_cell13/data_out/do_tri[13]  ( .A(1'b0), .OE(
        n7094), .Y(fir_data_in[13]) );
  TBUFX2TS \fifo_from_fir/fifo_cell13/data_out/do_tri[12]  ( .A(1'b0), .OE(
        n7094), .Y(fir_data_in[12]) );
  TBUFX2TS \fifo_from_fir/fifo_cell13/data_out/do_tri[11]  ( .A(1'b0), .OE(
        n6270), .Y(fir_data_in[11]) );
  TBUFX2TS \fifo_from_fir/fifo_cell13/data_out/do_tri[10]  ( .A(1'b0), .OE(
        n3465), .Y(fir_data_in[10]) );
  TBUFX2TS \fifo_from_fir/fifo_cell13/data_out/do_tri[9]  ( .A(1'b0), .OE(
        n6271), .Y(fir_data_in[9]) );
  TBUFX2TS \fifo_from_fir/fifo_cell13/data_out/do_tri[8]  ( .A(1'b0), .OE(
        n6200), .Y(fir_data_in[8]) );
  TBUFX2TS \fifo_from_fir/fifo_cell13/data_out/do_tri[7]  ( .A(1'b0), .OE(
        n7095), .Y(fir_data_in[7]) );
  TBUFX2TS \fifo_from_fir/fifo_cell13/data_out/do_tri[6]  ( .A(1'b0), .OE(
        n7095), .Y(fir_data_in[6]) );
  TBUFX2TS \fifo_from_fir/fifo_cell13/data_out/do_tri[5]  ( .A(1'b0), .OE(
        n7095), .Y(fir_data_in[5]) );
  TBUFX2TS \fifo_from_fir/fifo_cell13/data_out/do_tri[4]  ( .A(1'b0), .OE(
        n7095), .Y(fir_data_in[4]) );
  TBUFX2TS \fifo_from_fir/fifo_cell13/data_out/do_tri[3]  ( .A(1'b0), .OE(
        n6250), .Y(fir_data_in[3]) );
  TBUFX2TS \fifo_from_fir/fifo_cell13/data_out/do_tri[2]  ( .A(1'b0), .OE(
        n6250), .Y(fir_data_in[2]) );
  TBUFX2TS \fifo_from_fir/fifo_cell13/data_out/do_tri[1]  ( .A(1'b0), .OE(
        n6249), .Y(fir_data_in[1]) );
  TBUFX2TS \fifo_from_fir/fifo_cell12/data_out/do_tri[22]  ( .A(1'b0), .OE(
        n7096), .Y(fir_data_in[22]) );
  TBUFX2TS \fifo_from_fir/fifo_cell12/data_out/do_tri[21]  ( .A(1'b0), .OE(
        n7096), .Y(fir_data_in[21]) );
  TBUFX2TS \fifo_from_fir/fifo_cell12/data_out/do_tri[20]  ( .A(1'b0), .OE(
        n7096), .Y(fir_data_in[20]) );
  TBUFX2TS \fifo_from_fir/fifo_cell12/data_out/do_tri[15]  ( .A(1'b0), .OE(
        n7097), .Y(fir_data_in[15]) );
  TBUFX2TS \fifo_from_fir/fifo_cell12/data_out/do_tri[14]  ( .A(1'b0), .OE(
        n7097), .Y(fir_data_in[14]) );
  TBUFX2TS \fifo_from_fir/fifo_cell12/data_out/do_tri[13]  ( .A(1'b0), .OE(
        n7097), .Y(fir_data_in[13]) );
  TBUFX2TS \fifo_from_fir/fifo_cell12/data_out/do_tri[12]  ( .A(1'b0), .OE(
        n7097), .Y(fir_data_in[12]) );
  TBUFX2TS \fifo_from_fir/fifo_cell12/data_out/do_tri[11]  ( .A(1'b0), .OE(
        n6273), .Y(fir_data_in[11]) );
  TBUFX2TS \fifo_from_fir/fifo_cell12/data_out/do_tri[10]  ( .A(1'b0), .OE(
        n3401), .Y(fir_data_in[10]) );
  TBUFX2TS \fifo_from_fir/fifo_cell12/data_out/do_tri[9]  ( .A(1'b0), .OE(
        n6274), .Y(fir_data_in[9]) );
  TBUFX2TS \fifo_from_fir/fifo_cell12/data_out/do_tri[8]  ( .A(1'b0), .OE(
        n6199), .Y(fir_data_in[8]) );
  TBUFX2TS \fifo_from_fir/fifo_cell12/data_out/do_tri[7]  ( .A(1'b0), .OE(
        n7098), .Y(fir_data_in[7]) );
  TBUFX2TS \fifo_from_fir/fifo_cell12/data_out/do_tri[6]  ( .A(1'b0), .OE(
        n7098), .Y(fir_data_in[6]) );
  TBUFX2TS \fifo_from_fir/fifo_cell12/data_out/do_tri[5]  ( .A(1'b0), .OE(
        n7098), .Y(fir_data_in[5]) );
  TBUFX2TS \fifo_from_fir/fifo_cell12/data_out/do_tri[4]  ( .A(1'b0), .OE(
        n7098), .Y(fir_data_in[4]) );
  TBUFX2TS \fifo_from_fir/fifo_cell12/data_out/do_tri[3]  ( .A(1'b0), .OE(
        n6244), .Y(fir_data_in[3]) );
  TBUFX2TS \fifo_from_fir/fifo_cell12/data_out/do_tri[2]  ( .A(1'b0), .OE(
        n6244), .Y(fir_data_in[2]) );
  TBUFX2TS \fifo_from_fir/fifo_cell12/data_out/do_tri[1]  ( .A(1'b0), .OE(
        n6243), .Y(fir_data_in[1]) );
  TBUFX2TS \fifo_from_fir/fifo_cell11/data_out/do_tri[22]  ( .A(1'b0), .OE(
        n7099), .Y(fir_data_in[22]) );
  TBUFX2TS \fifo_from_fir/fifo_cell11/data_out/do_tri[21]  ( .A(1'b0), .OE(
        n7099), .Y(fir_data_in[21]) );
  TBUFX2TS \fifo_from_fir/fifo_cell11/data_out/do_tri[20]  ( .A(1'b0), .OE(
        n7099), .Y(fir_data_in[20]) );
  TBUFX2TS \fifo_from_fir/fifo_cell11/data_out/do_tri[15]  ( .A(1'b0), .OE(
        n7100), .Y(fir_data_in[15]) );
  TBUFX2TS \fifo_from_fir/fifo_cell11/data_out/do_tri[14]  ( .A(1'b0), .OE(
        n7100), .Y(fir_data_in[14]) );
  TBUFX2TS \fifo_from_fir/fifo_cell11/data_out/do_tri[13]  ( .A(1'b0), .OE(
        n7100), .Y(fir_data_in[13]) );
  TBUFX2TS \fifo_from_fir/fifo_cell11/data_out/do_tri[12]  ( .A(1'b0), .OE(
        n7100), .Y(fir_data_in[12]) );
  TBUFX2TS \fifo_from_fir/fifo_cell11/data_out/do_tri[11]  ( .A(1'b0), .OE(
        n6279), .Y(fir_data_in[11]) );
  TBUFX2TS \fifo_from_fir/fifo_cell11/data_out/do_tri[10]  ( .A(1'b0), .OE(
        n3337), .Y(fir_data_in[10]) );
  TBUFX2TS \fifo_from_fir/fifo_cell11/data_out/do_tri[9]  ( .A(1'b0), .OE(
        n6280), .Y(fir_data_in[9]) );
  TBUFX2TS \fifo_from_fir/fifo_cell11/data_out/do_tri[8]  ( .A(1'b0), .OE(
        n6198), .Y(fir_data_in[8]) );
  TBUFX2TS \fifo_from_fir/fifo_cell11/data_out/do_tri[7]  ( .A(1'b0), .OE(
        n7101), .Y(fir_data_in[7]) );
  TBUFX2TS \fifo_from_fir/fifo_cell11/data_out/do_tri[6]  ( .A(1'b0), .OE(
        n7101), .Y(fir_data_in[6]) );
  TBUFX2TS \fifo_from_fir/fifo_cell11/data_out/do_tri[5]  ( .A(1'b0), .OE(
        n7101), .Y(fir_data_in[5]) );
  TBUFX2TS \fifo_from_fir/fifo_cell11/data_out/do_tri[4]  ( .A(1'b0), .OE(
        n7101), .Y(fir_data_in[4]) );
  TBUFX2TS \fifo_from_fir/fifo_cell11/data_out/do_tri[3]  ( .A(1'b0), .OE(
        n6238), .Y(fir_data_in[3]) );
  TBUFX2TS \fifo_from_fir/fifo_cell11/data_out/do_tri[2]  ( .A(1'b0), .OE(
        n6238), .Y(fir_data_in[2]) );
  TBUFX2TS \fifo_from_fir/fifo_cell11/data_out/do_tri[1]  ( .A(1'b0), .OE(
        n6237), .Y(fir_data_in[1]) );
  TBUFX2TS \fifo_from_fir/fifo_cell10/data_out/do_tri[22]  ( .A(1'b0), .OE(
        n7102), .Y(fir_data_in[22]) );
  TBUFX2TS \fifo_from_fir/fifo_cell10/data_out/do_tri[21]  ( .A(1'b0), .OE(
        n7102), .Y(fir_data_in[21]) );
  TBUFX2TS \fifo_from_fir/fifo_cell10/data_out/do_tri[20]  ( .A(1'b0), .OE(
        n7102), .Y(fir_data_in[20]) );
  TBUFX2TS \fifo_from_fir/fifo_cell10/data_out/do_tri[15]  ( .A(1'b0), .OE(
        n7103), .Y(fir_data_in[15]) );
  TBUFX2TS \fifo_from_fir/fifo_cell10/data_out/do_tri[14]  ( .A(1'b0), .OE(
        n7103), .Y(fir_data_in[14]) );
  TBUFX2TS \fifo_from_fir/fifo_cell10/data_out/do_tri[13]  ( .A(1'b0), .OE(
        n7103), .Y(fir_data_in[13]) );
  TBUFX2TS \fifo_from_fir/fifo_cell10/data_out/do_tri[12]  ( .A(1'b0), .OE(
        n7103), .Y(fir_data_in[12]) );
  TBUFX2TS \fifo_from_fir/fifo_cell10/data_out/do_tri[11]  ( .A(1'b0), .OE(
        n6282), .Y(fir_data_in[11]) );
  TBUFX2TS \fifo_from_fir/fifo_cell10/data_out/do_tri[10]  ( .A(1'b0), .OE(
        n3273), .Y(fir_data_in[10]) );
  TBUFX2TS \fifo_from_fir/fifo_cell10/data_out/do_tri[9]  ( .A(1'b0), .OE(
        n6283), .Y(fir_data_in[9]) );
  TBUFX2TS \fifo_from_fir/fifo_cell10/data_out/do_tri[8]  ( .A(1'b0), .OE(
        n6197), .Y(fir_data_in[8]) );
  TBUFX2TS \fifo_from_fir/fifo_cell10/data_out/do_tri[7]  ( .A(1'b0), .OE(
        n7104), .Y(fir_data_in[7]) );
  TBUFX2TS \fifo_from_fir/fifo_cell10/data_out/do_tri[6]  ( .A(1'b0), .OE(
        n7104), .Y(fir_data_in[6]) );
  TBUFX2TS \fifo_from_fir/fifo_cell10/data_out/do_tri[5]  ( .A(1'b0), .OE(
        n7104), .Y(fir_data_in[5]) );
  TBUFX2TS \fifo_from_fir/fifo_cell10/data_out/do_tri[4]  ( .A(1'b0), .OE(
        n7104), .Y(fir_data_in[4]) );
  TBUFX2TS \fifo_from_fir/fifo_cell10/data_out/do_tri[3]  ( .A(1'b0), .OE(
        n6232), .Y(fir_data_in[3]) );
  TBUFX2TS \fifo_from_fir/fifo_cell10/data_out/do_tri[2]  ( .A(1'b0), .OE(
        n6232), .Y(fir_data_in[2]) );
  TBUFX2TS \fifo_from_fir/fifo_cell10/data_out/do_tri[1]  ( .A(1'b0), .OE(
        n6231), .Y(fir_data_in[1]) );
  TBUFX2TS \fifo_from_fir/fifo_cell9/data_out/do_tri[22]  ( .A(1'b0), .OE(
        n7105), .Y(fir_data_in[22]) );
  TBUFX2TS \fifo_from_fir/fifo_cell9/data_out/do_tri[21]  ( .A(1'b0), .OE(
        n7105), .Y(fir_data_in[21]) );
  TBUFX2TS \fifo_from_fir/fifo_cell9/data_out/do_tri[20]  ( .A(1'b0), .OE(
        n7105), .Y(fir_data_in[20]) );
  TBUFX2TS \fifo_from_fir/fifo_cell9/data_out/do_tri[15]  ( .A(1'b0), .OE(
        n7106), .Y(fir_data_in[15]) );
  TBUFX2TS \fifo_from_fir/fifo_cell9/data_out/do_tri[14]  ( .A(1'b0), .OE(
        n7106), .Y(fir_data_in[14]) );
  TBUFX2TS \fifo_from_fir/fifo_cell9/data_out/do_tri[13]  ( .A(1'b0), .OE(
        n7106), .Y(fir_data_in[13]) );
  TBUFX2TS \fifo_from_fir/fifo_cell9/data_out/do_tri[12]  ( .A(1'b0), .OE(
        n7106), .Y(fir_data_in[12]) );
  TBUFX2TS \fifo_from_fir/fifo_cell9/data_out/do_tri[11]  ( .A(1'b0), .OE(
        n6288), .Y(fir_data_in[11]) );
  TBUFX2TS \fifo_from_fir/fifo_cell9/data_out/do_tri[10]  ( .A(1'b0), .OE(
        n3209), .Y(fir_data_in[10]) );
  TBUFX2TS \fifo_from_fir/fifo_cell9/data_out/do_tri[9]  ( .A(1'b0), .OE(n6289), .Y(fir_data_in[9]) );
  TBUFX2TS \fifo_from_fir/fifo_cell9/data_out/do_tri[8]  ( .A(1'b0), .OE(n6196), .Y(fir_data_in[8]) );
  TBUFX2TS \fifo_from_fir/fifo_cell9/data_out/do_tri[7]  ( .A(1'b0), .OE(n7107), .Y(fir_data_in[7]) );
  TBUFX2TS \fifo_from_fir/fifo_cell9/data_out/do_tri[6]  ( .A(1'b0), .OE(n7107), .Y(fir_data_in[6]) );
  TBUFX2TS \fifo_from_fir/fifo_cell9/data_out/do_tri[5]  ( .A(1'b0), .OE(n7107), .Y(fir_data_in[5]) );
  TBUFX2TS \fifo_from_fir/fifo_cell9/data_out/do_tri[4]  ( .A(1'b0), .OE(n7107), .Y(fir_data_in[4]) );
  TBUFX2TS \fifo_from_fir/fifo_cell9/data_out/do_tri[3]  ( .A(1'b0), .OE(n6226), .Y(fir_data_in[3]) );
  TBUFX2TS \fifo_from_fir/fifo_cell9/data_out/do_tri[2]  ( .A(1'b0), .OE(n6226), .Y(fir_data_in[2]) );
  TBUFX2TS \fifo_from_fir/fifo_cell9/data_out/do_tri[1]  ( .A(1'b0), .OE(n6225), .Y(fir_data_in[1]) );
  TBUFX2TS \fifo_from_fir/fifo_cell8/data_out/do_tri[22]  ( .A(1'b0), .OE(
        n7108), .Y(fir_data_in[22]) );
  TBUFX2TS \fifo_from_fir/fifo_cell8/data_out/do_tri[21]  ( .A(1'b0), .OE(
        n7108), .Y(fir_data_in[21]) );
  TBUFX2TS \fifo_from_fir/fifo_cell8/data_out/do_tri[20]  ( .A(1'b0), .OE(
        n7108), .Y(fir_data_in[20]) );
  TBUFX2TS \fifo_from_fir/fifo_cell8/data_out/do_tri[15]  ( .A(1'b0), .OE(
        n7109), .Y(fir_data_in[15]) );
  TBUFX2TS \fifo_from_fir/fifo_cell8/data_out/do_tri[14]  ( .A(1'b0), .OE(
        n7109), .Y(fir_data_in[14]) );
  TBUFX2TS \fifo_from_fir/fifo_cell8/data_out/do_tri[13]  ( .A(1'b0), .OE(
        n7109), .Y(fir_data_in[13]) );
  TBUFX2TS \fifo_from_fir/fifo_cell8/data_out/do_tri[12]  ( .A(1'b0), .OE(
        n7109), .Y(fir_data_in[12]) );
  TBUFX2TS \fifo_from_fir/fifo_cell8/data_out/do_tri[11]  ( .A(1'b0), .OE(
        n6291), .Y(fir_data_in[11]) );
  TBUFX2TS \fifo_from_fir/fifo_cell8/data_out/do_tri[10]  ( .A(1'b0), .OE(
        n3145), .Y(fir_data_in[10]) );
  TBUFX2TS \fifo_from_fir/fifo_cell8/data_out/do_tri[9]  ( .A(1'b0), .OE(n6292), .Y(fir_data_in[9]) );
  TBUFX2TS \fifo_from_fir/fifo_cell8/data_out/do_tri[8]  ( .A(1'b0), .OE(n6195), .Y(fir_data_in[8]) );
  TBUFX2TS \fifo_from_fir/fifo_cell8/data_out/do_tri[7]  ( .A(1'b0), .OE(n7110), .Y(fir_data_in[7]) );
  TBUFX2TS \fifo_from_fir/fifo_cell8/data_out/do_tri[6]  ( .A(1'b0), .OE(n7110), .Y(fir_data_in[6]) );
  TBUFX2TS \fifo_from_fir/fifo_cell8/data_out/do_tri[5]  ( .A(1'b0), .OE(n7110), .Y(fir_data_in[5]) );
  TBUFX2TS \fifo_from_fir/fifo_cell8/data_out/do_tri[4]  ( .A(1'b0), .OE(n7110), .Y(fir_data_in[4]) );
  TBUFX2TS \fifo_from_fir/fifo_cell8/data_out/do_tri[3]  ( .A(1'b0), .OE(n6220), .Y(fir_data_in[3]) );
  TBUFX2TS \fifo_from_fir/fifo_cell8/data_out/do_tri[2]  ( .A(1'b0), .OE(n6220), .Y(fir_data_in[2]) );
  TBUFX2TS \fifo_from_fir/fifo_cell8/data_out/do_tri[1]  ( .A(1'b0), .OE(n6219), .Y(fir_data_in[1]) );
  TBUFX2TS \fifo_from_fir/fifo_cell7/data_out/do_tri[22]  ( .A(1'b0), .OE(
        n7111), .Y(fir_data_in[22]) );
  TBUFX2TS \fifo_from_fir/fifo_cell7/data_out/do_tri[21]  ( .A(1'b0), .OE(
        n7111), .Y(fir_data_in[21]) );
  TBUFX2TS \fifo_from_fir/fifo_cell7/data_out/do_tri[20]  ( .A(1'b0), .OE(
        n7111), .Y(fir_data_in[20]) );
  TBUFX2TS \fifo_from_fir/fifo_cell7/data_out/do_tri[15]  ( .A(1'b0), .OE(
        n7112), .Y(fir_data_in[15]) );
  TBUFX2TS \fifo_from_fir/fifo_cell7/data_out/do_tri[14]  ( .A(1'b0), .OE(
        n7112), .Y(fir_data_in[14]) );
  TBUFX2TS \fifo_from_fir/fifo_cell7/data_out/do_tri[13]  ( .A(1'b0), .OE(
        n7112), .Y(fir_data_in[13]) );
  TBUFX2TS \fifo_from_fir/fifo_cell7/data_out/do_tri[12]  ( .A(1'b0), .OE(
        n7112), .Y(fir_data_in[12]) );
  TBUFX2TS \fifo_from_fir/fifo_cell7/data_out/do_tri[11]  ( .A(1'b0), .OE(
        n6297), .Y(fir_data_in[11]) );
  TBUFX2TS \fifo_from_fir/fifo_cell7/data_out/do_tri[10]  ( .A(1'b0), .OE(
        n3081), .Y(fir_data_in[10]) );
  TBUFX2TS \fifo_from_fir/fifo_cell7/data_out/do_tri[9]  ( .A(1'b0), .OE(n6298), .Y(fir_data_in[9]) );
  TBUFX2TS \fifo_from_fir/fifo_cell7/data_out/do_tri[8]  ( .A(1'b0), .OE(n6194), .Y(fir_data_in[8]) );
  TBUFX2TS \fifo_from_fir/fifo_cell7/data_out/do_tri[7]  ( .A(1'b0), .OE(n7113), .Y(fir_data_in[7]) );
  TBUFX2TS \fifo_from_fir/fifo_cell7/data_out/do_tri[6]  ( .A(1'b0), .OE(n7113), .Y(fir_data_in[6]) );
  TBUFX2TS \fifo_from_fir/fifo_cell7/data_out/do_tri[5]  ( .A(1'b0), .OE(n7113), .Y(fir_data_in[5]) );
  TBUFX2TS \fifo_from_fir/fifo_cell7/data_out/do_tri[4]  ( .A(1'b0), .OE(n7113), .Y(fir_data_in[4]) );
  TBUFX2TS \fifo_from_fir/fifo_cell7/data_out/do_tri[3]  ( .A(1'b0), .OE(n6214), .Y(fir_data_in[3]) );
  TBUFX2TS \fifo_from_fir/fifo_cell7/data_out/do_tri[2]  ( .A(1'b0), .OE(n6214), .Y(fir_data_in[2]) );
  TBUFX2TS \fifo_from_fir/fifo_cell7/data_out/do_tri[1]  ( .A(1'b0), .OE(n6213), .Y(fir_data_in[1]) );
  TBUFX2TS \fifo_from_fir/fifo_cell6/data_out/do_tri[22]  ( .A(1'b0), .OE(
        n7114), .Y(fir_data_in[22]) );
  TBUFX2TS \fifo_from_fir/fifo_cell6/data_out/do_tri[21]  ( .A(1'b0), .OE(
        n7114), .Y(fir_data_in[21]) );
  TBUFX2TS \fifo_from_fir/fifo_cell6/data_out/do_tri[20]  ( .A(1'b0), .OE(
        n7114), .Y(fir_data_in[20]) );
  TBUFX2TS \fifo_from_fir/fifo_cell6/data_out/do_tri[15]  ( .A(1'b0), .OE(
        n7115), .Y(fir_data_in[15]) );
  TBUFX2TS \fifo_from_fir/fifo_cell6/data_out/do_tri[14]  ( .A(1'b0), .OE(
        n7115), .Y(fir_data_in[14]) );
  TBUFX2TS \fifo_from_fir/fifo_cell6/data_out/do_tri[13]  ( .A(1'b0), .OE(
        n7115), .Y(fir_data_in[13]) );
  TBUFX2TS \fifo_from_fir/fifo_cell6/data_out/do_tri[12]  ( .A(1'b0), .OE(
        n7115), .Y(fir_data_in[12]) );
  TBUFX2TS \fifo_from_fir/fifo_cell6/data_out/do_tri[11]  ( .A(1'b0), .OE(
        n6216), .Y(fir_data_in[11]) );
  TBUFX2TS \fifo_from_fir/fifo_cell6/data_out/do_tri[10]  ( .A(1'b0), .OE(
        n6217), .Y(fir_data_in[10]) );
  TBUFX2TS \fifo_from_fir/fifo_cell6/data_out/do_tri[9]  ( .A(1'b0), .OE(n6216), .Y(fir_data_in[9]) );
  TBUFX2TS \fifo_from_fir/fifo_cell6/data_out/do_tri[8]  ( .A(1'b0), .OE(n6217), .Y(fir_data_in[8]) );
  TBUFX2TS \fifo_from_fir/fifo_cell6/data_out/do_tri[7]  ( .A(1'b0), .OE(n7116), .Y(fir_data_in[7]) );
  TBUFX2TS \fifo_from_fir/fifo_cell6/data_out/do_tri[6]  ( .A(1'b0), .OE(n7116), .Y(fir_data_in[6]) );
  TBUFX2TS \fifo_from_fir/fifo_cell6/data_out/do_tri[5]  ( .A(1'b0), .OE(n7116), .Y(fir_data_in[5]) );
  TBUFX2TS \fifo_from_fir/fifo_cell6/data_out/do_tri[4]  ( .A(1'b0), .OE(n7116), .Y(fir_data_in[4]) );
  TBUFX2TS \fifo_from_fir/fifo_cell6/data_out/do_tri[3]  ( .A(1'b0), .OE(n6193), .Y(fir_data_in[3]) );
  TBUFX2TS \fifo_from_fir/fifo_cell6/data_out/do_tri[2]  ( .A(1'b0), .OE(n3017), .Y(fir_data_in[2]) );
  TBUFX2TS \fifo_from_fir/fifo_cell6/data_out/do_tri[1]  ( .A(1'b0), .OE(n6301), .Y(fir_data_in[1]) );
  TBUFX2TS \fifo_from_fir/fifo_cell5/data_out/do_tri[22]  ( .A(1'b0), .OE(
        n7117), .Y(fir_data_in[22]) );
  TBUFX2TS \fifo_from_fir/fifo_cell5/data_out/do_tri[21]  ( .A(1'b0), .OE(
        n7117), .Y(fir_data_in[21]) );
  TBUFX2TS \fifo_from_fir/fifo_cell5/data_out/do_tri[20]  ( .A(1'b0), .OE(
        n7117), .Y(fir_data_in[20]) );
  TBUFX2TS \fifo_from_fir/fifo_cell5/data_out/do_tri[15]  ( .A(1'b0), .OE(
        n7118), .Y(fir_data_in[15]) );
  TBUFX2TS \fifo_from_fir/fifo_cell5/data_out/do_tri[14]  ( .A(1'b0), .OE(
        n7118), .Y(fir_data_in[14]) );
  TBUFX2TS \fifo_from_fir/fifo_cell5/data_out/do_tri[13]  ( .A(1'b0), .OE(
        n7118), .Y(fir_data_in[13]) );
  TBUFX2TS \fifo_from_fir/fifo_cell5/data_out/do_tri[12]  ( .A(1'b0), .OE(
        n7118), .Y(fir_data_in[12]) );
  TBUFX2TS \fifo_from_fir/fifo_cell5/data_out/do_tri[11]  ( .A(1'b0), .OE(
        n6222), .Y(fir_data_in[11]) );
  TBUFX2TS \fifo_from_fir/fifo_cell5/data_out/do_tri[10]  ( .A(1'b0), .OE(
        n6223), .Y(fir_data_in[10]) );
  TBUFX2TS \fifo_from_fir/fifo_cell5/data_out/do_tri[9]  ( .A(1'b0), .OE(n6222), .Y(fir_data_in[9]) );
  TBUFX2TS \fifo_from_fir/fifo_cell5/data_out/do_tri[8]  ( .A(1'b0), .OE(n6223), .Y(fir_data_in[8]) );
  TBUFX2TS \fifo_from_fir/fifo_cell5/data_out/do_tri[7]  ( .A(1'b0), .OE(n7119), .Y(fir_data_in[7]) );
  TBUFX2TS \fifo_from_fir/fifo_cell5/data_out/do_tri[6]  ( .A(1'b0), .OE(n7119), .Y(fir_data_in[6]) );
  TBUFX2TS \fifo_from_fir/fifo_cell5/data_out/do_tri[5]  ( .A(1'b0), .OE(n7119), .Y(fir_data_in[5]) );
  TBUFX2TS \fifo_from_fir/fifo_cell5/data_out/do_tri[4]  ( .A(1'b0), .OE(n7119), .Y(fir_data_in[4]) );
  TBUFX2TS \fifo_from_fir/fifo_cell5/data_out/do_tri[3]  ( .A(1'b0), .OE(n6192), .Y(fir_data_in[3]) );
  TBUFX2TS \fifo_from_fir/fifo_cell5/data_out/do_tri[2]  ( .A(1'b0), .OE(n2953), .Y(fir_data_in[2]) );
  TBUFX2TS \fifo_from_fir/fifo_cell5/data_out/do_tri[1]  ( .A(1'b0), .OE(n6307), .Y(fir_data_in[1]) );
  TBUFX2TS \fifo_from_fir/fifo_cell4/data_out/do_tri[22]  ( .A(1'b0), .OE(
        n7120), .Y(fir_data_in[22]) );
  TBUFX2TS \fifo_from_fir/fifo_cell4/data_out/do_tri[21]  ( .A(1'b0), .OE(
        n7120), .Y(fir_data_in[21]) );
  TBUFX2TS \fifo_from_fir/fifo_cell4/data_out/do_tri[20]  ( .A(1'b0), .OE(
        n7120), .Y(fir_data_in[20]) );
  TBUFX2TS \fifo_from_fir/fifo_cell4/data_out/do_tri[15]  ( .A(1'b0), .OE(
        n7121), .Y(fir_data_in[15]) );
  TBUFX2TS \fifo_from_fir/fifo_cell4/data_out/do_tri[14]  ( .A(1'b0), .OE(
        n7121), .Y(fir_data_in[14]) );
  TBUFX2TS \fifo_from_fir/fifo_cell4/data_out/do_tri[13]  ( .A(1'b0), .OE(
        n7121), .Y(fir_data_in[13]) );
  TBUFX2TS \fifo_from_fir/fifo_cell4/data_out/do_tri[12]  ( .A(1'b0), .OE(
        n7121), .Y(fir_data_in[12]) );
  TBUFX2TS \fifo_from_fir/fifo_cell4/data_out/do_tri[11]  ( .A(1'b0), .OE(
        n6228), .Y(fir_data_in[11]) );
  TBUFX2TS \fifo_from_fir/fifo_cell4/data_out/do_tri[10]  ( .A(1'b0), .OE(
        n6229), .Y(fir_data_in[10]) );
  TBUFX2TS \fifo_from_fir/fifo_cell4/data_out/do_tri[9]  ( .A(1'b0), .OE(n6228), .Y(fir_data_in[9]) );
  TBUFX2TS \fifo_from_fir/fifo_cell4/data_out/do_tri[8]  ( .A(1'b0), .OE(n6229), .Y(fir_data_in[8]) );
  TBUFX2TS \fifo_from_fir/fifo_cell4/data_out/do_tri[7]  ( .A(1'b0), .OE(n7122), .Y(fir_data_in[7]) );
  TBUFX2TS \fifo_from_fir/fifo_cell4/data_out/do_tri[6]  ( .A(1'b0), .OE(n7122), .Y(fir_data_in[6]) );
  TBUFX2TS \fifo_from_fir/fifo_cell4/data_out/do_tri[5]  ( .A(1'b0), .OE(n7122), .Y(fir_data_in[5]) );
  TBUFX2TS \fifo_from_fir/fifo_cell4/data_out/do_tri[4]  ( .A(1'b0), .OE(n7122), .Y(fir_data_in[4]) );
  TBUFX2TS \fifo_from_fir/fifo_cell4/data_out/do_tri[3]  ( .A(1'b0), .OE(n6191), .Y(fir_data_in[3]) );
  TBUFX2TS \fifo_from_fir/fifo_cell4/data_out/do_tri[2]  ( .A(1'b0), .OE(n2889), .Y(fir_data_in[2]) );
  TBUFX2TS \fifo_from_fir/fifo_cell4/data_out/do_tri[1]  ( .A(1'b0), .OE(n6310), .Y(fir_data_in[1]) );
  TBUFX2TS \fifo_from_fir/fifo_cell3/data_out/do_tri[22]  ( .A(1'b0), .OE(
        n7123), .Y(fir_data_in[22]) );
  TBUFX2TS \fifo_from_fir/fifo_cell3/data_out/do_tri[21]  ( .A(1'b0), .OE(
        n7123), .Y(fir_data_in[21]) );
  TBUFX2TS \fifo_from_fir/fifo_cell3/data_out/do_tri[20]  ( .A(1'b0), .OE(
        n7123), .Y(fir_data_in[20]) );
  TBUFX2TS \fifo_from_fir/fifo_cell3/data_out/do_tri[15]  ( .A(1'b0), .OE(
        n7124), .Y(fir_data_in[15]) );
  TBUFX2TS \fifo_from_fir/fifo_cell3/data_out/do_tri[14]  ( .A(1'b0), .OE(
        n7124), .Y(fir_data_in[14]) );
  TBUFX2TS \fifo_from_fir/fifo_cell3/data_out/do_tri[13]  ( .A(1'b0), .OE(
        n7124), .Y(fir_data_in[13]) );
  TBUFX2TS \fifo_from_fir/fifo_cell3/data_out/do_tri[12]  ( .A(1'b0), .OE(
        n7124), .Y(fir_data_in[12]) );
  TBUFX2TS \fifo_from_fir/fifo_cell3/data_out/do_tri[11]  ( .A(1'b0), .OE(
        n6234), .Y(fir_data_in[11]) );
  TBUFX2TS \fifo_from_fir/fifo_cell3/data_out/do_tri[10]  ( .A(1'b0), .OE(
        n6235), .Y(fir_data_in[10]) );
  TBUFX2TS \fifo_from_fir/fifo_cell3/data_out/do_tri[9]  ( .A(1'b0), .OE(n6234), .Y(fir_data_in[9]) );
  TBUFX2TS \fifo_from_fir/fifo_cell3/data_out/do_tri[8]  ( .A(1'b0), .OE(n6235), .Y(fir_data_in[8]) );
  TBUFX2TS \fifo_from_fir/fifo_cell3/data_out/do_tri[7]  ( .A(1'b0), .OE(n7125), .Y(fir_data_in[7]) );
  TBUFX2TS \fifo_from_fir/fifo_cell3/data_out/do_tri[6]  ( .A(1'b0), .OE(n7125), .Y(fir_data_in[6]) );
  TBUFX2TS \fifo_from_fir/fifo_cell3/data_out/do_tri[5]  ( .A(1'b0), .OE(n7125), .Y(fir_data_in[5]) );
  TBUFX2TS \fifo_from_fir/fifo_cell3/data_out/do_tri[4]  ( .A(1'b0), .OE(n7125), .Y(fir_data_in[4]) );
  TBUFX2TS \fifo_from_fir/fifo_cell3/data_out/do_tri[3]  ( .A(1'b0), .OE(n6190), .Y(fir_data_in[3]) );
  TBUFX2TS \fifo_from_fir/fifo_cell3/data_out/do_tri[2]  ( .A(1'b0), .OE(n2825), .Y(fir_data_in[2]) );
  TBUFX2TS \fifo_from_fir/fifo_cell3/data_out/do_tri[1]  ( .A(1'b0), .OE(n6316), .Y(fir_data_in[1]) );
  TBUFX2TS \fifo_from_fir/fifo_cell2/data_out/do_tri[22]  ( .A(1'b0), .OE(
        n7126), .Y(fir_data_in[22]) );
  TBUFX2TS \fifo_from_fir/fifo_cell2/data_out/do_tri[21]  ( .A(1'b0), .OE(
        n7126), .Y(fir_data_in[21]) );
  TBUFX2TS \fifo_from_fir/fifo_cell2/data_out/do_tri[20]  ( .A(1'b0), .OE(
        n7126), .Y(fir_data_in[20]) );
  TBUFX2TS \fifo_from_fir/fifo_cell2/data_out/do_tri[15]  ( .A(1'b0), .OE(
        n7127), .Y(fir_data_in[15]) );
  TBUFX2TS \fifo_from_fir/fifo_cell2/data_out/do_tri[14]  ( .A(1'b0), .OE(
        n7127), .Y(fir_data_in[14]) );
  TBUFX2TS \fifo_from_fir/fifo_cell2/data_out/do_tri[13]  ( .A(1'b0), .OE(
        n7127), .Y(fir_data_in[13]) );
  TBUFX2TS \fifo_from_fir/fifo_cell2/data_out/do_tri[12]  ( .A(1'b0), .OE(
        n7127), .Y(fir_data_in[12]) );
  TBUFX2TS \fifo_from_fir/fifo_cell2/data_out/do_tri[11]  ( .A(1'b0), .OE(
        n6240), .Y(fir_data_in[11]) );
  TBUFX2TS \fifo_from_fir/fifo_cell2/data_out/do_tri[10]  ( .A(1'b0), .OE(
        n6241), .Y(fir_data_in[10]) );
  TBUFX2TS \fifo_from_fir/fifo_cell2/data_out/do_tri[9]  ( .A(1'b0), .OE(n6240), .Y(fir_data_in[9]) );
  TBUFX2TS \fifo_from_fir/fifo_cell2/data_out/do_tri[8]  ( .A(1'b0), .OE(n6241), .Y(fir_data_in[8]) );
  TBUFX2TS \fifo_from_fir/fifo_cell2/data_out/do_tri[7]  ( .A(1'b0), .OE(n7128), .Y(fir_data_in[7]) );
  TBUFX2TS \fifo_from_fir/fifo_cell2/data_out/do_tri[6]  ( .A(1'b0), .OE(n7128), .Y(fir_data_in[6]) );
  TBUFX2TS \fifo_from_fir/fifo_cell2/data_out/do_tri[5]  ( .A(1'b0), .OE(n7128), .Y(fir_data_in[5]) );
  TBUFX2TS \fifo_from_fir/fifo_cell2/data_out/do_tri[4]  ( .A(1'b0), .OE(n7128), .Y(fir_data_in[4]) );
  TBUFX2TS \fifo_from_fir/fifo_cell2/data_out/do_tri[3]  ( .A(1'b0), .OE(n6189), .Y(fir_data_in[3]) );
  TBUFX2TS \fifo_from_fir/fifo_cell2/data_out/do_tri[2]  ( .A(1'b0), .OE(n2761), .Y(fir_data_in[2]) );
  TBUFX2TS \fifo_from_fir/fifo_cell2/data_out/do_tri[1]  ( .A(1'b0), .OE(n6319), .Y(fir_data_in[1]) );
  TBUFX2TS \fifo_from_fir/fifo_cell1/data_out/do_tri[22]  ( .A(1'b0), .OE(
        n7129), .Y(fir_data_in[22]) );
  TBUFX2TS \fifo_from_fir/fifo_cell1/data_out/do_tri[21]  ( .A(1'b0), .OE(
        n7129), .Y(fir_data_in[21]) );
  TBUFX2TS \fifo_from_fir/fifo_cell1/data_out/do_tri[20]  ( .A(1'b0), .OE(
        n7129), .Y(fir_data_in[20]) );
  TBUFX2TS \fifo_from_fir/fifo_cell1/data_out/do_tri[15]  ( .A(1'b0), .OE(
        n7130), .Y(fir_data_in[15]) );
  TBUFX2TS \fifo_from_fir/fifo_cell1/data_out/do_tri[14]  ( .A(1'b0), .OE(
        n7130), .Y(fir_data_in[14]) );
  TBUFX2TS \fifo_from_fir/fifo_cell1/data_out/do_tri[13]  ( .A(1'b0), .OE(
        n7130), .Y(fir_data_in[13]) );
  TBUFX2TS \fifo_from_fir/fifo_cell1/data_out/do_tri[12]  ( .A(1'b0), .OE(
        n7130), .Y(fir_data_in[12]) );
  TBUFX2TS \fifo_from_fir/fifo_cell1/data_out/do_tri[11]  ( .A(1'b0), .OE(
        n6246), .Y(fir_data_in[11]) );
  TBUFX2TS \fifo_from_fir/fifo_cell1/data_out/do_tri[10]  ( .A(1'b0), .OE(
        n6247), .Y(fir_data_in[10]) );
  TBUFX2TS \fifo_from_fir/fifo_cell1/data_out/do_tri[9]  ( .A(1'b0), .OE(n6246), .Y(fir_data_in[9]) );
  TBUFX2TS \fifo_from_fir/fifo_cell1/data_out/do_tri[8]  ( .A(1'b0), .OE(n6247), .Y(fir_data_in[8]) );
  TBUFX2TS \fifo_from_fir/fifo_cell1/data_out/do_tri[7]  ( .A(1'b0), .OE(n7131), .Y(fir_data_in[7]) );
  TBUFX2TS \fifo_from_fir/fifo_cell1/data_out/do_tri[6]  ( .A(1'b0), .OE(n7131), .Y(fir_data_in[6]) );
  TBUFX2TS \fifo_from_fir/fifo_cell1/data_out/do_tri[5]  ( .A(1'b0), .OE(n7131), .Y(fir_data_in[5]) );
  TBUFX2TS \fifo_from_fir/fifo_cell1/data_out/do_tri[4]  ( .A(1'b0), .OE(n7131), .Y(fir_data_in[4]) );
  TBUFX2TS \fifo_from_fir/fifo_cell1/data_out/do_tri[3]  ( .A(1'b0), .OE(n6188), .Y(fir_data_in[3]) );
  TBUFX2TS \fifo_from_fir/fifo_cell1/data_out/do_tri[2]  ( .A(1'b0), .OE(n2697), .Y(fir_data_in[2]) );
  TBUFX2TS \fifo_from_fir/fifo_cell1/data_out/do_tri[1]  ( .A(1'b0), .OE(n6325), .Y(fir_data_in[1]) );
  TBUFX2TS \fifo_from_fft/fifo_cell15/data_out/do_tri[0]  ( .A(1'b0), .OE(
        n7139), .Y(fft_data_in[0]) );
  TBUFX2TS \fifo_from_fft/fifo_cell13/data_out/do_tri[0]  ( .A(1'b0), .OE(
        n6333), .Y(fft_data_in[0]) );
  TBUFX2TS \fifo_from_fft/fifo_cell12/data_out/do_tri[0]  ( .A(1'b0), .OE(
        n6336), .Y(fft_data_in[0]) );
  TBUFX2TS \fifo_from_fft/fifo_cell11/data_out/do_tri[0]  ( .A(1'b0), .OE(
        n6342), .Y(fft_data_in[0]) );
  TBUFX2TS \fifo_from_fft/fifo_cell10/data_out/do_tri[0]  ( .A(1'b0), .OE(
        n6345), .Y(fft_data_in[0]) );
  TBUFX2TS \fifo_from_fft/fifo_cell9/data_out/do_tri[0]  ( .A(1'b0), .OE(n6351), .Y(fft_data_in[0]) );
  TBUFX2TS \fifo_from_fft/fifo_cell8/data_out/do_tri[0]  ( .A(1'b0), .OE(n6354), .Y(fft_data_in[0]) );
  TBUFX2TS \fifo_from_fft/fifo_cell7/data_out/do_tri[0]  ( .A(1'b0), .OE(n6360), .Y(fft_data_in[0]) );
  TBUFX2TS \fifo_from_fft/fifo_cell6/data_out/do_tri[0]  ( .A(1'b0), .OE(n6363), .Y(fft_data_in[0]) );
  TBUFX2TS \fifo_from_fft/fifo_cell5/data_out/do_tri[0]  ( .A(1'b0), .OE(n6369), .Y(fft_data_in[0]) );
  TBUFX2TS \fifo_from_fft/fifo_cell4/data_out/do_tri[0]  ( .A(1'b0), .OE(n6372), .Y(fft_data_in[0]) );
  TBUFX2TS \fifo_from_fft/fifo_cell3/data_out/do_tri[0]  ( .A(1'b0), .OE(n6378), .Y(fft_data_in[0]) );
  TBUFX2TS \fifo_from_fft/fifo_cell2/data_out/do_tri[0]  ( .A(1'b0), .OE(n6381), .Y(fft_data_in[0]) );
  TBUFX2TS \fifo_from_fft/fifo_cell1/data_out/do_tri[0]  ( .A(1'b0), .OE(n6384), .Y(fft_data_in[0]) );
  TBUFX2TS \fifo_from_fft/fifo_cell14/data_out/do_tri[27]  ( .A(1'b0), .OE(
        n7304), .Y(fft_data_in[27]) );
  TBUFX2TS \fifo_from_fft/fifo_cell14/data_out/do_tri[23]  ( .A(1'b0), .OE(
        n7305), .Y(fft_data_in[23]) );
  TBUFX2TS \fifo_from_fft/fifo_cell13/data_out/do_tri[23]  ( .A(1'b0), .OE(
        n7140), .Y(fft_data_in[23]) );
  TBUFX2TS \fifo_from_fft/fifo_cell12/data_out/do_tri[23]  ( .A(1'b0), .OE(
        n7143), .Y(fft_data_in[23]) );
  TBUFX2TS \fifo_from_fft/fifo_cell11/data_out/do_tri[23]  ( .A(1'b0), .OE(
        n7146), .Y(fft_data_in[23]) );
  TBUFX2TS \fifo_from_fft/fifo_cell10/data_out/do_tri[23]  ( .A(1'b0), .OE(
        n7149), .Y(fft_data_in[23]) );
  TBUFX2TS \fifo_from_fft/fifo_cell9/data_out/do_tri[23]  ( .A(1'b0), .OE(
        n7152), .Y(fft_data_in[23]) );
  TBUFX2TS \fifo_from_fft/fifo_cell8/data_out/do_tri[23]  ( .A(1'b0), .OE(
        n7155), .Y(fft_data_in[23]) );
  TBUFX2TS \fifo_from_fft/fifo_cell7/data_out/do_tri[23]  ( .A(1'b0), .OE(
        n7158), .Y(fft_data_in[23]) );
  TBUFX2TS \fifo_from_fft/fifo_cell6/data_out/do_tri[23]  ( .A(1'b0), .OE(
        n7161), .Y(fft_data_in[23]) );
  TBUFX2TS \fifo_from_fft/fifo_cell5/data_out/do_tri[23]  ( .A(1'b0), .OE(
        n7164), .Y(fft_data_in[23]) );
  TBUFX2TS \fifo_from_fft/fifo_cell4/data_out/do_tri[23]  ( .A(1'b0), .OE(
        n7167), .Y(fft_data_in[23]) );
  TBUFX2TS \fifo_from_fft/fifo_cell3/data_out/do_tri[23]  ( .A(1'b0), .OE(
        n7170), .Y(fft_data_in[23]) );
  TBUFX2TS \fifo_from_fft/fifo_cell2/data_out/do_tri[23]  ( .A(1'b0), .OE(
        n7173), .Y(fft_data_in[23]) );
  TBUFX2TS \fifo_from_fft/fifo_cell1/data_out/do_tri[23]  ( .A(1'b0), .OE(
        n7176), .Y(fft_data_in[23]) );
  TBUFX2TS \fifo_from_fir/fifo_cell14/data_out/do_tri[27]  ( .A(1'b0), .OE(
        n7294), .Y(fir_data_in[27]) );
  TBUFX2TS \fifo_from_fir/fifo_cell14/data_out/do_tri[23]  ( .A(1'b0), .OE(
        n7295), .Y(fir_data_in[23]) );
  TBUFX2TS \fifo_from_fir/fifo_cell13/data_out/do_tri[23]  ( .A(1'b0), .OE(
        n7093), .Y(fir_data_in[23]) );
  TBUFX2TS \fifo_from_fir/fifo_cell12/data_out/do_tri[23]  ( .A(1'b0), .OE(
        n7096), .Y(fir_data_in[23]) );
  TBUFX2TS \fifo_from_fir/fifo_cell11/data_out/do_tri[23]  ( .A(1'b0), .OE(
        n7099), .Y(fir_data_in[23]) );
  TBUFX2TS \fifo_from_fir/fifo_cell10/data_out/do_tri[23]  ( .A(1'b0), .OE(
        n7102), .Y(fir_data_in[23]) );
  TBUFX2TS \fifo_from_fir/fifo_cell9/data_out/do_tri[23]  ( .A(1'b0), .OE(
        n7105), .Y(fir_data_in[23]) );
  TBUFX2TS \fifo_from_fir/fifo_cell8/data_out/do_tri[23]  ( .A(1'b0), .OE(
        n7108), .Y(fir_data_in[23]) );
  TBUFX2TS \fifo_from_fir/fifo_cell7/data_out/do_tri[23]  ( .A(1'b0), .OE(
        n7111), .Y(fir_data_in[23]) );
  TBUFX2TS \fifo_from_fir/fifo_cell6/data_out/do_tri[23]  ( .A(1'b0), .OE(
        n7114), .Y(fir_data_in[23]) );
  TBUFX2TS \fifo_from_fir/fifo_cell5/data_out/do_tri[23]  ( .A(1'b0), .OE(
        n7117), .Y(fir_data_in[23]) );
  TBUFX2TS \fifo_from_fir/fifo_cell4/data_out/do_tri[23]  ( .A(1'b0), .OE(
        n7120), .Y(fir_data_in[23]) );
  TBUFX2TS \fifo_from_fir/fifo_cell3/data_out/do_tri[23]  ( .A(1'b0), .OE(
        n7123), .Y(fir_data_in[23]) );
  TBUFX2TS \fifo_from_fir/fifo_cell2/data_out/do_tri[23]  ( .A(1'b0), .OE(
        n7126), .Y(fir_data_in[23]) );
  TBUFX2TS \fifo_from_fir/fifo_cell1/data_out/do_tri[23]  ( .A(1'b0), .OE(
        n7129), .Y(fir_data_in[23]) );
  TBUFX2TS \fifo_from_fft/fifo_cell15/data_out/do_tri[19]  ( .A(1'b0), .OE(
        n7137), .Y(fft_data_in[19]) );
  TBUFX2TS \fifo_from_fft/fifo_cell14/data_out/do_tri[31]  ( .A(1'b0), .OE(
        n7311), .Y(fft_data_in[31]) );
  TBUFX2TS \fifo_from_fft/fifo_cell14/data_out/do_tri[25]  ( .A(1'b0), .OE(
        n7304), .Y(fft_data_in[25]) );
  TBUFX2TS \fifo_from_fft/fifo_cell14/data_out/do_tri[24]  ( .A(1'b0), .OE(
        n7304), .Y(fft_data_in[24]) );
  TBUFX2TS \fifo_from_fir/fifo_cell15/data_out/do_tri[19]  ( .A(1'b0), .OE(
        n7090), .Y(fir_data_in[19]) );
  TBUFX2TS \fifo_from_fir/fifo_cell14/data_out/do_tri[31]  ( .A(1'b0), .OE(
        n7301), .Y(fir_data_in[31]) );
  TBUFX2TS \fifo_from_fir/fifo_cell14/data_out/do_tri[25]  ( .A(1'b0), .OE(
        n7294), .Y(fir_data_in[25]) );
  TBUFX2TS \fifo_from_fir/fifo_cell14/data_out/do_tri[24]  ( .A(1'b0), .OE(
        n7294), .Y(fir_data_in[24]) );
  TBUFX2TS \fifo_from_fir/fifo_cell15/data_out/do_tri[0]  ( .A(1'b0), .OE(
        n7092), .Y(fir_data_in[0]) );
  DFFQX1TS \router/data_cntl/ram_write_reg  ( .D(n5600), .CK(clk), .Q(
        \router/ram_write_enable_reg ) );
  TBUFX2TS \router/data_cntl/data_bus_tri[27]  ( .A(
        \router/data_cntl/data_in[27] ), .OE(n7186), .Y(data_bus[27]) );
  TBUFX2TS \router/data_cntl/data_bus_tri[26]  ( .A(
        \router/data_cntl/data_in[26] ), .OE(n7186), .Y(data_bus[26]) );
  TBUFX2TS \router/data_cntl/data_bus_tri[25]  ( .A(
        \router/data_cntl/data_in[25] ), .OE(n7186), .Y(data_bus[25]) );
  TBUFX2TS \router/data_cntl/data_bus_tri[24]  ( .A(
        \router/data_cntl/data_in[24] ), .OE(n7186), .Y(data_bus[24]) );
  TBUFX2TS \router/data_cntl/data_bus_tri[23]  ( .A(
        \router/data_cntl/data_in[23] ), .OE(n7184), .Y(data_bus[23]) );
  TBUFX2TS \router/data_cntl/data_bus_tri[22]  ( .A(
        \router/data_cntl/data_in[22] ), .OE(n7184), .Y(data_bus[22]) );
  TBUFX2TS \router/data_cntl/data_bus_tri[19]  ( .A(
        \router/data_cntl/data_in[19] ), .OE(n7187), .Y(data_bus[19]) );
  TBUFX2TS \router/data_cntl/data_bus_tri[18]  ( .A(
        \router/data_cntl/data_in[18] ), .OE(n7187), .Y(data_bus[18]) );
  TBUFX2TS \router/data_cntl/data_bus_tri[17]  ( .A(
        \router/data_cntl/data_in[17] ), .OE(n7187), .Y(data_bus[17]) );
  TBUFX2TS \router/data_cntl/data_bus_tri[16]  ( .A(
        \router/data_cntl/data_in[16] ), .OE(n7187), .Y(data_bus[16]) );
  TBUFX2TS \router/data_cntl/data_bus_tri[15]  ( .A(
        \router/data_cntl/data_in[15] ), .OE(n7188), .Y(data_bus[15]) );
  TBUFX2TS \router/data_cntl/data_bus_tri[14]  ( .A(
        \router/data_cntl/data_in[14] ), .OE(n7188), .Y(data_bus[14]) );
  TBUFX2TS \router/data_cntl/data_bus_tri[13]  ( .A(
        \router/data_cntl/data_in[13] ), .OE(n7188), .Y(data_bus[13]) );
  TBUFX2TS \router/data_cntl/data_bus_tri[12]  ( .A(
        \router/data_cntl/data_in[12] ), .OE(n7188), .Y(data_bus[12]) );
  TBUFX2TS \router/data_cntl/data_bus_tri[11]  ( .A(
        \router/data_cntl/data_in[11] ), .OE(n7189), .Y(data_bus[11]) );
  TBUFX2TS \router/data_cntl/data_bus_tri[10]  ( .A(
        \router/data_cntl/data_in[10] ), .OE(n7189), .Y(data_bus[10]) );
  TBUFX2TS \router/data_cntl/data_bus_tri[9]  ( .A(
        \router/data_cntl/data_in[9] ), .OE(n7189), .Y(data_bus[9]) );
  TBUFX2TS \router/data_cntl/data_bus_tri[8]  ( .A(
        \router/data_cntl/data_in[8] ), .OE(n7189), .Y(data_bus[8]) );
  TBUFX2TS \router/data_cntl/data_bus_tri[7]  ( .A(
        \router/data_cntl/data_in[7] ), .OE(n7190), .Y(data_bus[7]) );
  TBUFX2TS \router/data_cntl/data_bus_tri[6]  ( .A(
        \router/data_cntl/data_in[6] ), .OE(n7190), .Y(data_bus[6]) );
  TBUFX2TS \router/data_cntl/data_bus_tri[5]  ( .A(
        \router/data_cntl/data_in[5] ), .OE(n7190), .Y(data_bus[5]) );
  TBUFX2TS \router/data_cntl/data_bus_tri[4]  ( .A(
        \router/data_cntl/data_in[4] ), .OE(n7190), .Y(data_bus[4]) );
  TBUFX2TS \router/data_cntl/data_bus_tri[3]  ( .A(
        \router/data_cntl/data_in[3] ), .OE(n7191), .Y(data_bus[3]) );
  TBUFX2TS \router/data_cntl/data_bus_tri[2]  ( .A(
        \router/data_cntl/data_in[2] ), .OE(n7191), .Y(data_bus[2]) );
  TBUFX2TS \router/data_cntl/data_bus_tri[1]  ( .A(
        \router/data_cntl/data_in[1] ), .OE(n7191), .Y(data_bus[1]) );
  TBUFX2TS \router/data_cntl/data_bus_tri[0]  ( .A(
        \router/data_cntl/data_in[0] ), .OE(n7191), .Y(data_bus[0]) );
  TBUFX2TS \router/data_cntl/data_bus_tri[31]  ( .A(
        \router/data_cntl/data_in[31] ), .OE(n7193), .Y(data_bus[31]) );
  TBUFX2TS \router/addr_calc/addr_tri[19]  ( .A(n6132), .OE(n7195), .Y(
        addr[19]) );
  TBUFX2TS \router/addr_calc/addr_tri[18]  ( .A(
        \router/addr_calc/fft_read_addr[18] ), .OE(n7195), .Y(addr[18]) );
  TBUFX2TS \router/addr_calc/addr_tri[17]  ( .A(n6088), .OE(n7195), .Y(
        addr[17]) );
  TBUFX2TS \router/addr_calc/addr_tri[16]  ( .A(n6136), .OE(n7195), .Y(
        addr[16]) );
  TBUFX2TS \router/addr_calc/addr_tri[15]  ( .A(n6087), .OE(n7196), .Y(
        addr[15]) );
  TBUFX2TS \router/addr_calc/addr_tri[14]  ( .A(
        \router/addr_calc/fft_read_addr[14] ), .OE(n7196), .Y(addr[14]) );
  TBUFX2TS \router/addr_calc/addr_tri[13]  ( .A(n6059), .OE(n7196), .Y(
        addr[13]) );
  TBUFX2TS \router/addr_calc/addr_tri[12]  ( .A(n6060), .OE(n7196), .Y(
        addr[12]) );
  TBUFX2TS \router/addr_calc/addr_tri[11]  ( .A(n6120), .OE(n7197), .Y(
        addr[11]) );
  TBUFX2TS \router/addr_calc/addr_tri[10]  ( .A(n6077), .OE(n7197), .Y(
        addr[10]) );
  TBUFX2TS \router/addr_calc/addr_tri[9]  ( .A(
        \router/addr_calc/fft_read_addr[9] ), .OE(n7197), .Y(addr[9]) );
  TBUFX2TS \router/addr_calc/addr_tri[8]  ( .A(n6070), .OE(n7197), .Y(addr[8])
         );
  TBUFX2TS \router/addr_calc/addr_tri[7]  ( .A(n6058), .OE(n7198), .Y(addr[7])
         );
  TBUFX2TS \router/addr_calc/addr_tri[6]  ( .A(n6108), .OE(n7198), .Y(addr[6])
         );
  TBUFX2TS \router/addr_calc/addr_tri[5]  ( .A(
        \router/addr_calc/fft_read_addr[5] ), .OE(n7198), .Y(addr[5]) );
  TBUFX2TS \router/addr_calc/addr_tri[4]  ( .A(n6076), .OE(n7198), .Y(addr[4])
         );
  TBUFX2TS \router/addr_calc/addr_tri[3]  ( .A(n6057), .OE(n7199), .Y(addr[3])
         );
  TBUFX2TS \router/addr_calc/addr_tri[2]  ( .A(n6107), .OE(n7199), .Y(addr[2])
         );
  TBUFX2TS \router/addr_calc/addr_tri[1]  ( .A(n6062), .OE(n7199), .Y(addr[1])
         );
  TBUFX2TS \router/addr_calc/addr_tri[0]  ( .A(
        \router/addr_calc/fft_read_addr[0] ), .OE(n7199), .Y(addr[0]) );
  TBUFX2TS \router/addr_calc/addr_tri2[19]  ( .A(
        \router/addr_calc/fft_write_addr[19] ), .OE(n7203), .Y(addr[19]) );
  TBUFX2TS \router/addr_calc/addr_tri2[18]  ( .A(n6135), .OE(n7203), .Y(
        addr[18]) );
  TBUFX2TS \router/addr_calc/addr_tri2[17]  ( .A(n6086), .OE(n7203), .Y(
        addr[17]) );
  TBUFX2TS \router/addr_calc/addr_tri2[16]  ( .A(n6090), .OE(n7203), .Y(
        addr[16]) );
  TBUFX2TS \router/addr_calc/addr_tri2[15]  ( .A(
        \router/addr_calc/fft_write_addr[15] ), .OE(n7204), .Y(addr[15]) );
  TBUFX2TS \router/addr_calc/addr_tri2[14]  ( .A(n6125), .OE(n7204), .Y(
        addr[14]) );
  TBUFX2TS \router/addr_calc/addr_tri2[13]  ( .A(n6100), .OE(n7204), .Y(
        addr[13]) );
  TBUFX2TS \router/addr_calc/addr_tri2[12]  ( .A(n6074), .OE(n7204), .Y(
        addr[12]) );
  TBUFX2TS \router/addr_calc/addr_tri2[11]  ( .A(n6119), .OE(n7205), .Y(
        addr[11]) );
  TBUFX2TS \router/addr_calc/addr_tri2[10]  ( .A(n6114), .OE(n7205), .Y(
        addr[10]) );
  TBUFX2TS \router/addr_calc/addr_tri2[9]  ( .A(
        \router/addr_calc/fft_write_addr[9] ), .OE(n7205), .Y(addr[9]) );
  TBUFX2TS \router/addr_calc/addr_tri2[8]  ( .A(n6069), .OE(n7205), .Y(addr[8]) );
  TBUFX2TS \router/addr_calc/addr_tri2[7]  ( .A(n6056), .OE(n7206), .Y(addr[7]) );
  TBUFX2TS \router/addr_calc/addr_tri2[6]  ( .A(n6106), .OE(n7206), .Y(addr[6]) );
  TBUFX2TS \router/addr_calc/addr_tri2[5]  ( .A(n6113), .OE(n7206), .Y(addr[5]) );
  TBUFX2TS \router/addr_calc/addr_tri2[4]  ( .A(n6075), .OE(n7206), .Y(addr[4]) );
  TBUFX2TS \router/addr_calc/addr_tri2[3]  ( .A(n6055), .OE(n7207), .Y(addr[3]) );
  TBUFX2TS \router/addr_calc/addr_tri2[2]  ( .A(n6105), .OE(n7207), .Y(addr[2]) );
  TBUFX2TS \router/addr_calc/addr_tri2[1]  ( .A(n6052), .OE(n7207), .Y(addr[1]) );
  TBUFX2TS \router/addr_calc/addr_tri2[0]  ( .A(
        \router/addr_calc/fft_write_addr[0] ), .OE(n7207), .Y(addr[0]) );
  TBUFX2TS \router/addr_calc/addr_tri3[19]  ( .A(n6131), .OE(n7211), .Y(
        addr[19]) );
  TBUFX2TS \router/addr_calc/addr_tri3[18]  ( .A(
        \router/addr_calc/fir_read_addr[18] ), .OE(n7211), .Y(addr[18]) );
  TBUFX2TS \router/addr_calc/addr_tri3[17]  ( .A(n6085), .OE(n7211), .Y(
        addr[17]) );
  TBUFX2TS \router/addr_calc/addr_tri3[16]  ( .A(n6134), .OE(n7211), .Y(
        addr[16]) );
  TBUFX2TS \router/addr_calc/addr_tri3[15]  ( .A(n6084), .OE(n7212), .Y(
        addr[15]) );
  TBUFX2TS \router/addr_calc/addr_tri3[14]  ( .A(
        \router/addr_calc/fir_read_addr[14] ), .OE(n7212), .Y(addr[14]) );
  TBUFX2TS \router/addr_calc/addr_tri3[13]  ( .A(n6071), .OE(n7212), .Y(
        addr[13]) );
  TBUFX2TS \router/addr_calc/addr_tri3[12]  ( .A(n6073), .OE(n7212), .Y(
        addr[12]) );
  TBUFX2TS \router/addr_calc/addr_tri3[11]  ( .A(n6118), .OE(n7213), .Y(
        addr[11]) );
  TBUFX2TS \router/addr_calc/addr_tri3[10]  ( .A(n6112), .OE(n7213), .Y(
        addr[10]) );
  TBUFX2TS \router/addr_calc/addr_tri3[9]  ( .A(
        \router/addr_calc/fir_read_addr[9] ), .OE(n7213), .Y(addr[9]) );
  TBUFX2TS \router/addr_calc/addr_tri3[8]  ( .A(n6068), .OE(n7213), .Y(addr[8]) );
  TBUFX2TS \router/addr_calc/addr_tri3[7]  ( .A(n6054), .OE(n7214), .Y(addr[7]) );
  TBUFX2TS \router/addr_calc/addr_tri3[6]  ( .A(n6104), .OE(n7214), .Y(addr[6]) );
  TBUFX2TS \router/addr_calc/addr_tri3[5]  ( .A(
        \router/addr_calc/fir_read_addr[5] ), .OE(n7214), .Y(addr[5]) );
  TBUFX2TS \router/addr_calc/addr_tri3[4]  ( .A(n6111), .OE(n7214), .Y(addr[4]) );
  TBUFX2TS \router/addr_calc/addr_tri3[3]  ( .A(n6067), .OE(n7215), .Y(addr[3]) );
  TBUFX2TS \router/addr_calc/addr_tri3[2]  ( .A(n6103), .OE(n7215), .Y(addr[2]) );
  TBUFX2TS \router/addr_calc/addr_tri3[1]  ( .A(n6061), .OE(n7215), .Y(addr[1]) );
  TBUFX2TS \router/addr_calc/addr_tri3[0]  ( .A(
        \router/addr_calc/fir_read_addr[0] ), .OE(n7215), .Y(addr[0]) );
  TBUFX2TS \router/addr_calc/addr_tri4[19]  ( .A(
        \router/addr_calc/fir_write_addr[19] ), .OE(n7219), .Y(addr[19]) );
  TBUFX2TS \router/addr_calc/addr_tri4[18]  ( .A(n6133), .OE(n7219), .Y(
        addr[18]) );
  TBUFX2TS \router/addr_calc/addr_tri4[17]  ( .A(n6083), .OE(n7219), .Y(
        addr[17]) );
  TBUFX2TS \router/addr_calc/addr_tri4[16]  ( .A(n6089), .OE(n7219), .Y(
        addr[16]) );
  TBUFX2TS \router/addr_calc/addr_tri4[15]  ( .A(
        \router/addr_calc/fir_write_addr[15] ), .OE(n7220), .Y(addr[15]) );
  TBUFX2TS \router/addr_calc/addr_tri4[14]  ( .A(n6124), .OE(n7220), .Y(
        addr[14]) );
  TBUFX2TS \router/addr_calc/addr_tri4[13]  ( .A(n6099), .OE(n7220), .Y(
        addr[13]) );
  TBUFX2TS \router/addr_calc/addr_tri4[12]  ( .A(n6072), .OE(n7220), .Y(
        addr[12]) );
  TBUFX2TS \router/addr_calc/addr_tri4[11]  ( .A(n6117), .OE(n7221), .Y(
        addr[11]) );
  TBUFX2TS \router/addr_calc/addr_tri4[10]  ( .A(n6110), .OE(n7221), .Y(
        addr[10]) );
  TBUFX2TS \router/addr_calc/addr_tri4[9]  ( .A(
        \router/addr_calc/fir_write_addr[9] ), .OE(n7221), .Y(addr[9]) );
  TBUFX2TS \router/addr_calc/addr_tri4[8]  ( .A(n6066), .OE(n7221), .Y(addr[8]) );
  TBUFX2TS \router/addr_calc/addr_tri4[7]  ( .A(n6053), .OE(n7222), .Y(addr[7]) );
  TBUFX2TS \router/addr_calc/addr_tri4[6]  ( .A(n6102), .OE(n7222), .Y(addr[6]) );
  TBUFX2TS \router/addr_calc/addr_tri4[5]  ( .A(
        \router/addr_calc/fir_write_addr[5] ), .OE(n7222), .Y(addr[5]) );
  TBUFX2TS \router/addr_calc/addr_tri4[4]  ( .A(n6109), .OE(n7222), .Y(addr[4]) );
  TBUFX2TS \router/addr_calc/addr_tri4[3]  ( .A(n6065), .OE(n7223), .Y(addr[3]) );
  TBUFX2TS \router/addr_calc/addr_tri4[2]  ( .A(n6101), .OE(n7223), .Y(addr[2]) );
  TBUFX2TS \router/addr_calc/addr_tri4[1]  ( .A(n6051), .OE(n7223), .Y(addr[1]) );
  TBUFX2TS \router/addr_calc/addr_tri4[0]  ( .A(
        \router/addr_calc/fir_write_addr[0] ), .OE(n7223), .Y(addr[0]) );
  TBUFX2TS \router/addr_calc/addr_tri6[19]  ( .A(n6161), .OE(n7227), .Y(
        addr[19]) );
  TBUFX2TS \router/addr_calc/addr_tri6[18]  ( .A(
        \router/addr_calc/iir_write_addr[18] ), .OE(n7227), .Y(addr[18]) );
  TBUFX2TS \router/addr_calc/addr_tri6[17]  ( .A(n6165), .OE(n7227), .Y(
        addr[17]) );
  TBUFX2TS \router/addr_calc/addr_tri6[16]  ( .A(n6164), .OE(n7227), .Y(
        addr[16]) );
  TBUFX2TS \router/addr_calc/addr_tri6[15]  ( .A(n6160), .OE(n7228), .Y(
        addr[15]) );
  TBUFX2TS \router/addr_calc/addr_tri6[14]  ( .A(
        \router/addr_calc/iir_write_addr[14] ), .OE(n7228), .Y(addr[14]) );
  TBUFX2TS \router/addr_calc/addr_tri6[13]  ( .A(n6163), .OE(n7228), .Y(
        addr[13]) );
  TBUFX2TS \router/addr_calc/addr_tri6[12]  ( .A(n6148), .OE(n7228), .Y(
        addr[12]) );
  TBUFX2TS \router/addr_calc/addr_tri6[11]  ( .A(n6082), .OE(n7229), .Y(
        addr[11]) );
  TBUFX2TS \router/addr_calc/addr_tri6[10]  ( .A(n6147), .OE(n7229), .Y(
        addr[10]) );
  TBUFX2TS \router/addr_calc/addr_tri6[9]  ( .A(
        \router/addr_calc/iir_write_addr[9] ), .OE(n7229), .Y(addr[9]) );
  TBUFX2TS \router/addr_calc/addr_tri6[8]  ( .A(n6130), .OE(n7229), .Y(addr[8]) );
  TBUFX2TS \router/addr_calc/addr_tri6[7]  ( .A(n6081), .OE(n7230), .Y(addr[7]) );
  TBUFX2TS \router/addr_calc/addr_tri6[6]  ( .A(n6115), .OE(n7230), .Y(addr[6]) );
  TBUFX2TS \router/addr_calc/addr_tri6[5]  ( .A(
        \router/addr_calc/iir_write_addr[5] ), .OE(n7230), .Y(addr[5]) );
  TBUFX2TS \router/addr_calc/addr_tri6[4]  ( .A(n6157), .OE(n7230), .Y(addr[4]) );
  TBUFX2TS \router/addr_calc/addr_tri6[3]  ( .A(n6152), .OE(n7231), .Y(addr[3]) );
  TBUFX2TS \router/addr_calc/addr_tri6[2]  ( .A(n6116), .OE(n7231), .Y(addr[2]) );
  TBUFX2TS \router/addr_calc/addr_tri6[1]  ( .A(n6146), .OE(n7231), .Y(addr[1]) );
  TBUFX2TS \router/addr_calc/addr_tri6[0]  ( .A(
        \router/addr_calc/iir_write_addr[0] ), .OE(n7231), .Y(addr[0]) );
  TBUFX2TS \router/addr_calc/addr_tri[22]  ( .A(n6633), .OE(n7201), .Y(
        addr[22]) );
  TBUFX2TS \router/addr_calc/addr_tri[21]  ( .A(n6635), .OE(n7201), .Y(
        addr[21]) );
  TBUFX2TS \router/addr_calc/addr_tri[20]  ( .A(n6123), .OE(n7201), .Y(
        addr[20]) );
  TBUFX2TS \router/addr_calc/addr_tri2[22]  ( .A(n6583), .OE(n7209), .Y(
        addr[22]) );
  TBUFX2TS \router/addr_calc/addr_tri2[21]  ( .A(n6585), .OE(n7209), .Y(
        addr[21]) );
  TBUFX2TS \router/addr_calc/addr_tri2[20]  ( .A(n6122), .OE(n7209), .Y(
        addr[20]) );
  TBUFX2TS \router/addr_calc/addr_tri3[22]  ( .A(n6537), .OE(n7217), .Y(
        addr[22]) );
  TBUFX2TS \router/addr_calc/addr_tri3[21]  ( .A(n6539), .OE(n7217), .Y(
        addr[21]) );
  TBUFX2TS \router/addr_calc/addr_tri3[20]  ( .A(n6091), .OE(n7217), .Y(
        addr[20]) );
  TBUFX2TS \router/addr_calc/addr_tri4[22]  ( .A(n6489), .OE(n7225), .Y(
        addr[22]) );
  TBUFX2TS \router/addr_calc/addr_tri4[21]  ( .A(n6491), .OE(n7225), .Y(
        addr[21]) );
  TBUFX2TS \router/addr_calc/addr_tri4[20]  ( .A(n6121), .OE(n7225), .Y(
        addr[20]) );
  TBUFX2TS \router/addr_calc/addr_tri6[22]  ( .A(n6395), .OE(n7233), .Y(
        addr[22]) );
  TBUFX2TS \router/addr_calc/addr_tri6[21]  ( .A(n6162), .OE(n7233), .Y(
        addr[21]) );
  TBUFX2TS \router/addr_calc/addr_tri6[20]  ( .A(n6170), .OE(n7233), .Y(
        addr[20]) );
  TBUFX2TS \router/addr_calc/addr_tri6[30]  ( .A(
        \router/addr_calc/iir_write_calc/count[30] ), .OE(n6205), .Y(addr[30])
         );
  DFFQX1TS \router/pla_top/iir_enable_reg  ( .D(n5945), .CK(clk), .Q(
        iir_enable) );
  DFFQX1TS \router/data_cntl/iir_full_flag_reg  ( .D(n5674), .CK(clk), .Q(
        \router/data_cntl/N168 ) );
  DFFQX1TS \router/data_cntl/fir_full_flag_reg  ( .D(n5770), .CK(clk), .Q(
        \router/data_cntl/fir_full_flag ) );
  DFFQX1TS \router/addr_calc/fir_write_calc/counter/done_reg  ( .D(n5775), 
        .CK(clk), .Q(\router/fir_write_done ) );
  DFFQX1TS \router/data_cntl/iir_get_req_reg  ( .D(n5773), .CK(clk), .Q(
        \router/iir_get_req_reg ) );
  DFFQX1TS \router/data_cntl/fft_get_req_reg  ( .D(n5771), .CK(clk), .Q(
        \router/fft_get_req_reg ) );
  DFFQX1TS \router/data_cntl/fir_get_req_reg  ( .D(n5774), .CK(clk), .Q(
        \router/fir_get_req_reg ) );
  DFFQX1TS \router/addr_calc/fft_write_calc/counter/done_reg  ( .D(n5809), 
        .CK(clk), .Q(\router/fft_write_done ) );
  DFFQX1TS \router/addr_calc/fir_read_calc/counter/done_reg  ( .D(n5720), .CK(
        clk), .Q(\router/fir_read_done ) );
  DFFQX1TS \router/data_cntl/ram_read_reg  ( .D(n5772), .CK(clk), .Q(
        \router/ram_read_enable_reg ) );
  DFFQX1TS \fifo_to_fft/fifo_cell1/controller/f_i_get_reg  ( .D(n5675), .CK(
        clk), .Q(\fifo_to_fft/fifo_cell1/controller/f_i_get ) );
  DFFQX1TS \fifo_to_fft/fifo_cell2/controller/f_i_get_reg  ( .D(n5677), .CK(
        clk), .Q(\fifo_to_fft/fifo_cell2/controller/f_i_get ) );
  DFFQX1TS \fifo_to_fft/fifo_cell3/controller/f_i_get_reg  ( .D(n5688), .CK(
        clk), .Q(\fifo_to_fft/fifo_cell3/controller/f_i_get ) );
  DFFQX1TS \fifo_to_fft/fifo_cell4/controller/f_i_get_reg  ( .D(n5690), .CK(
        clk), .Q(\fifo_to_fft/fifo_cell4/controller/f_i_get ) );
  DFFQX1TS \fifo_to_fft/fifo_cell5/controller/f_i_get_reg  ( .D(n5692), .CK(
        clk), .Q(\fifo_to_fft/fifo_cell5/controller/f_i_get ) );
  DFFQX1TS \fifo_to_fft/fifo_cell6/controller/f_i_get_reg  ( .D(n5694), .CK(
        clk), .Q(\fifo_to_fft/fifo_cell6/controller/f_i_get ) );
  DFFQX1TS \fifo_to_fft/fifo_cell7/controller/f_i_get_reg  ( .D(n5696), .CK(
        clk), .Q(\fifo_to_fft/fifo_cell7/controller/f_i_get ) );
  DFFQX1TS \fifo_to_fft/fifo_cell8/controller/f_i_get_reg  ( .D(n5698), .CK(
        clk), .Q(\fifo_to_fft/fifo_cell8/controller/f_i_get ) );
  DFFQX1TS \fifo_to_fft/fifo_cell9/controller/f_i_get_reg  ( .D(n5700), .CK(
        clk), .Q(\fifo_to_fft/fifo_cell9/controller/f_i_get ) );
  DFFQX1TS \fifo_to_fft/fifo_cell10/controller/f_i_get_reg  ( .D(n5702), .CK(
        clk), .Q(\fifo_to_fft/fifo_cell10/controller/f_i_get ) );
  DFFQX1TS \fifo_to_fft/fifo_cell11/controller/f_i_get_reg  ( .D(n5679), .CK(
        clk), .Q(\fifo_to_fft/fifo_cell11/controller/f_i_get ) );
  DFFQX1TS \fifo_to_fft/fifo_cell12/controller/f_i_get_reg  ( .D(n5681), .CK(
        clk), .Q(\fifo_to_fft/fifo_cell12/controller/f_i_get ) );
  DFFQX1TS \fifo_to_fft/fifo_cell13/controller/f_i_get_reg  ( .D(n5683), .CK(
        clk), .Q(\fifo_to_fft/fifo_cell13/controller/f_i_get ) );
  DFFQX1TS \fifo_to_fft/fifo_cell14/controller/f_i_get_reg  ( .D(n5685), .CK(
        clk), .Q(\fifo_to_fft/fifo_cell14/controller/f_i_get ) );
  DFFQX1TS \fifo_to_fft/fifo_cell0/controller/f_i_get_reg  ( .D(n5670), .CK(
        clk), .Q(\fifo_to_fft/fifo_cell0/controller/f_i_get ) );
  DFFQX1TS \fifo_to_fir/fifo_cell1/controller/f_i_get_reg  ( .D(n5724), .CK(
        clk), .Q(\fifo_to_fir/fifo_cell1/controller/f_i_get ) );
  DFFQX1TS \fifo_to_fir/fifo_cell2/controller/f_i_get_reg  ( .D(n5726), .CK(
        clk), .Q(\fifo_to_fir/fifo_cell2/controller/f_i_get ) );
  DFFQX1TS \fifo_to_fir/fifo_cell3/controller/f_i_get_reg  ( .D(n5737), .CK(
        clk), .Q(\fifo_to_fir/fifo_cell3/controller/f_i_get ) );
  DFFQX1TS \fifo_to_fir/fifo_cell4/controller/f_i_get_reg  ( .D(n5739), .CK(
        clk), .Q(\fifo_to_fir/fifo_cell4/controller/f_i_get ) );
  DFFQX1TS \fifo_to_fir/fifo_cell5/controller/f_i_get_reg  ( .D(n5741), .CK(
        clk), .Q(\fifo_to_fir/fifo_cell5/controller/f_i_get ) );
  DFFQX1TS \fifo_to_fir/fifo_cell6/controller/f_i_get_reg  ( .D(n5743), .CK(
        clk), .Q(\fifo_to_fir/fifo_cell6/controller/f_i_get ) );
  DFFQX1TS \fifo_to_fir/fifo_cell7/controller/f_i_get_reg  ( .D(n5745), .CK(
        clk), .Q(\fifo_to_fir/fifo_cell7/controller/f_i_get ) );
  DFFQX1TS \fifo_to_fir/fifo_cell8/controller/f_i_get_reg  ( .D(n5747), .CK(
        clk), .Q(\fifo_to_fir/fifo_cell8/controller/f_i_get ) );
  DFFQX1TS \fifo_to_fir/fifo_cell9/controller/f_i_get_reg  ( .D(n5749), .CK(
        clk), .Q(\fifo_to_fir/fifo_cell9/controller/f_i_get ) );
  DFFQX1TS \fifo_to_fir/fifo_cell10/controller/f_i_get_reg  ( .D(n5751), .CK(
        clk), .Q(\fifo_to_fir/fifo_cell10/controller/f_i_get ) );
  DFFQX1TS \fifo_to_fir/fifo_cell11/controller/f_i_get_reg  ( .D(n5728), .CK(
        clk), .Q(\fifo_to_fir/fifo_cell11/controller/f_i_get ) );
  DFFQX1TS \fifo_to_fir/fifo_cell12/controller/f_i_get_reg  ( .D(n5730), .CK(
        clk), .Q(\fifo_to_fir/fifo_cell12/controller/f_i_get ) );
  DFFQX1TS \fifo_to_fir/fifo_cell13/controller/f_i_get_reg  ( .D(n5732), .CK(
        clk), .Q(\fifo_to_fir/fifo_cell13/controller/f_i_get ) );
  DFFQX1TS \fifo_to_fir/fifo_cell14/controller/f_i_get_reg  ( .D(n5734), .CK(
        clk), .Q(\fifo_to_fir/fifo_cell14/controller/f_i_get ) );
  DFFQX1TS \fifo_to_fir/fifo_cell0/controller/f_i_get_reg  ( .D(n5668), .CK(
        clk), .Q(\fifo_to_fir/fifo_cell0/controller/f_i_get ) );
  DFFQX1TS \fifo_to_fft/fifo_cell15/controller/f_i_get_reg  ( .D(n5686), .CK(
        clk), .Q(\fifo_to_fft/fifo_cell15/controller/f_i_get ) );
  DFFQX1TS \fifo_to_fir/fifo_cell15/controller/f_i_get_reg  ( .D(n5735), .CK(
        clk), .Q(\fifo_to_fir/fifo_cell15/controller/f_i_get ) );
  DFFQX1TS \fifo_to_fft/fifo_cell0/controller/f_i_put_reg  ( .D(n5703), .CK(
        clk), .Q(\fifo_to_fft/fifo_cell0/controller/f_i_put ) );
  DFFQX1TS \fifo_to_fir/fifo_cell0/controller/f_i_put_reg  ( .D(n5752), .CK(
        clk), .Q(\fifo_to_fir/fifo_cell0/controller/f_i_put ) );
  DFFQX1TS \router/pla_top/fir_enable_reg  ( .D(n5813), .CK(clk), .Q(n7919) );
  DFFQX1TS \fifo_to_fft/fifo_cell14/controller/f_i_put_reg  ( .D(n5684), .CK(
        clk), .Q(\fifo_to_fft/fifo_cell14/controller/f_i_put ) );
  DFFQX1TS \fifo_to_fft/fifo_cell13/controller/f_i_put_reg  ( .D(n5682), .CK(
        clk), .Q(\fifo_to_fft/fifo_cell13/controller/f_i_put ) );
  DFFQX1TS \fifo_to_fft/fifo_cell12/controller/f_i_put_reg  ( .D(n5680), .CK(
        clk), .Q(\fifo_to_fft/fifo_cell12/controller/f_i_put ) );
  DFFQX1TS \fifo_to_fft/fifo_cell11/controller/f_i_put_reg  ( .D(n5678), .CK(
        clk), .Q(\fifo_to_fft/fifo_cell11/controller/f_i_put ) );
  DFFQX1TS \fifo_to_fft/fifo_cell10/controller/f_i_put_reg  ( .D(n5701), .CK(
        clk), .Q(\fifo_to_fft/fifo_cell10/controller/f_i_put ) );
  DFFQX1TS \fifo_to_fft/fifo_cell9/controller/f_i_put_reg  ( .D(n5699), .CK(
        clk), .Q(\fifo_to_fft/fifo_cell9/controller/f_i_put ) );
  DFFQX1TS \fifo_to_fft/fifo_cell8/controller/f_i_put_reg  ( .D(n5697), .CK(
        clk), .Q(\fifo_to_fft/fifo_cell8/controller/f_i_put ) );
  DFFQX1TS \fifo_to_fft/fifo_cell7/controller/f_i_put_reg  ( .D(n5695), .CK(
        clk), .Q(\fifo_to_fft/fifo_cell7/controller/f_i_put ) );
  DFFQX1TS \fifo_to_fft/fifo_cell6/controller/f_i_put_reg  ( .D(n5693), .CK(
        clk), .Q(\fifo_to_fft/fifo_cell6/controller/f_i_put ) );
  DFFQX1TS \fifo_to_fft/fifo_cell5/controller/f_i_put_reg  ( .D(n5691), .CK(
        clk), .Q(\fifo_to_fft/fifo_cell5/controller/f_i_put ) );
  DFFQX1TS \fifo_to_fft/fifo_cell4/controller/f_i_put_reg  ( .D(n5689), .CK(
        clk), .Q(\fifo_to_fft/fifo_cell4/controller/f_i_put ) );
  DFFQX1TS \fifo_to_fft/fifo_cell3/controller/f_i_put_reg  ( .D(n5687), .CK(
        clk), .Q(\fifo_to_fft/fifo_cell3/controller/f_i_put ) );
  DFFQX1TS \fifo_to_fft/fifo_cell2/controller/f_i_put_reg  ( .D(n5676), .CK(
        clk), .Q(\fifo_to_fft/fifo_cell2/controller/f_i_put ) );
  DFFQX1TS \fifo_to_fir/fifo_cell14/controller/f_i_put_reg  ( .D(n5733), .CK(
        clk), .Q(\fifo_to_fir/fifo_cell14/controller/f_i_put ) );
  DFFQX1TS \fifo_to_fir/fifo_cell13/controller/f_i_put_reg  ( .D(n5731), .CK(
        clk), .Q(\fifo_to_fir/fifo_cell13/controller/f_i_put ) );
  DFFQX1TS \fifo_to_fir/fifo_cell12/controller/f_i_put_reg  ( .D(n5729), .CK(
        clk), .Q(\fifo_to_fir/fifo_cell12/controller/f_i_put ) );
  DFFQX1TS \fifo_to_fir/fifo_cell11/controller/f_i_put_reg  ( .D(n5727), .CK(
        clk), .Q(\fifo_to_fir/fifo_cell11/controller/f_i_put ) );
  DFFQX1TS \fifo_to_fir/fifo_cell10/controller/f_i_put_reg  ( .D(n5750), .CK(
        clk), .Q(\fifo_to_fir/fifo_cell10/controller/f_i_put ) );
  DFFQX1TS \fifo_to_fir/fifo_cell9/controller/f_i_put_reg  ( .D(n5748), .CK(
        clk), .Q(\fifo_to_fir/fifo_cell9/controller/f_i_put ) );
  DFFQX1TS \fifo_to_fir/fifo_cell8/controller/f_i_put_reg  ( .D(n5746), .CK(
        clk), .Q(\fifo_to_fir/fifo_cell8/controller/f_i_put ) );
  DFFQX1TS \fifo_to_fir/fifo_cell7/controller/f_i_put_reg  ( .D(n5744), .CK(
        clk), .Q(\fifo_to_fir/fifo_cell7/controller/f_i_put ) );
  DFFQX1TS \fifo_to_fir/fifo_cell6/controller/f_i_put_reg  ( .D(n5742), .CK(
        clk), .Q(\fifo_to_fir/fifo_cell6/controller/f_i_put ) );
  DFFQX1TS \fifo_to_fir/fifo_cell5/controller/f_i_put_reg  ( .D(n5740), .CK(
        clk), .Q(\fifo_to_fir/fifo_cell5/controller/f_i_put ) );
  DFFQX1TS \fifo_to_fir/fifo_cell4/controller/f_i_put_reg  ( .D(n5738), .CK(
        clk), .Q(\fifo_to_fir/fifo_cell4/controller/f_i_put ) );
  DFFQX1TS \fifo_to_fir/fifo_cell3/controller/f_i_put_reg  ( .D(n5736), .CK(
        clk), .Q(\fifo_to_fir/fifo_cell3/controller/f_i_put ) );
  DFFQX1TS \fifo_to_fir/fifo_cell2/controller/f_i_put_reg  ( .D(n5725), .CK(
        clk), .Q(\fifo_to_fir/fifo_cell2/controller/f_i_put ) );
  EDFFXLTS \router/data_cntl/fft_full_flag_reg  ( .D(n6674), .E(n3811), .CK(
        clk), .QN(n4348) );
  DFFQX1TS \router/pla_top/fft_enable_reg  ( .D(n5811), .CK(clk), .Q(n7918) );
  DFFQX1TS \router/pla_top/acc_done_reg  ( .D(n5943), .CK(clk), .Q(acc_done)
         );
  DFFNSRX2TS \mips/mips/c/md/accfullinstruction_reg[31]  ( .D(n5814), .CKN(clk), .SN(1'b1), .RN(1'b1), .Q(\mips/mips/accfullinstruction[31] ) );
  DFFNSRX2TS \mips/mips/c/md/accfullinstruction_reg[30]  ( .D(n5815), .CKN(clk), .SN(1'b1), .RN(1'b1), .Q(\mips/mips/accfullinstruction[30] ) );
  DFFNSRX2TS \mips/mips/c/md/accfullinstruction_reg[29]  ( .D(n5816), .CKN(clk), .SN(1'b1), .RN(1'b1), .Q(\mips/mips/accfullinstruction[29] ) );
  DFFNSRX2TS \mips/mips/c/md/accfullinstruction_reg[28]  ( .D(n5817), .CKN(clk), .SN(1'b1), .RN(1'b1), .Q(\mips/mips/accfullinstruction[28] ) );
  DFFNSRX2TS \mips/mips/c/md/accfullinstruction_reg[27]  ( .D(n5818), .CKN(clk), .SN(1'b1), .RN(1'b1), .Q(\mips/mips/accfullinstruction[27] ) );
  DFFNSRX2TS \mips/mips/c/md/accfullinstruction_reg[26]  ( .D(n5819), .CKN(clk), .SN(1'b1), .RN(1'b1), .Q(\mips/mips/accfullinstruction[26] ) );
  DFFNSRX2TS \mips/mips/c/md/accfullinstruction_reg[0]  ( .D(n5845), .CKN(clk), 
        .SN(1'b1), .RN(1'b1), .Q(\mips/mips/accfullinstruction[0] ) );
  DFFNSRX2TS \mips/mips/c/md/accfullinstruction_reg[2]  ( .D(n5843), .CKN(clk), 
        .SN(1'b1), .RN(1'b1), .Q(\mips/mips/accfullinstruction[2] ) );
  DFFNSRX2TS \mips/mips/c/md/accfullinstruction_reg[3]  ( .D(n5842), .CKN(clk), 
        .SN(1'b1), .RN(1'b1), .Q(\mips/mips/accfullinstruction[3] ) );
  DFFNSRX2TS \mips/mips/c/md/accfullinstruction_reg[4]  ( .D(n5841), .CKN(clk), 
        .SN(1'b1), .RN(1'b1), .Q(\mips/mips/accfullinstruction[4] ) );
  DFFNSRX2TS \mips/mips/c/md/accfullinstruction_reg[5]  ( .D(n5840), .CKN(clk), 
        .SN(1'b1), .RN(1'b1), .Q(\mips/mips/accfullinstruction[5] ) );
  DFFNSRX2TS \mips/mips/c/md/accfullinstruction_reg[6]  ( .D(n5839), .CKN(clk), 
        .SN(1'b1), .RN(1'b1), .Q(\mips/mips/accfullinstruction[6] ) );
  DFFNSRX2TS \mips/mips/c/md/accfullinstruction_reg[7]  ( .D(n5838), .CKN(clk), 
        .SN(1'b1), .RN(1'b1), .Q(\mips/mips/accfullinstruction[7] ) );
  DFFNSRX2TS \mips/mips/c/md/accfullinstruction_reg[8]  ( .D(n5837), .CKN(clk), 
        .SN(1'b1), .RN(1'b1), .Q(\mips/mips/accfullinstruction[8] ) );
  DFFNSRX2TS \mips/mips/c/md/accfullinstruction_reg[9]  ( .D(n5836), .CKN(clk), 
        .SN(1'b1), .RN(1'b1), .Q(\mips/mips/accfullinstruction[9] ) );
  DFFNSRX2TS \mips/mips/c/md/accfullinstruction_reg[10]  ( .D(n5835), .CKN(clk), .SN(1'b1), .RN(1'b1), .Q(\mips/mips/accfullinstruction[10] ) );
  DFFNSRX2TS \mips/mips/c/md/accfullinstruction_reg[11]  ( .D(n5834), .CKN(clk), .SN(1'b1), .RN(1'b1), .Q(\mips/mips/accfullinstruction[11] ) );
  DFFNSRX2TS \mips/mips/c/md/accfullinstruction_reg[12]  ( .D(n5833), .CKN(clk), .SN(1'b1), .RN(1'b1), .Q(\mips/mips/accfullinstruction[12] ) );
  DFFNSRX2TS \mips/mips/c/md/accfullinstruction_reg[13]  ( .D(n5832), .CKN(clk), .SN(1'b1), .RN(1'b1), .Q(\mips/mips/accfullinstruction[13] ) );
  DFFNSRX2TS \mips/mips/c/md/accfullinstruction_reg[14]  ( .D(n5831), .CKN(clk), .SN(1'b1), .RN(1'b1), .Q(\mips/mips/accfullinstruction[14] ) );
  DFFNSRX2TS \mips/mips/c/md/accfullinstruction_reg[15]  ( .D(n5830), .CKN(clk), .SN(1'b1), .RN(1'b1), .Q(\mips/mips/accfullinstruction[15] ) );
  DFFNSRX2TS \mips/mips/c/md/accfullinstruction_reg[16]  ( .D(n5829), .CKN(clk), .SN(1'b1), .RN(1'b1), .Q(\mips/mips/accfullinstruction[16] ) );
  DFFNSRX2TS \mips/mips/c/md/accfullinstruction_reg[17]  ( .D(n5828), .CKN(clk), .SN(1'b1), .RN(1'b1), .Q(\mips/mips/accfullinstruction[17] ) );
  DFFNSRX2TS \mips/mips/c/md/accfullinstruction_reg[18]  ( .D(n5827), .CKN(clk), .SN(1'b1), .RN(1'b1), .Q(\mips/mips/accfullinstruction[18] ) );
  DFFNSRX2TS \mips/mips/c/md/accfullinstruction_reg[19]  ( .D(n5826), .CKN(clk), .SN(1'b1), .RN(1'b1), .Q(\mips/mips/accfullinstruction[19] ) );
  DFFNSRX2TS \mips/mips/c/md/accfullinstruction_reg[20]  ( .D(n5825), .CKN(clk), .SN(1'b1), .RN(1'b1), .Q(\mips/mips/accfullinstruction[20] ) );
  DFFNSRX2TS \mips/mips/c/md/accfullinstruction_reg[21]  ( .D(n5824), .CKN(clk), .SN(1'b1), .RN(1'b1), .Q(\mips/mips/accfullinstruction[21] ) );
  DFFNSRX2TS \mips/mips/c/md/accfullinstruction_reg[22]  ( .D(n5823), .CKN(clk), .SN(1'b1), .RN(1'b1), .Q(\mips/mips/accfullinstruction[22] ) );
  DFFNSRX2TS \mips/mips/c/md/accfullinstruction_reg[23]  ( .D(n5822), .CKN(clk), .SN(1'b1), .RN(1'b1), .Q(\mips/mips/accfullinstruction[23] ) );
  DFFNSRX2TS \mips/mips/c/md/accfullinstruction_reg[24]  ( .D(n5821), .CKN(clk), .SN(1'b1), .RN(1'b1), .Q(\mips/mips/accfullinstruction[24] ) );
  DFFNSRX2TS \mips/mips/c/md/accfullinstruction_reg[25]  ( .D(n5820), .CKN(clk), .SN(1'b1), .RN(1'b1), .Q(\mips/mips/accfullinstruction[25] ) );
  DFFNSRX2TS \mips/mips/c/md/accfullinstruction_reg[1]  ( .D(n5844), .CKN(clk), 
        .SN(1'b1), .RN(1'b1), .Q(\mips/mips/accfullinstruction[1] ) );
  DFFNSRX2TS \mips/mips/c/md/accbypass_reg  ( .D(n5942), .CKN(clk), .SN(1'b1), 
        .RN(1'b1), .Q(\mips/mips/accbypass ) );
  ADDHXLTS \add_x_22_5/U1_1_27  ( .A(
        \router/addr_calc/iir_write_calc/count[27] ), .B(
        \add_x_22_5/carry[27] ), .CO(\add_x_22_5/carry[28] ), .S(
        \router/addr_calc/iir_write_calc/counter/N73 ) );
  ADDHXLTS \add_x_22_5/U1_1_26  ( .A(n6159), .B(\add_x_22_5/carry[26] ), .CO(
        \add_x_22_5/carry[27] ), .S(
        \router/addr_calc/iir_write_calc/counter/N72 ) );
  ADDHXLTS \add_x_22_5/U1_1_25  ( .A(n6387), .B(\add_x_22_5/carry[25] ), .CO(
        \add_x_22_5/carry[26] ), .S(
        \router/addr_calc/iir_write_calc/counter/N71 ) );
  ADDHXLTS \add_x_22_5/U1_1_24  ( .A(n6391), .B(\add_x_22_5/carry[24] ), .CO(
        \add_x_22_5/carry[25] ), .S(
        \router/addr_calc/iir_write_calc/counter/N70 ) );
  ADDHXLTS \add_x_22_5/U1_1_23  ( .A(
        \router/addr_calc/iir_write_calc/count[23] ), .B(
        \add_x_22_5/carry[23] ), .CO(\add_x_22_5/carry[24] ), .S(
        \router/addr_calc/iir_write_calc/counter/N69 ) );
  ADDHXLTS \add_x_22_5/U1_1_22  ( .A(n6395), .B(\add_x_22_5/carry[22] ), .CO(
        \add_x_22_5/carry[23] ), .S(
        \router/addr_calc/iir_write_calc/counter/N68 ) );
  ADDHXLTS \add_x_22_5/U1_1_21  ( .A(n6399), .B(\add_x_22_5/carry[21] ), .CO(
        \add_x_22_5/carry[22] ), .S(
        \router/addr_calc/iir_write_calc/counter/N67 ) );
  ADDHXLTS \add_x_22_5/U1_1_20  ( .A(n6403), .B(\add_x_22_5/carry[20] ), .CO(
        \add_x_22_5/carry[21] ), .S(
        \router/addr_calc/iir_write_calc/counter/N66 ) );
  ADDHXLTS \add_x_22_5/U1_1_19  ( .A(n6407), .B(\add_x_22_5/carry[19] ), .CO(
        \add_x_22_5/carry[20] ), .S(
        \router/addr_calc/iir_write_calc/counter/N65 ) );
  ADDHXLTS \add_x_22_5/U1_1_18  ( .A(\router/addr_calc/iir_write_addr[18] ), 
        .B(\add_x_22_5/carry[18] ), .CO(\add_x_22_5/carry[19] ), .S(
        \router/addr_calc/iir_write_calc/counter/N64 ) );
  ADDHXLTS \add_x_22_5/U1_1_17  ( .A(n6411), .B(\add_x_22_5/carry[17] ), .CO(
        \add_x_22_5/carry[18] ), .S(
        \router/addr_calc/iir_write_calc/counter/N63 ) );
  ADDHXLTS \add_x_22_5/U1_1_16  ( .A(n6415), .B(\add_x_22_5/carry[16] ), .CO(
        \add_x_22_5/carry[17] ), .S(
        \router/addr_calc/iir_write_calc/counter/N62 ) );
  ADDHXLTS \add_x_22_5/U1_1_15  ( .A(n6419), .B(\add_x_22_5/carry[15] ), .CO(
        \add_x_22_5/carry[16] ), .S(
        \router/addr_calc/iir_write_calc/counter/N61 ) );
  ADDHXLTS \add_x_22_5/U1_1_14  ( .A(\router/addr_calc/iir_write_addr[14] ), 
        .B(\add_x_22_5/carry[14] ), .CO(\add_x_22_5/carry[15] ), .S(
        \router/addr_calc/iir_write_calc/counter/N60 ) );
  ADDHXLTS \add_x_22_5/U1_1_13  ( .A(n6423), .B(\add_x_22_5/carry[13] ), .CO(
        \add_x_22_5/carry[14] ), .S(
        \router/addr_calc/iir_write_calc/counter/N59 ) );
  ADDHXLTS \add_x_22_5/U1_1_12  ( .A(n6427), .B(\add_x_22_5/carry[12] ), .CO(
        \add_x_22_5/carry[13] ), .S(
        \router/addr_calc/iir_write_calc/counter/N58 ) );
  ADDHXLTS \add_x_22_5/U1_1_11  ( .A(n6431), .B(\add_x_22_5/carry[11] ), .CO(
        \add_x_22_5/carry[12] ), .S(
        \router/addr_calc/iir_write_calc/counter/N57 ) );
  ADDHXLTS \add_x_22_5/U1_1_10  ( .A(n6435), .B(\add_x_22_5/carry[10] ), .CO(
        \add_x_22_5/carry[11] ), .S(
        \router/addr_calc/iir_write_calc/counter/N56 ) );
  ADDHXLTS \add_x_22_5/U1_1_9  ( .A(\router/addr_calc/iir_write_addr[9] ), .B(
        \add_x_22_5/carry[9] ), .CO(\add_x_22_5/carry[10] ), .S(
        \router/addr_calc/iir_write_calc/counter/N55 ) );
  ADDHXLTS \add_x_22_5/U1_1_8  ( .A(n6439), .B(\add_x_22_5/carry[8] ), .CO(
        \add_x_22_5/carry[9] ), .S(
        \router/addr_calc/iir_write_calc/counter/N54 ) );
  ADDHXLTS \add_x_22_5/U1_1_7  ( .A(n6443), .B(\add_x_22_5/carry[7] ), .CO(
        \add_x_22_5/carry[8] ), .S(
        \router/addr_calc/iir_write_calc/counter/N53 ) );
  ADDHXLTS \add_x_22_5/U1_1_6  ( .A(n6447), .B(\add_x_22_5/carry[6] ), .CO(
        \add_x_22_5/carry[7] ), .S(
        \router/addr_calc/iir_write_calc/counter/N52 ) );
  ADDHXLTS \add_x_22_5/U1_1_5  ( .A(\router/addr_calc/iir_write_addr[5] ), .B(
        \add_x_22_5/carry[5] ), .CO(\add_x_22_5/carry[6] ), .S(
        \router/addr_calc/iir_write_calc/counter/N51 ) );
  ADDHXLTS \add_x_22_5/U1_1_4  ( .A(n6451), .B(\add_x_22_5/carry[4] ), .CO(
        \add_x_22_5/carry[5] ), .S(
        \router/addr_calc/iir_write_calc/counter/N50 ) );
  ADDHXLTS \add_x_22_5/U1_1_3  ( .A(n6455), .B(\add_x_22_5/carry[3] ), .CO(
        \add_x_22_5/carry[4] ), .S(
        \router/addr_calc/iir_write_calc/counter/N49 ) );
  ADDHXLTS \add_x_22_5/U1_1_2  ( .A(n6459), .B(\add_x_22_5/carry[2] ), .CO(
        \add_x_22_5/carry[3] ), .S(
        \router/addr_calc/iir_write_calc/counter/N48 ) );
  ADDHXLTS \add_x_22_5/U1_1_1  ( .A(n6463), .B(
        \router/addr_calc/iir_write_calc/count[0] ), .CO(\add_x_22_5/carry[2] ), .S(\router/addr_calc/iir_write_calc/counter/N47 ) );
  ADDHXLTS \add_x_22_3/U1_1_30  ( .A(
        \router/addr_calc/fir_write_calc/count[30] ), .B(
        \add_x_22_3/carry[30] ), .CO(\add_x_22_3/carry[31] ), .S(
        \router/addr_calc/fir_write_calc/counter/N76 ) );
  ADDHXLTS \add_x_22_3/U1_1_27  ( .A(
        \router/addr_calc/fir_write_calc/count[27] ), .B(
        \add_x_22_3/carry[27] ), .CO(\add_x_22_3/carry[28] ), .S(
        \router/addr_calc/fir_write_calc/counter/N73 ) );
  ADDHXLTS \add_x_22_3/U1_1_26  ( .A(n6156), .B(\add_x_22_3/carry[26] ), .CO(
        \add_x_22_3/carry[27] ), .S(
        \router/addr_calc/fir_write_calc/counter/N72 ) );
  ADDHXLTS \add_x_22_3/U1_1_25  ( .A(n6483), .B(\add_x_22_3/carry[25] ), .CO(
        \add_x_22_3/carry[26] ), .S(
        \router/addr_calc/fir_write_calc/counter/N71 ) );
  ADDHXLTS \add_x_22_3/U1_1_24  ( .A(n6487), .B(\add_x_22_3/carry[24] ), .CO(
        \add_x_22_3/carry[25] ), .S(
        \router/addr_calc/fir_write_calc/counter/N70 ) );
  ADDHXLTS \add_x_22_3/U1_1_23  ( .A(
        \router/addr_calc/fir_write_calc/count[23] ), .B(
        \add_x_22_3/carry[23] ), .CO(\add_x_22_3/carry[24] ), .S(
        \router/addr_calc/fir_write_calc/counter/N69 ) );
  ADDHXLTS \add_x_22_3/U1_1_22  ( .A(n6489), .B(\add_x_22_3/carry[22] ), .CO(
        \add_x_22_3/carry[23] ), .S(
        \router/addr_calc/fir_write_calc/counter/N68 ) );
  ADDHXLTS \add_x_22_3/U1_1_21  ( .A(n6491), .B(\add_x_22_3/carry[21] ), .CO(
        \add_x_22_3/carry[22] ), .S(
        \router/addr_calc/fir_write_calc/counter/N67 ) );
  ADDHXLTS \add_x_22_3/U1_1_20  ( .A(n6493), .B(\add_x_22_3/carry[20] ), .CO(
        \add_x_22_3/carry[21] ), .S(
        \router/addr_calc/fir_write_calc/counter/N66 ) );
  ADDHXLTS \add_x_22_3/U1_1_19  ( .A(\router/addr_calc/fir_write_addr[19] ), 
        .B(\add_x_22_3/carry[19] ), .CO(\add_x_22_3/carry[20] ), .S(
        \router/addr_calc/fir_write_calc/counter/N65 ) );
  ADDHXLTS \add_x_22_3/U1_1_18  ( .A(n6495), .B(\add_x_22_3/carry[18] ), .CO(
        \add_x_22_3/carry[19] ), .S(
        \router/addr_calc/fir_write_calc/counter/N64 ) );
  ADDHXLTS \add_x_22_3/U1_1_17  ( .A(n6497), .B(\add_x_22_3/carry[17] ), .CO(
        \add_x_22_3/carry[18] ), .S(
        \router/addr_calc/fir_write_calc/counter/N63 ) );
  ADDHXLTS \add_x_22_3/U1_1_16  ( .A(n6499), .B(\add_x_22_3/carry[16] ), .CO(
        \add_x_22_3/carry[17] ), .S(
        \router/addr_calc/fir_write_calc/counter/N62 ) );
  ADDHXLTS \add_x_22_3/U1_1_15  ( .A(\router/addr_calc/fir_write_addr[15] ), 
        .B(\add_x_22_3/carry[15] ), .CO(\add_x_22_3/carry[16] ), .S(
        \router/addr_calc/fir_write_calc/counter/N61 ) );
  ADDHXLTS \add_x_22_3/U1_1_14  ( .A(n6501), .B(\add_x_22_3/carry[14] ), .CO(
        \add_x_22_3/carry[15] ), .S(
        \router/addr_calc/fir_write_calc/counter/N60 ) );
  ADDHXLTS \add_x_22_3/U1_1_13  ( .A(n6503), .B(\add_x_22_3/carry[13] ), .CO(
        \add_x_22_3/carry[14] ), .S(
        \router/addr_calc/fir_write_calc/counter/N59 ) );
  ADDHXLTS \add_x_22_3/U1_1_12  ( .A(n6505), .B(\add_x_22_3/carry[12] ), .CO(
        \add_x_22_3/carry[13] ), .S(
        \router/addr_calc/fir_write_calc/counter/N58 ) );
  ADDHXLTS \add_x_22_3/U1_1_11  ( .A(n6507), .B(\add_x_22_3/carry[11] ), .CO(
        \add_x_22_3/carry[12] ), .S(
        \router/addr_calc/fir_write_calc/counter/N57 ) );
  ADDHXLTS \add_x_22_3/U1_1_10  ( .A(n6509), .B(\add_x_22_3/carry[10] ), .CO(
        \add_x_22_3/carry[11] ), .S(
        \router/addr_calc/fir_write_calc/counter/N56 ) );
  ADDHXLTS \add_x_22_3/U1_1_9  ( .A(\router/addr_calc/fir_write_addr[9] ), .B(
        \add_x_22_3/carry[9] ), .CO(\add_x_22_3/carry[10] ), .S(
        \router/addr_calc/fir_write_calc/counter/N55 ) );
  ADDHXLTS \add_x_22_3/U1_1_8  ( .A(n6511), .B(\add_x_22_3/carry[8] ), .CO(
        \add_x_22_3/carry[9] ), .S(
        \router/addr_calc/fir_write_calc/counter/N54 ) );
  ADDHXLTS \add_x_22_3/U1_1_7  ( .A(n6513), .B(\add_x_22_3/carry[7] ), .CO(
        \add_x_22_3/carry[8] ), .S(
        \router/addr_calc/fir_write_calc/counter/N53 ) );
  ADDHXLTS \add_x_22_3/U1_1_6  ( .A(n6515), .B(\add_x_22_3/carry[6] ), .CO(
        \add_x_22_3/carry[7] ), .S(
        \router/addr_calc/fir_write_calc/counter/N52 ) );
  ADDHXLTS \add_x_22_3/U1_1_5  ( .A(\router/addr_calc/fir_write_addr[5] ), .B(
        \add_x_22_3/carry[5] ), .CO(\add_x_22_3/carry[6] ), .S(
        \router/addr_calc/fir_write_calc/counter/N51 ) );
  ADDHXLTS \add_x_22_3/U1_1_4  ( .A(n6517), .B(\add_x_22_3/carry[4] ), .CO(
        \add_x_22_3/carry[5] ), .S(
        \router/addr_calc/fir_write_calc/counter/N50 ) );
  ADDHXLTS \add_x_22_3/U1_1_3  ( .A(n6519), .B(\add_x_22_3/carry[3] ), .CO(
        \add_x_22_3/carry[4] ), .S(
        \router/addr_calc/fir_write_calc/counter/N49 ) );
  ADDHXLTS \add_x_22_3/U1_1_2  ( .A(n6521), .B(\add_x_22_3/carry[2] ), .CO(
        \add_x_22_3/carry[3] ), .S(
        \router/addr_calc/fir_write_calc/counter/N48 ) );
  ADDHXLTS \add_x_22_3/U1_1_1  ( .A(n6523), .B(
        \router/addr_calc/fir_write_calc/count[0] ), .CO(\add_x_22_3/carry[2] ), .S(\router/addr_calc/fir_write_calc/counter/N47 ) );
  ADDHXLTS \add_x_22_2/U1_1_30  ( .A(
        \router/addr_calc/fir_read_calc/count[30] ), .B(\add_x_22_2/carry[30] ), .CO(\add_x_22_2/carry[31] ), .S(\router/addr_calc/fir_read_calc/counter/N76 ) );
  ADDHXLTS \add_x_22_2/U1_1_27  ( .A(
        \router/addr_calc/fir_read_calc/count[27] ), .B(\add_x_22_2/carry[27] ), .CO(\add_x_22_2/carry[28] ), .S(\router/addr_calc/fir_read_calc/counter/N73 ) );
  ADDHXLTS \add_x_22_2/U1_1_26  ( .A(n6155), .B(\add_x_22_2/carry[26] ), .CO(
        \add_x_22_2/carry[27] ), .S(
        \router/addr_calc/fir_read_calc/counter/N72 ) );
  ADDHXLTS \add_x_22_2/U1_1_25  ( .A(n6533), .B(\add_x_22_2/carry[25] ), .CO(
        \add_x_22_2/carry[26] ), .S(
        \router/addr_calc/fir_read_calc/counter/N71 ) );
  ADDHXLTS \add_x_22_2/U1_1_24  ( .A(n6535), .B(\add_x_22_2/carry[24] ), .CO(
        \add_x_22_2/carry[25] ), .S(
        \router/addr_calc/fir_read_calc/counter/N70 ) );
  ADDHXLTS \add_x_22_2/U1_1_23  ( .A(
        \router/addr_calc/fir_read_calc/count[23] ), .B(\add_x_22_2/carry[23] ), .CO(\add_x_22_2/carry[24] ), .S(\router/addr_calc/fir_read_calc/counter/N69 ) );
  ADDHXLTS \add_x_22_2/U1_1_22  ( .A(n6537), .B(\add_x_22_2/carry[22] ), .CO(
        \add_x_22_2/carry[23] ), .S(
        \router/addr_calc/fir_read_calc/counter/N68 ) );
  ADDHXLTS \add_x_22_2/U1_1_21  ( .A(n6539), .B(\add_x_22_2/carry[21] ), .CO(
        \add_x_22_2/carry[22] ), .S(
        \router/addr_calc/fir_read_calc/counter/N67 ) );
  ADDHXLTS \add_x_22_2/U1_1_20  ( .A(n6541), .B(\add_x_22_2/carry[20] ), .CO(
        \add_x_22_2/carry[21] ), .S(
        \router/addr_calc/fir_read_calc/counter/N66 ) );
  ADDHXLTS \add_x_22_2/U1_1_19  ( .A(n6543), .B(\add_x_22_2/carry[19] ), .CO(
        \add_x_22_2/carry[20] ), .S(
        \router/addr_calc/fir_read_calc/counter/N65 ) );
  ADDHXLTS \add_x_22_2/U1_1_18  ( .A(\router/addr_calc/fir_read_addr[18] ), 
        .B(\add_x_22_2/carry[18] ), .CO(\add_x_22_2/carry[19] ), .S(
        \router/addr_calc/fir_read_calc/counter/N64 ) );
  ADDHXLTS \add_x_22_2/U1_1_17  ( .A(n6545), .B(\add_x_22_2/carry[17] ), .CO(
        \add_x_22_2/carry[18] ), .S(
        \router/addr_calc/fir_read_calc/counter/N63 ) );
  ADDHXLTS \add_x_22_2/U1_1_16  ( .A(n6547), .B(\add_x_22_2/carry[16] ), .CO(
        \add_x_22_2/carry[17] ), .S(
        \router/addr_calc/fir_read_calc/counter/N62 ) );
  ADDHXLTS \add_x_22_2/U1_1_15  ( .A(n6549), .B(\add_x_22_2/carry[15] ), .CO(
        \add_x_22_2/carry[16] ), .S(
        \router/addr_calc/fir_read_calc/counter/N61 ) );
  ADDHXLTS \add_x_22_2/U1_1_14  ( .A(\router/addr_calc/fir_read_addr[14] ), 
        .B(\add_x_22_2/carry[14] ), .CO(\add_x_22_2/carry[15] ), .S(
        \router/addr_calc/fir_read_calc/counter/N60 ) );
  ADDHXLTS \add_x_22_2/U1_1_13  ( .A(n6551), .B(\add_x_22_2/carry[13] ), .CO(
        \add_x_22_2/carry[14] ), .S(
        \router/addr_calc/fir_read_calc/counter/N59 ) );
  ADDHXLTS \add_x_22_2/U1_1_12  ( .A(n6553), .B(\add_x_22_2/carry[12] ), .CO(
        \add_x_22_2/carry[13] ), .S(
        \router/addr_calc/fir_read_calc/counter/N58 ) );
  ADDHXLTS \add_x_22_2/U1_1_11  ( .A(n6555), .B(\add_x_22_2/carry[11] ), .CO(
        \add_x_22_2/carry[12] ), .S(
        \router/addr_calc/fir_read_calc/counter/N57 ) );
  ADDHXLTS \add_x_22_2/U1_1_10  ( .A(n6557), .B(\add_x_22_2/carry[10] ), .CO(
        \add_x_22_2/carry[11] ), .S(
        \router/addr_calc/fir_read_calc/counter/N56 ) );
  ADDHXLTS \add_x_22_2/U1_1_9  ( .A(\router/addr_calc/fir_read_addr[9] ), .B(
        \add_x_22_2/carry[9] ), .CO(\add_x_22_2/carry[10] ), .S(
        \router/addr_calc/fir_read_calc/counter/N55 ) );
  ADDHXLTS \add_x_22_2/U1_1_8  ( .A(n6559), .B(\add_x_22_2/carry[8] ), .CO(
        \add_x_22_2/carry[9] ), .S(
        \router/addr_calc/fir_read_calc/counter/N54 ) );
  ADDHXLTS \add_x_22_2/U1_1_7  ( .A(n6561), .B(\add_x_22_2/carry[7] ), .CO(
        \add_x_22_2/carry[8] ), .S(
        \router/addr_calc/fir_read_calc/counter/N53 ) );
  ADDHXLTS \add_x_22_2/U1_1_6  ( .A(n6563), .B(\add_x_22_2/carry[6] ), .CO(
        \add_x_22_2/carry[7] ), .S(
        \router/addr_calc/fir_read_calc/counter/N52 ) );
  ADDHXLTS \add_x_22_2/U1_1_5  ( .A(\router/addr_calc/fir_read_addr[5] ), .B(
        \add_x_22_2/carry[5] ), .CO(\add_x_22_2/carry[6] ), .S(
        \router/addr_calc/fir_read_calc/counter/N51 ) );
  ADDHXLTS \add_x_22_2/U1_1_4  ( .A(n6565), .B(\add_x_22_2/carry[4] ), .CO(
        \add_x_22_2/carry[5] ), .S(
        \router/addr_calc/fir_read_calc/counter/N50 ) );
  ADDHXLTS \add_x_22_2/U1_1_3  ( .A(n6567), .B(\add_x_22_2/carry[3] ), .CO(
        \add_x_22_2/carry[4] ), .S(
        \router/addr_calc/fir_read_calc/counter/N49 ) );
  ADDHXLTS \add_x_22_2/U1_1_2  ( .A(n6569), .B(\add_x_22_2/carry[2] ), .CO(
        \add_x_22_2/carry[3] ), .S(
        \router/addr_calc/fir_read_calc/counter/N48 ) );
  ADDHXLTS \add_x_22_2/U1_1_1  ( .A(n6571), .B(
        \router/addr_calc/fir_read_calc/count[0] ), .CO(\add_x_22_2/carry[2] ), 
        .S(\router/addr_calc/fir_read_calc/counter/N47 ) );
  ADDHXLTS \add_x_22_1/U1_1_29  ( .A(n6168), .B(\add_x_22_1/carry[29] ), .CO(
        \add_x_22_1/carry[30] ), .S(
        \router/addr_calc/fft_write_calc/counter/N75 ) );
  ADDHXLTS \add_x_22_1/U1_1_28  ( .A(
        \router/addr_calc/fft_write_calc/count[28] ), .B(
        \add_x_22_1/carry[28] ), .CO(\add_x_22_1/carry[29] ), .S(
        \router/addr_calc/fft_write_calc/counter/N74 ) );
  ADDHXLTS \add_x_22_1/U1_1_27  ( .A(
        \router/addr_calc/fft_write_calc/count[27] ), .B(
        \add_x_22_1/carry[27] ), .CO(\add_x_22_1/carry[28] ), .S(
        \router/addr_calc/fft_write_calc/counter/N73 ) );
  ADDHXLTS \add_x_22_1/U1_1_26  ( .A(n6154), .B(\add_x_22_1/carry[26] ), .CO(
        \add_x_22_1/carry[27] ), .S(
        \router/addr_calc/fft_write_calc/counter/N72 ) );
  ADDHXLTS \add_x_22_1/U1_1_25  ( .A(n6579), .B(\add_x_22_1/carry[25] ), .CO(
        \add_x_22_1/carry[26] ), .S(
        \router/addr_calc/fft_write_calc/counter/N71 ) );
  ADDHXLTS \add_x_22_1/U1_1_24  ( .A(n6581), .B(\add_x_22_1/carry[24] ), .CO(
        \add_x_22_1/carry[25] ), .S(
        \router/addr_calc/fft_write_calc/counter/N70 ) );
  ADDHXLTS \add_x_22_1/U1_1_23  ( .A(
        \router/addr_calc/fft_write_calc/count[23] ), .B(
        \add_x_22_1/carry[23] ), .CO(\add_x_22_1/carry[24] ), .S(
        \router/addr_calc/fft_write_calc/counter/N69 ) );
  ADDHXLTS \add_x_22_1/U1_1_22  ( .A(n6583), .B(\add_x_22_1/carry[22] ), .CO(
        \add_x_22_1/carry[23] ), .S(
        \router/addr_calc/fft_write_calc/counter/N68 ) );
  ADDHXLTS \add_x_22_1/U1_1_21  ( .A(n6585), .B(\add_x_22_1/carry[21] ), .CO(
        \add_x_22_1/carry[22] ), .S(
        \router/addr_calc/fft_write_calc/counter/N67 ) );
  ADDHXLTS \add_x_22_1/U1_1_20  ( .A(n6587), .B(\add_x_22_1/carry[20] ), .CO(
        \add_x_22_1/carry[21] ), .S(
        \router/addr_calc/fft_write_calc/counter/N66 ) );
  ADDHXLTS \add_x_22_1/U1_1_19  ( .A(\router/addr_calc/fft_write_addr[19] ), 
        .B(\add_x_22_1/carry[19] ), .CO(\add_x_22_1/carry[20] ), .S(
        \router/addr_calc/fft_write_calc/counter/N65 ) );
  ADDHXLTS \add_x_22_1/U1_1_18  ( .A(n6589), .B(\add_x_22_1/carry[18] ), .CO(
        \add_x_22_1/carry[19] ), .S(
        \router/addr_calc/fft_write_calc/counter/N64 ) );
  ADDHXLTS \add_x_22_1/U1_1_17  ( .A(n6591), .B(\add_x_22_1/carry[17] ), .CO(
        \add_x_22_1/carry[18] ), .S(
        \router/addr_calc/fft_write_calc/counter/N63 ) );
  ADDHXLTS \add_x_22_1/U1_1_16  ( .A(n6593), .B(\add_x_22_1/carry[16] ), .CO(
        \add_x_22_1/carry[17] ), .S(
        \router/addr_calc/fft_write_calc/counter/N62 ) );
  ADDHXLTS \add_x_22_1/U1_1_15  ( .A(\router/addr_calc/fft_write_addr[15] ), 
        .B(\add_x_22_1/carry[15] ), .CO(\add_x_22_1/carry[16] ), .S(
        \router/addr_calc/fft_write_calc/counter/N61 ) );
  ADDHXLTS \add_x_22_1/U1_1_14  ( .A(n6595), .B(\add_x_22_1/carry[14] ), .CO(
        \add_x_22_1/carry[15] ), .S(
        \router/addr_calc/fft_write_calc/counter/N60 ) );
  ADDHXLTS \add_x_22_1/U1_1_13  ( .A(n6597), .B(\add_x_22_1/carry[13] ), .CO(
        \add_x_22_1/carry[14] ), .S(
        \router/addr_calc/fft_write_calc/counter/N59 ) );
  ADDHXLTS \add_x_22_1/U1_1_12  ( .A(n6599), .B(\add_x_22_1/carry[12] ), .CO(
        \add_x_22_1/carry[13] ), .S(
        \router/addr_calc/fft_write_calc/counter/N58 ) );
  ADDHXLTS \add_x_22_1/U1_1_11  ( .A(n6601), .B(\add_x_22_1/carry[11] ), .CO(
        \add_x_22_1/carry[12] ), .S(
        \router/addr_calc/fft_write_calc/counter/N57 ) );
  ADDHXLTS \add_x_22_1/U1_1_10  ( .A(n6603), .B(\add_x_22_1/carry[10] ), .CO(
        \add_x_22_1/carry[11] ), .S(
        \router/addr_calc/fft_write_calc/counter/N56 ) );
  ADDHXLTS \add_x_22_1/U1_1_9  ( .A(\router/addr_calc/fft_write_addr[9] ), .B(
        \add_x_22_1/carry[9] ), .CO(\add_x_22_1/carry[10] ), .S(
        \router/addr_calc/fft_write_calc/counter/N55 ) );
  ADDHXLTS \add_x_22_1/U1_1_8  ( .A(n6605), .B(\add_x_22_1/carry[8] ), .CO(
        \add_x_22_1/carry[9] ), .S(
        \router/addr_calc/fft_write_calc/counter/N54 ) );
  ADDHXLTS \add_x_22_1/U1_1_7  ( .A(n6607), .B(\add_x_22_1/carry[7] ), .CO(
        \add_x_22_1/carry[8] ), .S(
        \router/addr_calc/fft_write_calc/counter/N53 ) );
  ADDHXLTS \add_x_22_1/U1_1_6  ( .A(n6609), .B(\add_x_22_1/carry[6] ), .CO(
        \add_x_22_1/carry[7] ), .S(
        \router/addr_calc/fft_write_calc/counter/N52 ) );
  ADDHXLTS \add_x_22_1/U1_1_5  ( .A(n6611), .B(\add_x_22_1/carry[5] ), .CO(
        \add_x_22_1/carry[6] ), .S(
        \router/addr_calc/fft_write_calc/counter/N51 ) );
  ADDHXLTS \add_x_22_1/U1_1_4  ( .A(n6613), .B(\add_x_22_1/carry[4] ), .CO(
        \add_x_22_1/carry[5] ), .S(
        \router/addr_calc/fft_write_calc/counter/N50 ) );
  ADDHXLTS \add_x_22_1/U1_1_3  ( .A(n6615), .B(\add_x_22_1/carry[3] ), .CO(
        \add_x_22_1/carry[4] ), .S(
        \router/addr_calc/fft_write_calc/counter/N49 ) );
  ADDHXLTS \add_x_22_1/U1_1_2  ( .A(n6617), .B(\add_x_22_1/carry[2] ), .CO(
        \add_x_22_1/carry[3] ), .S(
        \router/addr_calc/fft_write_calc/counter/N48 ) );
  ADDHXLTS \add_x_22_1/U1_1_1  ( .A(n6619), .B(
        \router/addr_calc/fft_write_calc/count[0] ), .CO(\add_x_22_1/carry[2] ), .S(\router/addr_calc/fft_write_calc/counter/N47 ) );
  ADDHXLTS \add_x_22_0/U1_1_30  ( .A(
        \router/addr_calc/fft_read_calc/count[30] ), .B(\add_x_22_0/carry[30] ), .CO(\add_x_22_0/carry[31] ), .S(\router/addr_calc/fft_read_calc/counter/N76 ) );
  ADDHXLTS \add_x_22_0/U1_1_27  ( .A(
        \router/addr_calc/fft_read_calc/count[27] ), .B(\add_x_22_0/carry[27] ), .CO(\add_x_22_0/carry[28] ), .S(\router/addr_calc/fft_read_calc/counter/N73 ) );
  ADDHXLTS \add_x_22_0/U1_1_26  ( .A(n6153), .B(\add_x_22_0/carry[26] ), .CO(
        \add_x_22_0/carry[27] ), .S(
        \router/addr_calc/fft_read_calc/counter/N72 ) );
  ADDHXLTS \add_x_22_0/U1_1_25  ( .A(n6629), .B(\add_x_22_0/carry[25] ), .CO(
        \add_x_22_0/carry[26] ), .S(
        \router/addr_calc/fft_read_calc/counter/N71 ) );
  ADDHXLTS \add_x_22_0/U1_1_24  ( .A(n6631), .B(\add_x_22_0/carry[24] ), .CO(
        \add_x_22_0/carry[25] ), .S(
        \router/addr_calc/fft_read_calc/counter/N70 ) );
  ADDHXLTS \add_x_22_0/U1_1_23  ( .A(
        \router/addr_calc/fft_read_calc/count[23] ), .B(\add_x_22_0/carry[23] ), .CO(\add_x_22_0/carry[24] ), .S(\router/addr_calc/fft_read_calc/counter/N69 ) );
  ADDHXLTS \add_x_22_0/U1_1_22  ( .A(n6633), .B(\add_x_22_0/carry[22] ), .CO(
        \add_x_22_0/carry[23] ), .S(
        \router/addr_calc/fft_read_calc/counter/N68 ) );
  ADDHXLTS \add_x_22_0/U1_1_21  ( .A(n6635), .B(\add_x_22_0/carry[21] ), .CO(
        \add_x_22_0/carry[22] ), .S(
        \router/addr_calc/fft_read_calc/counter/N67 ) );
  ADDHXLTS \add_x_22_0/U1_1_20  ( .A(n6637), .B(\add_x_22_0/carry[20] ), .CO(
        \add_x_22_0/carry[21] ), .S(
        \router/addr_calc/fft_read_calc/counter/N66 ) );
  ADDHXLTS \add_x_22_0/U1_1_19  ( .A(n6639), .B(\add_x_22_0/carry[19] ), .CO(
        \add_x_22_0/carry[20] ), .S(
        \router/addr_calc/fft_read_calc/counter/N65 ) );
  ADDHXLTS \add_x_22_0/U1_1_18  ( .A(\router/addr_calc/fft_read_addr[18] ), 
        .B(\add_x_22_0/carry[18] ), .CO(\add_x_22_0/carry[19] ), .S(
        \router/addr_calc/fft_read_calc/counter/N64 ) );
  ADDHXLTS \add_x_22_0/U1_1_17  ( .A(n6641), .B(\add_x_22_0/carry[17] ), .CO(
        \add_x_22_0/carry[18] ), .S(
        \router/addr_calc/fft_read_calc/counter/N63 ) );
  ADDHXLTS \add_x_22_0/U1_1_16  ( .A(n6643), .B(\add_x_22_0/carry[16] ), .CO(
        \add_x_22_0/carry[17] ), .S(
        \router/addr_calc/fft_read_calc/counter/N62 ) );
  ADDHXLTS \add_x_22_0/U1_1_15  ( .A(n6645), .B(\add_x_22_0/carry[15] ), .CO(
        \add_x_22_0/carry[16] ), .S(
        \router/addr_calc/fft_read_calc/counter/N61 ) );
  ADDHXLTS \add_x_22_0/U1_1_14  ( .A(\router/addr_calc/fft_read_addr[14] ), 
        .B(\add_x_22_0/carry[14] ), .CO(\add_x_22_0/carry[15] ), .S(
        \router/addr_calc/fft_read_calc/counter/N60 ) );
  ADDHXLTS \add_x_22_0/U1_1_13  ( .A(n6647), .B(\add_x_22_0/carry[13] ), .CO(
        \add_x_22_0/carry[14] ), .S(
        \router/addr_calc/fft_read_calc/counter/N59 ) );
  ADDHXLTS \add_x_22_0/U1_1_12  ( .A(n6649), .B(\add_x_22_0/carry[12] ), .CO(
        \add_x_22_0/carry[13] ), .S(
        \router/addr_calc/fft_read_calc/counter/N58 ) );
  ADDHXLTS \add_x_22_0/U1_1_11  ( .A(n6651), .B(\add_x_22_0/carry[11] ), .CO(
        \add_x_22_0/carry[12] ), .S(
        \router/addr_calc/fft_read_calc/counter/N57 ) );
  ADDHXLTS \add_x_22_0/U1_1_10  ( .A(n6653), .B(\add_x_22_0/carry[10] ), .CO(
        \add_x_22_0/carry[11] ), .S(
        \router/addr_calc/fft_read_calc/counter/N56 ) );
  ADDHXLTS \add_x_22_0/U1_1_9  ( .A(\router/addr_calc/fft_read_addr[9] ), .B(
        \add_x_22_0/carry[9] ), .CO(\add_x_22_0/carry[10] ), .S(
        \router/addr_calc/fft_read_calc/counter/N55 ) );
  ADDHXLTS \add_x_22_0/U1_1_8  ( .A(n6655), .B(\add_x_22_0/carry[8] ), .CO(
        \add_x_22_0/carry[9] ), .S(
        \router/addr_calc/fft_read_calc/counter/N54 ) );
  ADDHXLTS \add_x_22_0/U1_1_7  ( .A(n6657), .B(\add_x_22_0/carry[7] ), .CO(
        \add_x_22_0/carry[8] ), .S(
        \router/addr_calc/fft_read_calc/counter/N53 ) );
  ADDHXLTS \add_x_22_0/U1_1_6  ( .A(n6659), .B(\add_x_22_0/carry[6] ), .CO(
        \add_x_22_0/carry[7] ), .S(
        \router/addr_calc/fft_read_calc/counter/N52 ) );
  ADDHXLTS \add_x_22_0/U1_1_5  ( .A(\router/addr_calc/fft_read_addr[5] ), .B(
        \add_x_22_0/carry[5] ), .CO(\add_x_22_0/carry[6] ), .S(
        \router/addr_calc/fft_read_calc/counter/N51 ) );
  ADDHXLTS \add_x_22_0/U1_1_4  ( .A(n6661), .B(\add_x_22_0/carry[4] ), .CO(
        \add_x_22_0/carry[5] ), .S(
        \router/addr_calc/fft_read_calc/counter/N50 ) );
  ADDHXLTS \add_x_22_0/U1_1_3  ( .A(n6663), .B(\add_x_22_0/carry[3] ), .CO(
        \add_x_22_0/carry[4] ), .S(
        \router/addr_calc/fft_read_calc/counter/N49 ) );
  ADDHXLTS \add_x_22_0/U1_1_2  ( .A(n6665), .B(\add_x_22_0/carry[2] ), .CO(
        \add_x_22_0/carry[3] ), .S(
        \router/addr_calc/fft_read_calc/counter/N48 ) );
  ADDHXLTS \add_x_22_0/U1_1_1  ( .A(n6667), .B(
        \router/addr_calc/fft_read_calc/count[0] ), .CO(\add_x_22_0/carry[2] ), 
        .S(\router/addr_calc/fft_read_calc/counter/N47 ) );
  EDFFXLTS \router/addr_calc/iir_write_calc/counter/count_reg[0]  ( .D(
        \router/addr_calc/iir_write_calc/counter/N178 ), .E(n7241), .CK(clk), 
        .Q(\router/addr_calc/iir_write_calc/count[0] ), .QN(n6731) );
  EDFFXLTS \router/addr_calc/fft_write_calc/counter/count_reg[0]  ( .D(
        \router/addr_calc/fft_write_calc/counter/N178 ), .E(
        \router/addr_calc/fft_write_calc/counter/N212 ), .CK(clk), .Q(
        \router/addr_calc/fft_write_calc/count[0] ), .QN(n6730) );
  EDFFXLTS \router/addr_calc/fft_read_calc/counter/count_reg[0]  ( .D(
        \router/addr_calc/fft_read_calc/counter/N178 ), .E(n7281), .CK(clk), 
        .Q(\router/addr_calc/fft_read_calc/count[0] ), .QN(n6729) );
  EDFFXLTS \router/addr_calc/fir_write_calc/counter/count_reg[0]  ( .D(
        \router/addr_calc/fir_write_calc/counter/N178 ), .E(
        \router/addr_calc/fir_write_calc/counter/N212 ), .CK(clk), .Q(
        \router/addr_calc/fir_write_calc/count[0] ), .QN(n6728) );
  EDFFXLTS \router/addr_calc/fir_read_calc/counter/count_reg[0]  ( .D(
        \router/addr_calc/fir_read_calc/counter/N178 ), .E(n7261), .CK(clk), 
        .Q(\router/addr_calc/fir_read_calc/count[0] ), .QN(n6727) );
  EDFFXLTS \router/addr_calc/iir_write_calc/counter/count_reg[30]  ( .D(
        \router/addr_calc/iir_write_calc/counter/N208 ), .E(n7239), .CK(clk), 
        .Q(\router/addr_calc/iir_write_calc/count[30] ), .QN(n6724) );
  EDFFXLTS \router/addr_calc/iir_write_calc/counter/count_reg[27]  ( .D(
        \router/addr_calc/iir_write_calc/counter/N205 ), .E(n7243), .CK(clk), 
        .Q(\router/addr_calc/iir_write_calc/count[27] ) );
  EDFFXLTS \router/addr_calc/iir_write_calc/counter/count_reg[23]  ( .D(
        \router/addr_calc/iir_write_calc/counter/N201 ), .E(n7238), .CK(clk), 
        .Q(\router/addr_calc/iir_write_calc/count[23] ) );
  EDFFXLTS \router/addr_calc/iir_write_calc/counter/count_reg[18]  ( .D(
        \router/addr_calc/iir_write_calc/counter/N196 ), .E(n7237), .CK(clk), 
        .Q(\router/addr_calc/iir_write_calc/count[18] ) );
  EDFFXLTS \router/addr_calc/iir_write_calc/counter/count_reg[14]  ( .D(
        \router/addr_calc/iir_write_calc/counter/N192 ), .E(n7236), .CK(clk), 
        .Q(\router/addr_calc/iir_write_calc/count[14] ) );
  EDFFXLTS \router/addr_calc/iir_write_calc/counter/count_reg[9]  ( .D(
        \router/addr_calc/iir_write_calc/counter/N187 ), .E(n7235), .CK(clk), 
        .Q(\router/addr_calc/iir_write_calc/count[9] ) );
  EDFFXLTS \router/addr_calc/iir_write_calc/counter/count_reg[5]  ( .D(
        \router/addr_calc/iir_write_calc/counter/N183 ), .E(n7234), .CK(clk), 
        .Q(\router/addr_calc/iir_write_calc/count[5] ) );
  EDFFXLTS \router/addr_calc/fir_write_calc/counter/count_reg[30]  ( .D(
        \router/addr_calc/fir_write_calc/counter/N208 ), .E(n7249), .CK(clk), 
        .Q(\router/addr_calc/fir_write_calc/count[30] ) );
  EDFFXLTS \router/addr_calc/fir_write_calc/counter/count_reg[27]  ( .D(
        \router/addr_calc/fir_write_calc/counter/N205 ), .E(n7248), .CK(clk), 
        .Q(\router/addr_calc/fir_write_calc/count[27] ) );
  EDFFXLTS \router/addr_calc/fir_write_calc/counter/count_reg[23]  ( .D(
        \router/addr_calc/fir_write_calc/counter/N201 ), .E(n7250), .CK(clk), 
        .Q(\router/addr_calc/fir_write_calc/count[23] ) );
  EDFFXLTS \router/addr_calc/fir_write_calc/counter/count_reg[19]  ( .D(
        \router/addr_calc/fir_write_calc/counter/N197 ), .E(n7247), .CK(clk), 
        .Q(\router/addr_calc/fir_write_calc/count[19] ) );
  EDFFXLTS \router/addr_calc/fir_write_calc/counter/count_reg[15]  ( .D(
        \router/addr_calc/fir_write_calc/counter/N193 ), .E(n7246), .CK(clk), 
        .Q(\router/addr_calc/fir_write_calc/count[15] ) );
  EDFFXLTS \router/addr_calc/fir_write_calc/counter/count_reg[9]  ( .D(
        \router/addr_calc/fir_write_calc/counter/N187 ), .E(n7245), .CK(clk), 
        .Q(\router/addr_calc/fir_write_calc/count[9] ) );
  EDFFXLTS \router/addr_calc/fir_write_calc/counter/count_reg[5]  ( .D(
        \router/addr_calc/fir_write_calc/counter/N183 ), .E(n7244), .CK(clk), 
        .Q(\router/addr_calc/fir_write_calc/count[5] ) );
  EDFFXLTS \router/addr_calc/fft_write_calc/counter/count_reg[31]  ( .D(
        \router/addr_calc/fft_write_calc/counter/N209 ), .E(n7269), .CK(clk), 
        .Q(\router/addr_calc/fft_write_calc/count[31] ) );
  EDFFXLTS \router/addr_calc/fft_write_calc/counter/count_reg[28]  ( .D(
        \router/addr_calc/fft_write_calc/counter/N206 ), .E(n7273), .CK(clk), 
        .Q(\router/addr_calc/fft_write_calc/count[28] ) );
  EDFFXLTS \router/addr_calc/fft_write_calc/counter/count_reg[27]  ( .D(
        \router/addr_calc/fft_write_calc/counter/N205 ), .E(n7268), .CK(clk), 
        .Q(\router/addr_calc/fft_write_calc/count[27] ) );
  EDFFXLTS \router/addr_calc/fft_write_calc/counter/count_reg[23]  ( .D(
        \router/addr_calc/fft_write_calc/counter/N201 ), .E(n7270), .CK(clk), 
        .Q(\router/addr_calc/fft_write_calc/count[23] ) );
  EDFFXLTS \router/addr_calc/fft_write_calc/counter/count_reg[19]  ( .D(
        \router/addr_calc/fft_write_calc/counter/N197 ), .E(n7267), .CK(clk), 
        .Q(\router/addr_calc/fft_write_calc/count[19] ) );
  EDFFXLTS \router/addr_calc/fft_write_calc/counter/count_reg[15]  ( .D(
        \router/addr_calc/fft_write_calc/counter/N193 ), .E(n7266), .CK(clk), 
        .Q(\router/addr_calc/fft_write_calc/count[15] ) );
  EDFFXLTS \router/addr_calc/fft_write_calc/counter/count_reg[9]  ( .D(
        \router/addr_calc/fft_write_calc/counter/N187 ), .E(n7265), .CK(clk), 
        .Q(\router/addr_calc/fft_write_calc/count[9] ) );
  EDFFXLTS \router/addr_calc/fft_read_calc/counter/count_reg[30]  ( .D(
        \router/addr_calc/fft_read_calc/counter/N208 ), .E(n7279), .CK(clk), 
        .Q(\router/addr_calc/fft_read_calc/count[30] ) );
  EDFFXLTS \router/addr_calc/fft_read_calc/counter/count_reg[27]  ( .D(
        \router/addr_calc/fft_read_calc/counter/N205 ), .E(n7283), .CK(clk), 
        .Q(\router/addr_calc/fft_read_calc/count[27] ) );
  EDFFXLTS \router/addr_calc/fft_read_calc/counter/count_reg[23]  ( .D(
        \router/addr_calc/fft_read_calc/counter/N201 ), .E(n7278), .CK(clk), 
        .Q(\router/addr_calc/fft_read_calc/count[23] ) );
  EDFFXLTS \router/addr_calc/fft_read_calc/counter/count_reg[18]  ( .D(
        \router/addr_calc/fft_read_calc/counter/N196 ), .E(n7277), .CK(clk), 
        .Q(\router/addr_calc/fft_read_calc/count[18] ) );
  EDFFXLTS \router/addr_calc/fft_read_calc/counter/count_reg[14]  ( .D(
        \router/addr_calc/fft_read_calc/counter/N192 ), .E(n7276), .CK(clk), 
        .Q(\router/addr_calc/fft_read_calc/count[14] ) );
  EDFFXLTS \router/addr_calc/fft_read_calc/counter/count_reg[9]  ( .D(
        \router/addr_calc/fft_read_calc/counter/N187 ), .E(n7275), .CK(clk), 
        .Q(\router/addr_calc/fft_read_calc/count[9] ) );
  EDFFXLTS \router/addr_calc/fft_read_calc/counter/count_reg[5]  ( .D(
        \router/addr_calc/fft_read_calc/counter/N183 ), .E(n7274), .CK(clk), 
        .Q(\router/addr_calc/fft_read_calc/count[5] ) );
  EDFFXLTS \router/addr_calc/fir_read_calc/counter/count_reg[30]  ( .D(
        \router/addr_calc/fir_read_calc/counter/N208 ), .E(n7259), .CK(clk), 
        .Q(\router/addr_calc/fir_read_calc/count[30] ) );
  EDFFXLTS \router/addr_calc/fir_read_calc/counter/count_reg[27]  ( .D(
        \router/addr_calc/fir_read_calc/counter/N205 ), .E(n7263), .CK(clk), 
        .Q(\router/addr_calc/fir_read_calc/count[27] ) );
  EDFFXLTS \router/addr_calc/fir_read_calc/counter/count_reg[23]  ( .D(
        \router/addr_calc/fir_read_calc/counter/N201 ), .E(n7258), .CK(clk), 
        .Q(\router/addr_calc/fir_read_calc/count[23] ) );
  EDFFXLTS \router/addr_calc/fir_read_calc/counter/count_reg[18]  ( .D(
        \router/addr_calc/fir_read_calc/counter/N196 ), .E(n7257), .CK(clk), 
        .Q(\router/addr_calc/fir_read_calc/count[18] ) );
  EDFFXLTS \router/addr_calc/fir_read_calc/counter/count_reg[14]  ( .D(
        \router/addr_calc/fir_read_calc/counter/N192 ), .E(n7256), .CK(clk), 
        .Q(\router/addr_calc/fir_read_calc/count[14] ) );
  EDFFXLTS \router/addr_calc/fir_read_calc/counter/count_reg[9]  ( .D(
        \router/addr_calc/fir_read_calc/counter/N187 ), .E(n7255), .CK(clk), 
        .Q(\router/addr_calc/fir_read_calc/count[9] ) );
  EDFFXLTS \router/addr_calc/fir_read_calc/counter/count_reg[5]  ( .D(
        \router/addr_calc/fir_read_calc/counter/N183 ), .E(n7254), .CK(clk), 
        .Q(\router/addr_calc/fir_read_calc/count[5] ) );
  DFFQX1TS \router/addr_calc/iir_read_calc/counter/count_reg[27]  ( .D(
        \router/addr_calc/iir_read_calc/counter/N205 ), .CK(clk), .Q(
        \router/addr_calc/iir_read_calc/count[27] ) );
  DFFQX1TS \router/addr_calc/iir_read_calc/counter/count_reg[25]  ( .D(
        \router/addr_calc/iir_read_calc/counter/N203 ), .CK(clk), .Q(
        \router/addr_calc/iir_read_calc/count[25] ) );
  DFFQX1TS \router/addr_calc/iir_read_calc/counter/count_reg[23]  ( .D(
        \router/addr_calc/iir_read_calc/counter/N201 ), .CK(clk), .Q(
        \router/addr_calc/iir_read_calc/count[23] ) );
  DFFQX1TS \router/addr_calc/iir_read_calc/counter/count_reg[15]  ( .D(
        \router/addr_calc/iir_read_calc/counter/N193 ), .CK(clk), .Q(
        \router/addr_calc/iir_read_calc/count[15] ) );
  DFFQX1TS \router/addr_calc/iir_read_calc/counter/count_reg[31]  ( .D(
        \router/addr_calc/iir_read_calc/counter/N209 ), .CK(clk), .Q(
        \router/addr_calc/iir_read_calc/count[31] ) );
  DFFQX1TS \router/addr_calc/iir_read_calc/counter/count_reg[30]  ( .D(
        \router/addr_calc/iir_read_calc/counter/N208 ), .CK(clk), .Q(
        \router/addr_calc/iir_read_calc/count[30] ) );
  DFFQX1TS \router/addr_calc/iir_read_calc/counter/count_reg[29]  ( .D(
        \router/addr_calc/iir_read_calc/counter/N207 ), .CK(clk), .Q(
        \router/addr_calc/iir_read_calc/count[29] ) );
  DFFQX1TS \router/addr_calc/iir_read_calc/counter/count_reg[28]  ( .D(
        \router/addr_calc/iir_read_calc/counter/N206 ), .CK(clk), .Q(
        \router/addr_calc/iir_read_calc/count[28] ) );
  DFFQX1TS \router/addr_calc/iir_read_calc/counter/count_reg[26]  ( .D(
        \router/addr_calc/iir_read_calc/counter/N204 ), .CK(clk), .Q(
        \router/addr_calc/iir_read_calc/count[26] ) );
  DFFQX1TS \router/addr_calc/iir_read_calc/counter/count_reg[24]  ( .D(
        \router/addr_calc/iir_read_calc/counter/N202 ), .CK(clk), .Q(
        \router/addr_calc/iir_read_calc/count[24] ) );
  DFFQX1TS \router/addr_calc/iir_read_calc/counter/count_reg[22]  ( .D(
        \router/addr_calc/iir_read_calc/counter/N200 ), .CK(clk), .Q(
        \router/addr_calc/iir_read_calc/count[22] ) );
  DFFQX1TS \router/addr_calc/iir_read_calc/counter/count_reg[0]  ( .D(
        \router/addr_calc/iir_read_calc/counter/N178 ), .CK(clk), .Q(
        \router/addr_calc/iir_read_calc/count[0] ) );
  DFFQX1TS \router/addr_calc/iir_read_calc/counter/count_reg[7]  ( .D(
        \router/addr_calc/iir_read_calc/counter/N185 ), .CK(clk), .Q(
        \router/addr_calc/iir_read_calc/count[7] ) );
  DFFQX1TS \router/addr_calc/iir_read_calc/counter/count_reg[8]  ( .D(
        \router/addr_calc/iir_read_calc/counter/N186 ), .CK(clk), .Q(
        \router/addr_calc/iir_read_calc/count[8] ) );
  DFFQX1TS \router/addr_calc/iir_read_calc/counter/count_reg[6]  ( .D(
        \router/addr_calc/iir_read_calc/counter/N184 ), .CK(clk), .Q(
        \router/addr_calc/iir_read_calc/count[6] ) );
  DFFQX1TS \router/addr_calc/iir_read_calc/counter/count_reg[5]  ( .D(
        \router/addr_calc/iir_read_calc/counter/N183 ), .CK(clk), .Q(
        \router/addr_calc/iir_read_calc/count[5] ) );
  DFFQX1TS \router/addr_calc/iir_read_calc/counter/count_reg[21]  ( .D(
        \router/addr_calc/iir_read_calc/counter/N199 ), .CK(clk), .Q(
        \router/addr_calc/iir_read_calc/count[21] ) );
  DFFQX1TS \router/addr_calc/iir_read_calc/counter/count_reg[20]  ( .D(
        \router/addr_calc/iir_read_calc/counter/N198 ), .CK(clk), .Q(
        \router/addr_calc/iir_read_calc/count[20] ) );
  DFFQX1TS \router/addr_calc/iir_read_calc/counter/count_reg[19]  ( .D(
        \router/addr_calc/iir_read_calc/counter/N197 ), .CK(clk), .Q(
        \router/addr_calc/iir_read_calc/count[19] ) );
  DFFQX1TS \router/addr_calc/iir_read_calc/counter/count_reg[18]  ( .D(
        \router/addr_calc/iir_read_calc/counter/N196 ), .CK(clk), .Q(
        \router/addr_calc/iir_read_calc/count[18] ) );
  DFFQX1TS \router/addr_calc/iir_read_calc/counter/count_reg[17]  ( .D(
        \router/addr_calc/iir_read_calc/counter/N195 ), .CK(clk), .Q(
        \router/addr_calc/iir_read_calc/count[17] ) );
  DFFQX1TS \router/addr_calc/iir_read_calc/counter/count_reg[16]  ( .D(
        \router/addr_calc/iir_read_calc/counter/N194 ), .CK(clk), .Q(
        \router/addr_calc/iir_read_calc/count[16] ) );
  DFFQX1TS \router/addr_calc/iir_read_calc/counter/count_reg[14]  ( .D(
        \router/addr_calc/iir_read_calc/counter/N192 ), .CK(clk), .Q(
        \router/addr_calc/iir_read_calc/count[14] ) );
  DFFQX1TS \router/addr_calc/iir_read_calc/counter/count_reg[13]  ( .D(
        \router/addr_calc/iir_read_calc/counter/N191 ), .CK(clk), .Q(
        \router/addr_calc/iir_read_calc/count[13] ) );
  DFFQX1TS \router/addr_calc/iir_read_calc/counter/count_reg[12]  ( .D(
        \router/addr_calc/iir_read_calc/counter/N190 ), .CK(clk), .Q(
        \router/addr_calc/iir_read_calc/count[12] ) );
  DFFQX1TS \router/addr_calc/iir_read_calc/counter/count_reg[11]  ( .D(
        \router/addr_calc/iir_read_calc/counter/N189 ), .CK(clk), .Q(
        \router/addr_calc/iir_read_calc/count[11] ) );
  DFFQX1TS \router/addr_calc/iir_read_calc/counter/count_reg[10]  ( .D(
        \router/addr_calc/iir_read_calc/counter/N188 ), .CK(clk), .Q(
        \router/addr_calc/iir_read_calc/count[10] ) );
  DFFQX1TS \router/addr_calc/iir_read_calc/counter/count_reg[9]  ( .D(
        \router/addr_calc/iir_read_calc/counter/N187 ), .CK(clk), .Q(
        \router/addr_calc/iir_read_calc/count[9] ) );
  DFFQX1TS \router/addr_calc/iir_read_calc/counter/count_reg[2]  ( .D(
        \router/addr_calc/iir_read_calc/counter/N180 ), .CK(clk), .Q(
        \router/addr_calc/iir_read_calc/count[2] ) );
  DFFQX1TS \router/addr_calc/iir_read_calc/counter/count_reg[4]  ( .D(
        \router/addr_calc/iir_read_calc/counter/N182 ), .CK(clk), .Q(
        \router/addr_calc/iir_read_calc/count[4] ) );
  DFFQX1TS \router/addr_calc/iir_read_calc/counter/count_reg[3]  ( .D(
        \router/addr_calc/iir_read_calc/counter/N181 ), .CK(clk), .Q(
        \router/addr_calc/iir_read_calc/count[3] ) );
  DFFQX1TS \router/addr_calc/iir_read_calc/counter/count_reg[1]  ( .D(
        \router/addr_calc/iir_read_calc/counter/N179 ), .CK(clk), .Q(
        \router/addr_calc/iir_read_calc/count[1] ) );
  DFFQX1TS \fifo_from_fir/fifo_cell12/controller/f_i_get_reg  ( .D(n5780), 
        .CK(clk), .Q(\fifo_from_fir/fifo_cell12/controller/f_i_get ) );
  DFFQX1TS \fifo_from_fir/fifo_cell11/controller/f_i_get_reg  ( .D(n5781), 
        .CK(clk), .Q(\fifo_from_fir/fifo_cell11/controller/f_i_get ) );
  DFFQX1TS \fifo_from_fir/fifo_cell10/controller/f_i_get_reg  ( .D(n5782), 
        .CK(clk), .Q(\fifo_from_fir/fifo_cell10/controller/f_i_get ) );
  DFFQX1TS \fifo_from_fir/fifo_cell7/controller/f_i_get_reg  ( .D(n5785), .CK(
        clk), .Q(\fifo_from_fir/fifo_cell7/controller/f_i_get ) );
  DFFQX1TS \fifo_from_fir/fifo_cell0/controller/f_i_get_reg  ( .D(n5792), .CK(
        clk), .Q(\fifo_from_fir/fifo_cell0/controller/f_i_get ) );
  DFFQX1TS \fifo_from_fft/fifo_cell12/controller/f_i_get_reg  ( .D(n5639), 
        .CK(clk), .Q(\fifo_from_fft/fifo_cell12/controller/f_i_get ) );
  DFFQX1TS \fifo_from_fft/fifo_cell11/controller/f_i_get_reg  ( .D(n5640), 
        .CK(clk), .Q(\fifo_from_fft/fifo_cell11/controller/f_i_get ) );
  DFFQX1TS \fifo_from_fft/fifo_cell10/controller/f_i_get_reg  ( .D(n5641), 
        .CK(clk), .Q(\fifo_from_fft/fifo_cell10/controller/f_i_get ) );
  DFFQX1TS \fifo_from_fft/fifo_cell7/controller/f_i_get_reg  ( .D(n5644), .CK(
        clk), .Q(\fifo_from_fft/fifo_cell7/controller/f_i_get ) );
  DFFQX1TS \fifo_from_fft/fifo_cell0/controller/f_i_get_reg  ( .D(n5651), .CK(
        clk), .Q(\fifo_from_fft/fifo_cell0/controller/f_i_get ) );
  EDFFXLTS \router/addr_calc/iir_write_calc/counter/count_reg[20]  ( .D(
        \router/addr_calc/iir_write_calc/counter/N198 ), .E(n7240), .CK(clk), 
        .Q(n6170), .QN(n6402) );
  EDFFXLTS \router/addr_calc/fft_read_calc/counter/count_reg[29]  ( .D(
        \router/addr_calc/fft_read_calc/counter/N207 ), .E(n7279), .CK(clk), 
        .Q(n6169), .QN(n6622) );
  EDFFXLTS \router/addr_calc/fft_write_calc/counter/count_reg[29]  ( .D(
        \router/addr_calc/fft_write_calc/counter/N207 ), .E(n7269), .CK(clk), 
        .Q(n6168), .QN(n6574) );
  EDFFXLTS \router/addr_calc/fir_read_calc/counter/count_reg[29]  ( .D(
        \router/addr_calc/fir_read_calc/counter/N207 ), .E(n7259), .CK(clk), 
        .Q(n6167), .QN(n6526) );
  EDFFXLTS \router/addr_calc/fir_write_calc/counter/count_reg[29]  ( .D(
        \router/addr_calc/fir_write_calc/counter/N207 ), .E(n7249), .CK(clk), 
        .Q(n6166), .QN(n6470) );
  EDFFXLTS \router/addr_calc/iir_write_calc/counter/count_reg[17]  ( .D(
        \router/addr_calc/iir_write_calc/counter/N195 ), .E(n7237), .CK(clk), 
        .Q(n6165), .QN(n6410) );
  EDFFXLTS \router/addr_calc/iir_write_calc/counter/count_reg[16]  ( .D(
        \router/addr_calc/iir_write_calc/counter/N194 ), .E(n7237), .CK(clk), 
        .Q(n6164), .QN(n6414) );
  EDFFXLTS \router/addr_calc/iir_write_calc/counter/count_reg[13]  ( .D(
        \router/addr_calc/iir_write_calc/counter/N191 ), .E(n7236), .CK(clk), 
        .Q(n6163), .QN(n6422) );
  EDFFXLTS \router/addr_calc/iir_write_calc/counter/count_reg[21]  ( .D(
        \router/addr_calc/iir_write_calc/counter/N199 ), .E(n7240), .CK(clk), 
        .Q(n6162), .QN(n6398) );
  EDFFXLTS \router/addr_calc/iir_write_calc/counter/count_reg[19]  ( .D(
        \router/addr_calc/iir_write_calc/counter/N197 ), .E(n7243), .CK(clk), 
        .Q(n6161), .QN(n6406) );
  EDFFXLTS \router/addr_calc/iir_write_calc/counter/count_reg[15]  ( .D(
        \router/addr_calc/iir_write_calc/counter/N193 ), .E(n7237), .CK(clk), 
        .Q(n6160), .QN(n6418) );
  EDFFXLTS \router/addr_calc/iir_write_calc/counter/count_reg[26]  ( .D(
        \router/addr_calc/iir_write_calc/counter/N204 ), .E(n7238), .CK(clk), 
        .Q(n6159), .QN(n6388) );
  EDFFXLTS \router/addr_calc/iir_write_calc/counter/count_reg[25]  ( .D(
        \router/addr_calc/iir_write_calc/counter/N203 ), .E(n7238), .CK(clk), 
        .Q(n6158), .QN(n6386) );
  EDFFXLTS \router/addr_calc/iir_write_calc/counter/count_reg[4]  ( .D(
        \router/addr_calc/iir_write_calc/counter/N182 ), .E(n7234), .CK(clk), 
        .Q(n6157), .QN(n6450) );
  EDFFXLTS \router/addr_calc/fir_write_calc/counter/count_reg[26]  ( .D(
        \router/addr_calc/fir_write_calc/counter/N204 ), .E(n7248), .CK(clk), 
        .Q(n6156), .QN(n6478) );
  EDFFXLTS \router/addr_calc/fir_read_calc/counter/count_reg[26]  ( .D(
        \router/addr_calc/fir_read_calc/counter/N204 ), .E(n7258), .CK(clk), 
        .Q(n6155), .QN(n6530) );
  EDFFXLTS \router/addr_calc/fft_write_calc/counter/count_reg[26]  ( .D(
        \router/addr_calc/fft_write_calc/counter/N204 ), .E(n7268), .CK(clk), 
        .Q(n6154), .QN(n6576) );
  EDFFXLTS \router/addr_calc/fft_read_calc/counter/count_reg[26]  ( .D(
        \router/addr_calc/fft_read_calc/counter/N204 ), .E(n7278), .CK(clk), 
        .Q(n6153), .QN(n6626) );
  EDFFXLTS \router/addr_calc/iir_write_calc/counter/count_reg[3]  ( .D(
        \router/addr_calc/iir_write_calc/counter/N181 ), .E(n7234), .CK(clk), 
        .Q(n6152), .QN(n6454) );
  EDFFXLTS \router/addr_calc/fir_write_calc/counter/count_reg[31]  ( .D(
        \router/addr_calc/fir_write_calc/counter/N209 ), .E(n7249), .CK(clk), 
        .Q(n6151), .QN(n6466) );
  EDFFXLTS \router/addr_calc/fir_read_calc/counter/count_reg[31]  ( .D(
        \router/addr_calc/fir_read_calc/counter/N209 ), .E(
        \router/addr_calc/fir_read_calc/counter/N212 ), .CK(clk), .Q(n6150), 
        .QN(n6524) );
  EDFFXLTS \router/addr_calc/fft_read_calc/counter/count_reg[31]  ( .D(
        \router/addr_calc/fft_read_calc/counter/N209 ), .E(
        \router/addr_calc/fft_read_calc/counter/N212 ), .CK(clk), .Q(n6149), 
        .QN(n6620) );
  EDFFXLTS \router/addr_calc/iir_write_calc/counter/count_reg[12]  ( .D(
        \router/addr_calc/iir_write_calc/counter/N190 ), .E(n7236), .CK(clk), 
        .Q(n6148), .QN(n6426) );
  EDFFXLTS \router/addr_calc/iir_write_calc/counter/count_reg[10]  ( .D(
        \router/addr_calc/iir_write_calc/counter/N188 ), .E(n7235), .CK(clk), 
        .Q(n6147), .QN(n6434) );
  EDFFXLTS \router/addr_calc/iir_write_calc/counter/count_reg[1]  ( .D(
        \router/addr_calc/iir_write_calc/counter/N179 ), .E(n7242), .CK(clk), 
        .Q(n6146), .QN(n6462) );
  EDFFXLTS \router/addr_calc/iir_write_calc/counter/count_reg[22]  ( .D(
        \router/addr_calc/iir_write_calc/counter/N200 ), .E(n7240), .CK(clk), 
        .Q(n6145), .QN(n6394) );
  EDFFXLTS \router/addr_calc/fft_read_calc/counter/count_reg[28]  ( .D(
        \router/addr_calc/fft_read_calc/counter/N206 ), .E(n7279), .CK(clk), 
        .Q(n6144), .QN(n6624) );
  EDFFXLTS \router/addr_calc/fft_write_calc/counter/count_reg[30]  ( .D(
        \router/addr_calc/fft_write_calc/counter/N208 ), .E(n7269), .CK(clk), 
        .Q(n6143), .QN(n6572) );
  EDFFXLTS \router/addr_calc/iir_write_calc/counter/count_reg[29]  ( .D(
        \router/addr_calc/iir_write_calc/counter/N207 ), .E(n7239), .CK(clk), 
        .Q(n6142), .QN(n6396) );
  EDFFXLTS \router/addr_calc/iir_write_calc/counter/count_reg[28]  ( .D(
        \router/addr_calc/iir_write_calc/counter/N206 ), .E(n7239), .CK(clk), 
        .Q(n6141), .QN(n6392) );
  EDFFXLTS \router/addr_calc/fft_write_calc/counter/count_reg[25]  ( .D(
        \router/addr_calc/fft_write_calc/counter/N203 ), .E(n7268), .CK(clk), 
        .Q(n6140), .QN(n6578) );
  EDFFXLTS \router/addr_calc/fir_read_calc/counter/count_reg[25]  ( .D(
        \router/addr_calc/fir_read_calc/counter/N203 ), .E(n7258), .CK(clk), 
        .Q(n6139), .QN(n6532) );
  EDFFXLTS \router/addr_calc/fir_write_calc/counter/count_reg[25]  ( .D(
        \router/addr_calc/fir_write_calc/counter/N203 ), .E(n7248), .CK(clk), 
        .Q(n6138), .QN(n6482) );
  EDFFXLTS \router/addr_calc/iir_write_calc/counter/count_reg[31]  ( .D(
        \router/addr_calc/iir_write_calc/counter/N209 ), .E(
        \router/addr_calc/iir_write_calc/counter/N212 ), .CK(clk), .Q(n6137), 
        .QN(n6400) );
  EDFFXLTS \router/addr_calc/fft_read_calc/counter/count_reg[16]  ( .D(
        \router/addr_calc/fft_read_calc/counter/N194 ), .E(n7277), .CK(clk), 
        .Q(n6136), .QN(n6642) );
  EDFFXLTS \router/addr_calc/fft_write_calc/counter/count_reg[18]  ( .D(
        \router/addr_calc/fft_write_calc/counter/N196 ), .E(n7267), .CK(clk), 
        .Q(n6135), .QN(n6588) );
  EDFFXLTS \router/addr_calc/fir_read_calc/counter/count_reg[16]  ( .D(
        \router/addr_calc/fir_read_calc/counter/N194 ), .E(n7257), .CK(clk), 
        .Q(n6134), .QN(n6546) );
  EDFFXLTS \router/addr_calc/fir_write_calc/counter/count_reg[18]  ( .D(
        \router/addr_calc/fir_write_calc/counter/N196 ), .E(n7247), .CK(clk), 
        .Q(n6133), .QN(n6494) );
  EDFFXLTS \router/addr_calc/fft_read_calc/counter/count_reg[19]  ( .D(
        \router/addr_calc/fft_read_calc/counter/N197 ), .E(n7283), .CK(clk), 
        .Q(n6132), .QN(n6638) );
  EDFFXLTS \router/addr_calc/fir_read_calc/counter/count_reg[19]  ( .D(
        \router/addr_calc/fir_read_calc/counter/N197 ), .E(n7263), .CK(clk), 
        .Q(n6131), .QN(n6542) );
  EDFFXLTS \router/addr_calc/iir_write_calc/counter/count_reg[8]  ( .D(
        \router/addr_calc/iir_write_calc/counter/N186 ), .E(n7235), .CK(clk), 
        .Q(n6130), .QN(n6438) );
  EDFFXLTS \router/addr_calc/fft_write_calc/counter/count_reg[22]  ( .D(
        \router/addr_calc/fft_write_calc/counter/N200 ), .E(n7270), .CK(clk), 
        .Q(n6129), .QN(n6582) );
  EDFFXLTS \router/addr_calc/fir_read_calc/counter/count_reg[22]  ( .D(
        \router/addr_calc/fir_read_calc/counter/N200 ), .E(n7260), .CK(clk), 
        .Q(n6128), .QN(n6536) );
  EDFFXLTS \router/addr_calc/fft_read_calc/counter/count_reg[22]  ( .D(
        \router/addr_calc/fft_read_calc/counter/N200 ), .E(n7280), .CK(clk), 
        .Q(n6127), .QN(n6632) );
  EDFFXLTS \router/addr_calc/fir_write_calc/counter/count_reg[22]  ( .D(
        \router/addr_calc/fir_write_calc/counter/N200 ), .E(n7250), .CK(clk), 
        .Q(n6126), .QN(n6488) );
  EDFFXLTS \router/addr_calc/fft_write_calc/counter/count_reg[14]  ( .D(
        \router/addr_calc/fft_write_calc/counter/N192 ), .E(n7266), .CK(clk), 
        .Q(n6125), .QN(n6594) );
  EDFFXLTS \router/addr_calc/fir_write_calc/counter/count_reg[14]  ( .D(
        \router/addr_calc/fir_write_calc/counter/N192 ), .E(n7246), .CK(clk), 
        .Q(n6124), .QN(n6500) );
  EDFFXLTS \router/addr_calc/fft_read_calc/counter/count_reg[20]  ( .D(
        \router/addr_calc/fft_read_calc/counter/N198 ), .E(n7280), .CK(clk), 
        .Q(n6123), .QN(n6636) );
  EDFFXLTS \router/addr_calc/fft_write_calc/counter/count_reg[20]  ( .D(
        \router/addr_calc/fft_write_calc/counter/N198 ), .E(n7273), .CK(clk), 
        .Q(n6122), .QN(n6586) );
  EDFFXLTS \router/addr_calc/fir_write_calc/counter/count_reg[20]  ( .D(
        \router/addr_calc/fir_write_calc/counter/N198 ), .E(n7253), .CK(clk), 
        .Q(n6121), .QN(n6492) );
  EDFFXLTS \router/addr_calc/fft_read_calc/counter/count_reg[11]  ( .D(
        \router/addr_calc/fft_read_calc/counter/N189 ), .E(n7276), .CK(clk), 
        .Q(n6120), .QN(n6650) );
  EDFFXLTS \router/addr_calc/fft_write_calc/counter/count_reg[11]  ( .D(
        \router/addr_calc/fft_write_calc/counter/N189 ), .E(n7265), .CK(clk), 
        .Q(n6119), .QN(n6600) );
  EDFFXLTS \router/addr_calc/fir_read_calc/counter/count_reg[11]  ( .D(
        \router/addr_calc/fir_read_calc/counter/N189 ), .E(n7256), .CK(clk), 
        .Q(n6118), .QN(n6554) );
  EDFFXLTS \router/addr_calc/fir_write_calc/counter/count_reg[11]  ( .D(
        \router/addr_calc/fir_write_calc/counter/N189 ), .E(n7245), .CK(clk), 
        .Q(n6117), .QN(n6506) );
  EDFFXLTS \router/addr_calc/iir_write_calc/counter/count_reg[2]  ( .D(
        \router/addr_calc/iir_write_calc/counter/N180 ), .E(n7242), .CK(clk), 
        .Q(n6116), .QN(n6458) );
  EDFFXLTS \router/addr_calc/iir_write_calc/counter/count_reg[6]  ( .D(
        \router/addr_calc/iir_write_calc/counter/N184 ), .E(n7234), .CK(clk), 
        .Q(n6115), .QN(n6446) );
  EDFFXLTS \router/addr_calc/fft_write_calc/counter/count_reg[10]  ( .D(
        \router/addr_calc/fft_write_calc/counter/N188 ), .E(n7265), .CK(clk), 
        .Q(n6114), .QN(n6602) );
  EDFFXLTS \router/addr_calc/fft_write_calc/counter/count_reg[5]  ( .D(
        \router/addr_calc/fft_write_calc/counter/N183 ), .E(n7264), .CK(clk), 
        .Q(n6113), .QN(n6610) );
  EDFFXLTS \router/addr_calc/fir_read_calc/counter/count_reg[10]  ( .D(
        \router/addr_calc/fir_read_calc/counter/N188 ), .E(n7255), .CK(clk), 
        .Q(n6112), .QN(n6556) );
  EDFFXLTS \router/addr_calc/fir_read_calc/counter/count_reg[4]  ( .D(
        \router/addr_calc/fir_read_calc/counter/N182 ), .E(n7254), .CK(clk), 
        .Q(n6111), .QN(n6564) );
  EDFFXLTS \router/addr_calc/fir_write_calc/counter/count_reg[10]  ( .D(
        \router/addr_calc/fir_write_calc/counter/N188 ), .E(n7245), .CK(clk), 
        .Q(n6110), .QN(n6508) );
  EDFFXLTS \router/addr_calc/fir_write_calc/counter/count_reg[4]  ( .D(
        \router/addr_calc/fir_write_calc/counter/N182 ), .E(n7244), .CK(clk), 
        .Q(n6109), .QN(n6516) );
  EDFFXLTS \router/addr_calc/fft_read_calc/counter/count_reg[6]  ( .D(
        \router/addr_calc/fft_read_calc/counter/N184 ), .E(n7274), .CK(clk), 
        .Q(n6108), .QN(n6658) );
  EDFFXLTS \router/addr_calc/fft_read_calc/counter/count_reg[2]  ( .D(
        \router/addr_calc/fft_read_calc/counter/N180 ), .E(n7282), .CK(clk), 
        .Q(n6107), .QN(n6664) );
  EDFFXLTS \router/addr_calc/fft_write_calc/counter/count_reg[6]  ( .D(
        \router/addr_calc/fft_write_calc/counter/N184 ), .E(n7264), .CK(clk), 
        .Q(n6106), .QN(n6608) );
  EDFFXLTS \router/addr_calc/fft_write_calc/counter/count_reg[2]  ( .D(
        \router/addr_calc/fft_write_calc/counter/N180 ), .E(n7272), .CK(clk), 
        .Q(n6105), .QN(n6616) );
  EDFFXLTS \router/addr_calc/fir_read_calc/counter/count_reg[6]  ( .D(
        \router/addr_calc/fir_read_calc/counter/N184 ), .E(n7254), .CK(clk), 
        .Q(n6104), .QN(n6562) );
  EDFFXLTS \router/addr_calc/fir_read_calc/counter/count_reg[2]  ( .D(
        \router/addr_calc/fir_read_calc/counter/N180 ), .E(n7262), .CK(clk), 
        .Q(n6103), .QN(n6568) );
  EDFFXLTS \router/addr_calc/fir_write_calc/counter/count_reg[6]  ( .D(
        \router/addr_calc/fir_write_calc/counter/N184 ), .E(n7244), .CK(clk), 
        .Q(n6102), .QN(n6514) );
  EDFFXLTS \router/addr_calc/fir_write_calc/counter/count_reg[2]  ( .D(
        \router/addr_calc/fir_write_calc/counter/N180 ), .E(n7252), .CK(clk), 
        .Q(n6101), .QN(n6520) );
  EDFFXLTS \router/addr_calc/fft_write_calc/counter/count_reg[13]  ( .D(
        \router/addr_calc/fft_write_calc/counter/N191 ), .E(n7266), .CK(clk), 
        .Q(n6100), .QN(n6596) );
  EDFFXLTS \router/addr_calc/fir_write_calc/counter/count_reg[13]  ( .D(
        \router/addr_calc/fir_write_calc/counter/N191 ), .E(n7246), .CK(clk), 
        .Q(n6099), .QN(n6502) );
  EDFFXLTS \router/addr_calc/iir_write_calc/counter/count_reg[24]  ( .D(
        \router/addr_calc/iir_write_calc/counter/N202 ), .E(n7238), .CK(clk), 
        .Q(n6098), .QN(n6390) );
  EDFFXLTS \router/addr_calc/fir_read_calc/counter/count_reg[28]  ( .D(
        \router/addr_calc/fir_read_calc/counter/N206 ), .E(n7259), .CK(clk), 
        .Q(n6097), .QN(n6528) );
  EDFFXLTS \router/addr_calc/fir_write_calc/counter/count_reg[28]  ( .D(
        \router/addr_calc/fir_write_calc/counter/N206 ), .E(n7253), .CK(clk), 
        .Q(n6096), .QN(n6474) );
  EDFFXLTS \router/addr_calc/fft_read_calc/counter/count_reg[25]  ( .D(
        \router/addr_calc/fft_read_calc/counter/N203 ), .E(n7278), .CK(clk), 
        .Q(n6095), .QN(n6628) );
  EDFFXLTS \router/addr_calc/fft_write_calc/counter/count_reg[24]  ( .D(
        \router/addr_calc/fft_write_calc/counter/N202 ), .E(n7268), .CK(clk), 
        .Q(n6094), .QN(n6580) );
  EDFFXLTS \router/addr_calc/fir_read_calc/counter/count_reg[24]  ( .D(
        \router/addr_calc/fir_read_calc/counter/N202 ), .E(n7258), .CK(clk), 
        .Q(n6093), .QN(n6534) );
  EDFFXLTS \router/addr_calc/fir_write_calc/counter/count_reg[24]  ( .D(
        \router/addr_calc/fir_write_calc/counter/N202 ), .E(n7248), .CK(clk), 
        .Q(n6092), .QN(n6486) );
  EDFFXLTS \router/addr_calc/fir_read_calc/counter/count_reg[20]  ( .D(
        \router/addr_calc/fir_read_calc/counter/N198 ), .E(n7260), .CK(clk), 
        .Q(n6091), .QN(n6540) );
  EDFFXLTS \router/addr_calc/fft_write_calc/counter/count_reg[16]  ( .D(
        \router/addr_calc/fft_write_calc/counter/N194 ), .E(n7267), .CK(clk), 
        .Q(n6090), .QN(n6592) );
  EDFFXLTS \router/addr_calc/fir_write_calc/counter/count_reg[16]  ( .D(
        \router/addr_calc/fir_write_calc/counter/N194 ), .E(n7247), .CK(clk), 
        .Q(n6089), .QN(n6498) );
  EDFFXLTS \router/addr_calc/fft_read_calc/counter/count_reg[17]  ( .D(
        \router/addr_calc/fft_read_calc/counter/N195 ), .E(n7277), .CK(clk), 
        .Q(n6088), .QN(n6640) );
  EDFFXLTS \router/addr_calc/fft_read_calc/counter/count_reg[15]  ( .D(
        \router/addr_calc/fft_read_calc/counter/N193 ), .E(n7277), .CK(clk), 
        .Q(n6087), .QN(n6644) );
  EDFFXLTS \router/addr_calc/fft_write_calc/counter/count_reg[17]  ( .D(
        \router/addr_calc/fft_write_calc/counter/N195 ), .E(n7267), .CK(clk), 
        .Q(n6086), .QN(n6590) );
  EDFFXLTS \router/addr_calc/fir_read_calc/counter/count_reg[17]  ( .D(
        \router/addr_calc/fir_read_calc/counter/N195 ), .E(n7257), .CK(clk), 
        .Q(n6085), .QN(n6544) );
  EDFFXLTS \router/addr_calc/fir_read_calc/counter/count_reg[15]  ( .D(
        \router/addr_calc/fir_read_calc/counter/N193 ), .E(n7257), .CK(clk), 
        .Q(n6084), .QN(n6548) );
  EDFFXLTS \router/addr_calc/fir_write_calc/counter/count_reg[17]  ( .D(
        \router/addr_calc/fir_write_calc/counter/N195 ), .E(n7247), .CK(clk), 
        .Q(n6083), .QN(n6496) );
  EDFFXLTS \router/addr_calc/iir_write_calc/counter/count_reg[11]  ( .D(
        \router/addr_calc/iir_write_calc/counter/N189 ), .E(n7236), .CK(clk), 
        .Q(n6082), .QN(n6430) );
  EDFFXLTS \router/addr_calc/iir_write_calc/counter/count_reg[7]  ( .D(
        \router/addr_calc/iir_write_calc/counter/N185 ), .E(n7235), .CK(clk), 
        .Q(n6081), .QN(n6442) );
  EDFFXLTS \router/addr_calc/fft_read_calc/counter/count_reg[21]  ( .D(
        \router/addr_calc/fft_read_calc/counter/N199 ), .E(n7280), .CK(clk), 
        .Q(n6080), .QN(n6634) );
  EDFFXLTS \router/addr_calc/fft_write_calc/counter/count_reg[21]  ( .D(
        \router/addr_calc/fft_write_calc/counter/N199 ), .E(n7270), .CK(clk), 
        .Q(n6079), .QN(n6584) );
  EDFFXLTS \router/addr_calc/fir_write_calc/counter/count_reg[21]  ( .D(
        \router/addr_calc/fir_write_calc/counter/N199 ), .E(n7250), .CK(clk), 
        .Q(n6078), .QN(n6490) );
  EDFFXLTS \router/addr_calc/fft_read_calc/counter/count_reg[10]  ( .D(
        \router/addr_calc/fft_read_calc/counter/N188 ), .E(n7275), .CK(clk), 
        .Q(n6077), .QN(n6652) );
  EDFFXLTS \router/addr_calc/fft_read_calc/counter/count_reg[4]  ( .D(
        \router/addr_calc/fft_read_calc/counter/N182 ), .E(n7274), .CK(clk), 
        .Q(n6076), .QN(n6660) );
  EDFFXLTS \router/addr_calc/fft_write_calc/counter/count_reg[4]  ( .D(
        \router/addr_calc/fft_write_calc/counter/N182 ), .E(n7264), .CK(clk), 
        .Q(n6075), .QN(n6612) );
  EDFFXLTS \router/addr_calc/fft_write_calc/counter/count_reg[12]  ( .D(
        \router/addr_calc/fft_write_calc/counter/N190 ), .E(n7266), .CK(clk), 
        .Q(n6074), .QN(n6598) );
  EDFFXLTS \router/addr_calc/fir_read_calc/counter/count_reg[12]  ( .D(
        \router/addr_calc/fir_read_calc/counter/N190 ), .E(n7256), .CK(clk), 
        .Q(n6073), .QN(n6552) );
  EDFFXLTS \router/addr_calc/fir_write_calc/counter/count_reg[12]  ( .D(
        \router/addr_calc/fir_write_calc/counter/N190 ), .E(n7246), .CK(clk), 
        .Q(n6072), .QN(n6504) );
  EDFFXLTS \router/addr_calc/fir_read_calc/counter/count_reg[13]  ( .D(
        \router/addr_calc/fir_read_calc/counter/N191 ), .E(n7256), .CK(clk), 
        .Q(n6071), .QN(n6550) );
  EDFFXLTS \router/addr_calc/fft_read_calc/counter/count_reg[8]  ( .D(
        \router/addr_calc/fft_read_calc/counter/N186 ), .E(n7275), .CK(clk), 
        .Q(n6070), .QN(n6654) );
  EDFFXLTS \router/addr_calc/fft_write_calc/counter/count_reg[8]  ( .D(
        \router/addr_calc/fft_write_calc/counter/N186 ), .E(n7265), .CK(clk), 
        .Q(n6069), .QN(n6604) );
  EDFFXLTS \router/addr_calc/fir_read_calc/counter/count_reg[8]  ( .D(
        \router/addr_calc/fir_read_calc/counter/N186 ), .E(n7255), .CK(clk), 
        .Q(n6068), .QN(n6558) );
  EDFFXLTS \router/addr_calc/fir_read_calc/counter/count_reg[3]  ( .D(
        \router/addr_calc/fir_read_calc/counter/N181 ), .E(n7254), .CK(clk), 
        .Q(n6067), .QN(n6566) );
  EDFFXLTS \router/addr_calc/fir_write_calc/counter/count_reg[8]  ( .D(
        \router/addr_calc/fir_write_calc/counter/N186 ), .E(n7245), .CK(clk), 
        .Q(n6066), .QN(n6510) );
  EDFFXLTS \router/addr_calc/fir_write_calc/counter/count_reg[3]  ( .D(
        \router/addr_calc/fir_write_calc/counter/N181 ), .E(n7252), .CK(clk), 
        .Q(n6065), .QN(n6518) );
  EDFFXLTS \router/addr_calc/fft_read_calc/counter/count_reg[24]  ( .D(
        \router/addr_calc/fft_read_calc/counter/N202 ), .E(n7278), .CK(clk), 
        .Q(n6064), .QN(n6630) );
  EDFFXLTS \router/addr_calc/fir_read_calc/counter/count_reg[21]  ( .D(
        \router/addr_calc/fir_read_calc/counter/N199 ), .E(n7260), .CK(clk), 
        .Q(n6063), .QN(n6538) );
  EDFFXLTS \router/addr_calc/fft_read_calc/counter/count_reg[1]  ( .D(
        \router/addr_calc/fft_read_calc/counter/N179 ), .E(n7282), .CK(clk), 
        .Q(n6062), .QN(n6666) );
  EDFFXLTS \router/addr_calc/fir_read_calc/counter/count_reg[1]  ( .D(
        \router/addr_calc/fir_read_calc/counter/N179 ), .E(n7262), .CK(clk), 
        .Q(n6061), .QN(n6570) );
  EDFFXLTS \router/addr_calc/fft_read_calc/counter/count_reg[12]  ( .D(
        \router/addr_calc/fft_read_calc/counter/N190 ), .E(n7276), .CK(clk), 
        .Q(n6060), .QN(n6648) );
  EDFFXLTS \router/addr_calc/fft_read_calc/counter/count_reg[13]  ( .D(
        \router/addr_calc/fft_read_calc/counter/N191 ), .E(n7276), .CK(clk), 
        .Q(n6059), .QN(n6646) );
  EDFFXLTS \router/addr_calc/fft_read_calc/counter/count_reg[7]  ( .D(
        \router/addr_calc/fft_read_calc/counter/N185 ), .E(n7275), .CK(clk), 
        .Q(n6058), .QN(n6656) );
  EDFFXLTS \router/addr_calc/fft_read_calc/counter/count_reg[3]  ( .D(
        \router/addr_calc/fft_read_calc/counter/N181 ), .E(n7274), .CK(clk), 
        .Q(n6057), .QN(n6662) );
  EDFFXLTS \router/addr_calc/fft_write_calc/counter/count_reg[7]  ( .D(
        \router/addr_calc/fft_write_calc/counter/N185 ), .E(n7264), .CK(clk), 
        .Q(n6056), .QN(n6606) );
  EDFFXLTS \router/addr_calc/fft_write_calc/counter/count_reg[3]  ( .D(
        \router/addr_calc/fft_write_calc/counter/N181 ), .E(n7272), .CK(clk), 
        .Q(n6055), .QN(n6614) );
  EDFFXLTS \router/addr_calc/fir_read_calc/counter/count_reg[7]  ( .D(
        \router/addr_calc/fir_read_calc/counter/N185 ), .E(n7255), .CK(clk), 
        .Q(n6054), .QN(n6560) );
  EDFFXLTS \router/addr_calc/fir_write_calc/counter/count_reg[7]  ( .D(
        \router/addr_calc/fir_write_calc/counter/N185 ), .E(n7244), .CK(clk), 
        .Q(n6053), .QN(n6512) );
  EDFFXLTS \router/addr_calc/fft_write_calc/counter/count_reg[1]  ( .D(
        \router/addr_calc/fft_write_calc/counter/N179 ), .E(n7271), .CK(clk), 
        .Q(n6052), .QN(n6618) );
  EDFFXLTS \router/addr_calc/fir_write_calc/counter/count_reg[1]  ( .D(
        \router/addr_calc/fir_write_calc/counter/N179 ), .E(n7251), .CK(clk), 
        .Q(n6051), .QN(n6522) );
  INVX2TS U3268 ( .A(1'b1), .Y(acc_fir_put) );
  INVX2TS U3270 ( .A(1'b1), .Y(acc_fir_get) );
  INVX2TS U3272 ( .A(1'b1), .Y(acc_fft_put) );
  INVX2TS U3274 ( .A(1'b1), .Y(acc_fft_get) );
  CLKBUFX2TS U3276 ( .A(n7337), .Y(n7336) );
  CLKBUFX2TS U3277 ( .A(n7895), .Y(n7030) );
  CLKBUFX2TS U3278 ( .A(n6893), .Y(n7068) );
  NOR2X1TS U3279 ( .A(n7519), .B(instruction[2]), .Y(n7522) );
  CLKBUFX2TS U3280 ( .A(n7451), .Y(n7453) );
  NAND2X1TS U3281 ( .A(\router/data_cntl/fir_full_flag ), .B(n7907), .Y(n7542)
         );
  NOR2X1TS U3282 ( .A(n7607), .B(n7606), .Y(n7543) );
  CLKBUFX2TS U3283 ( .A(n7455), .Y(n7452) );
  CLKBUFX2TS U3284 ( .A(n6921), .Y(n6920) );
  CLKBUFX2TS U3285 ( .A(n7654), .Y(n6921) );
  CLKBUFX2TS U3286 ( .A(n7068), .Y(n7061) );
  INVX2TS U3287 ( .A(n7061), .Y(n7060) );
  AND2X2TS U3288 ( .A(n7397), .B(n7047), .Y(n6745) );
  OR2X2TS U3289 ( .A(n7448), .B(n7070), .Y(n6740) );
  OR2X2TS U3290 ( .A(n7443), .B(n7080), .Y(n6735) );
  CLKBUFX2TS U3291 ( .A(n7389), .Y(n7387) );
  CLKBUFX2TS U3292 ( .A(n7389), .Y(n7386) );
  CLKBUFX2TS U3293 ( .A(n7386), .Y(n7384) );
  CLKBUFX2TS U3294 ( .A(n7336), .Y(n7332) );
  AND4X1TS U3295 ( .A(\fifo_from_fft/fifo_cell6/controller/f_i_get ), .B(
        \fifo_from_fft/fifo_cell4/controller/f_i_get ), .C(
        \fifo_from_fft/fifo_cell5/controller/f_i_get ), .D(
        \fifo_from_fft/fifo_cell2/controller/f_i_get ), .Y(n7516) );
  NOR4XLTS U3296 ( .A(\fifo_from_fft/hold[0] ), .B(\fifo_from_fft/hold[10] ), 
        .C(\fifo_from_fft/hold[11] ), .D(\fifo_from_fft/hold[12] ), .Y(n7514)
         );
  NOR4XLTS U3297 ( .A(\fifo_from_fft/hold[13] ), .B(\fifo_from_fft/hold[14] ), 
        .C(\fifo_from_fft/hold[15] ), .D(\fifo_from_fft/hold[1] ), .Y(n7513)
         );
  NOR4XLTS U3298 ( .A(\fifo_from_fft/hold[2] ), .B(\fifo_from_fft/hold[3] ), 
        .C(\fifo_from_fft/hold[4] ), .D(\fifo_from_fft/hold[5] ), .Y(n7512) );
  NOR4XLTS U3299 ( .A(\fifo_from_fft/hold[6] ), .B(\fifo_from_fft/hold[7] ), 
        .C(\fifo_from_fft/hold[8] ), .D(\fifo_from_fft/hold[9] ), .Y(n7511) );
  CLKBUFX2TS U3300 ( .A(n7459), .Y(n7454) );
  CLKBUFX2TS U3301 ( .A(n7763), .Y(n6971) );
  CLKBUFX2TS U3302 ( .A(n7719), .Y(n6951) );
  CLKBUFX2TS U3303 ( .A(n7851), .Y(n7011) );
  CLKBUFX2TS U3304 ( .A(n7807), .Y(n6991) );
  ADDHXLTS U3305 ( .A(n6096), .B(\add_x_22_3/carry[28] ), .CO(
        \add_x_22_3/carry[29] ), .S(
        \router/addr_calc/fir_write_calc/counter/N74 ) );
  CLKBUFX2TS U3306 ( .A(n7010), .Y(n7009) );
  ADDHXLTS U3307 ( .A(n6097), .B(\add_x_22_2/carry[28] ), .CO(
        \add_x_22_2/carry[29] ), .S(
        \router/addr_calc/fir_read_calc/counter/N74 ) );
  CLKBUFX2TS U3308 ( .A(n6990), .Y(n6989) );
  CLKBUFX2TS U3309 ( .A(n7021), .Y(n7018) );
  INVX2TS U3310 ( .A(n7385), .Y(n7377) );
  CLKBUFX2TS U3311 ( .A(n6959), .Y(n6953) );
  INVX2TS U3312 ( .A(n7382), .Y(n7369) );
  CLKBUFX2TS U3313 ( .A(n6989), .Y(n6983) );
  INVX2TS U3314 ( .A(n7357), .Y(n7349) );
  CLKBUFX2TS U3315 ( .A(n6949), .Y(n6943) );
  ADDHXLTS U3316 ( .A(n6141), .B(\add_x_22_5/carry[28] ), .CO(
        \add_x_22_5/carry[29] ), .S(
        \router/addr_calc/iir_write_calc/counter/N74 ) );
  ADDHXLTS U3317 ( .A(n6142), .B(\add_x_22_5/carry[29] ), .CO(
        \add_x_22_5/carry[30] ), .S(
        \router/addr_calc/iir_write_calc/counter/N75 ) );
  ADDHXLTS U3318 ( .A(n6144), .B(\add_x_22_0/carry[28] ), .CO(
        \add_x_22_0/carry[29] ), .S(
        \router/addr_calc/fft_read_calc/counter/N74 ) );
  CLKBUFX2TS U3319 ( .A(n6950), .Y(n6949) );
  CLKBUFX2TS U3320 ( .A(n6941), .Y(n6938) );
  CLKBUFX2TS U3321 ( .A(n6981), .Y(n6978) );
  CLKBUFX2TS U3322 ( .A(n7001), .Y(n6998) );
  CLKBUFX2TS U3323 ( .A(n7010), .Y(n7005) );
  CLKBUFX2TS U3324 ( .A(n7895), .Y(n7031) );
  INVX2TS U3325 ( .A(n7332), .Y(n7321) );
  NAND2X1TS U3326 ( .A(\router/data_from_fir ), .B(
        \router/addr_calc/fir_write_calc/counter/N40 ), .Y(n7851) );
  ADDHXLTS U3327 ( .A(n6166), .B(\add_x_22_3/carry[29] ), .CO(
        \add_x_22_3/carry[30] ), .S(
        \router/addr_calc/fir_write_calc/counter/N75 ) );
  NAND2X1TS U3328 ( .A(\router/addr_calc/fir_read_calc/counter/N40 ), .B(n6898), .Y(n7807) );
  ADDHXLTS U3329 ( .A(n6167), .B(\add_x_22_2/carry[29] ), .CO(
        \add_x_22_2/carry[30] ), .S(
        \router/addr_calc/fir_read_calc/counter/N75 ) );
  NAND2X1TS U3330 ( .A(\router/data_from_fft ), .B(
        \router/addr_calc/fft_write_calc/counter/N40 ), .Y(n7763) );
  NAND2X1TS U3331 ( .A(\router/data_to_fft ), .B(
        \router/addr_calc/fft_read_calc/counter/N40 ), .Y(n7719) );
  ADDHXLTS U3332 ( .A(n6169), .B(\add_x_22_0/carry[29] ), .CO(
        \add_x_22_0/carry[30] ), .S(
        \router/addr_calc/fft_read_calc/counter/N75 ) );
  CLKBUFX2TS U3333 ( .A(n7030), .Y(n7023) );
  INVX2TS U3334 ( .A(n7334), .Y(n7328) );
  CLKBUFX2TS U3335 ( .A(n6979), .Y(n6973) );
  CLKBUFX2TS U3336 ( .A(n6979), .Y(n6974) );
  CLKBUFX2TS U3337 ( .A(n6991), .Y(n6986) );
  CLKBUFX2TS U3338 ( .A(n6979), .Y(n6975) );
  CLKBUFX2TS U3339 ( .A(n6990), .Y(n6985) );
  CLKBUFX2TS U3340 ( .A(n6989), .Y(n6984) );
  INVX2TS U3341 ( .A(n7357), .Y(n7350) );
  CLKBUFX2TS U3342 ( .A(n7806), .Y(n6976) );
  CLKBUFX2TS U3343 ( .A(n6989), .Y(n6982) );
  INVX2TS U3344 ( .A(n7356), .Y(n7348) );
  CLKBUFX2TS U3345 ( .A(n6978), .Y(n6977) );
  CLKBUFX2TS U3346 ( .A(n7806), .Y(n6981) );
  CLKBUFX2TS U3347 ( .A(n7807), .Y(n6990) );
  INVX2TS U3348 ( .A(n7356), .Y(n7347) );
  CLKBUFX2TS U3349 ( .A(n6939), .Y(n6933) );
  CLKBUFX2TS U3350 ( .A(n6939), .Y(n6934) );
  CLKBUFX2TS U3351 ( .A(n6951), .Y(n6946) );
  CLKBUFX2TS U3352 ( .A(n6939), .Y(n6935) );
  CLKBUFX2TS U3353 ( .A(n6950), .Y(n6945) );
  CLKBUFX2TS U3354 ( .A(n6949), .Y(n6944) );
  CLKBUFX2TS U3355 ( .A(n7718), .Y(n6936) );
  CLKBUFX2TS U3356 ( .A(n6949), .Y(n6942) );
  CLKBUFX2TS U3357 ( .A(n6938), .Y(n6937) );
  CLKBUFX2TS U3358 ( .A(n7718), .Y(n6941) );
  CLKBUFX2TS U3359 ( .A(n7719), .Y(n6950) );
  CLKBUFX2TS U3360 ( .A(n6959), .Y(n6954) );
  CLKBUFX2TS U3361 ( .A(n6971), .Y(n6966) );
  INVX2TS U3362 ( .A(n7382), .Y(n7368) );
  CLKBUFX2TS U3363 ( .A(n6959), .Y(n6955) );
  CLKBUFX2TS U3364 ( .A(n6969), .Y(n6964) );
  INVX2TS U3365 ( .A(n7381), .Y(n7367) );
  CLKBUFX2TS U3366 ( .A(n6969), .Y(n6963) );
  INVX2TS U3367 ( .A(n7381), .Y(n7366) );
  CLKBUFX2TS U3368 ( .A(n7762), .Y(n6956) );
  CLKBUFX2TS U3369 ( .A(n6969), .Y(n6962) );
  INVX2TS U3370 ( .A(n7380), .Y(n7365) );
  CLKBUFX2TS U3371 ( .A(n6958), .Y(n6957) );
  CLKBUFX2TS U3372 ( .A(n7763), .Y(n6970) );
  CLKBUFX2TS U3373 ( .A(n7762), .Y(n6961) );
  CLKBUFX2TS U3374 ( .A(n6970), .Y(n6969) );
  INVX2TS U3375 ( .A(n7380), .Y(n7364) );
  ADDHXLTS U3376 ( .A(n6143), .B(\add_x_22_1/carry[30] ), .CO(
        \add_x_22_1/carry[31] ), .S(
        \router/addr_calc/fft_write_calc/counter/N76 ) );
  CLKBUFX2TS U3377 ( .A(n6961), .Y(n6958) );
  CLKBUFX2TS U3378 ( .A(n6970), .Y(n6965) );
  CLKBUFX2TS U3379 ( .A(n6999), .Y(n6993) );
  INVX2TS U3380 ( .A(n7361), .Y(n7345) );
  CLKBUFX2TS U3381 ( .A(n6999), .Y(n6994) );
  CLKBUFX2TS U3382 ( .A(n7011), .Y(n7006) );
  INVX2TS U3383 ( .A(n7359), .Y(n7344) );
  CLKBUFX2TS U3384 ( .A(n6999), .Y(n6995) );
  CLKBUFX2TS U3385 ( .A(n7009), .Y(n7004) );
  CLKBUFX2TS U3386 ( .A(n7009), .Y(n7003) );
  CLKBUFX2TS U3387 ( .A(n7850), .Y(n6996) );
  CLKBUFX2TS U3388 ( .A(n7009), .Y(n7002) );
  CLKBUFX2TS U3389 ( .A(n6998), .Y(n6997) );
  CLKBUFX2TS U3390 ( .A(n7850), .Y(n7001) );
  CLKBUFX2TS U3391 ( .A(n7851), .Y(n7010) );
  CLKBUFX2TS U3392 ( .A(n7019), .Y(n7013) );
  INVX2TS U3393 ( .A(n7332), .Y(n7320) );
  CLKBUFX2TS U3394 ( .A(n7019), .Y(n7014) );
  CLKBUFX2TS U3395 ( .A(n7019), .Y(n7015) );
  CLKBUFX2TS U3396 ( .A(n7029), .Y(n7025) );
  INVX2TS U3397 ( .A(n7331), .Y(n7318) );
  CLKBUFX2TS U3398 ( .A(n7030), .Y(n7024) );
  INVX2TS U3399 ( .A(n7331), .Y(n7317) );
  CLKBUFX2TS U3400 ( .A(n7894), .Y(n7016) );
  CLKBUFX2TS U3401 ( .A(n7030), .Y(n7022) );
  INVX2TS U3402 ( .A(n7330), .Y(n7316) );
  NAND2X1TS U3403 ( .A(\router/addr_calc/iir_write_calc/counter/N40 ), .B(
        n6899), .Y(n7895) );
  CLKBUFX2TS U3404 ( .A(n7894), .Y(n7021) );
  INVX2TS U3405 ( .A(n7330), .Y(n7315) );
  ADDHXLTS U3406 ( .A(\router/addr_calc/iir_write_calc/count[30] ), .B(
        \add_x_22_5/carry[30] ), .CO(\add_x_22_5/carry[31] ), .S(
        \router/addr_calc/iir_write_calc/counter/N76 ) );
  CLKBUFX2TS U3407 ( .A(n7018), .Y(n7017) );
  CLKBUFX2TS U3408 ( .A(n7030), .Y(n7029) );
  CLKBUFX2TS U3409 ( .A(n6979), .Y(n6972) );
  CLKBUFX2TS U3410 ( .A(n7360), .Y(n7355) );
  CLKBUFX2TS U3411 ( .A(n6999), .Y(n6992) );
  CLKBUFX2TS U3412 ( .A(n7360), .Y(n7354) );
  CLKBUFX2TS U3413 ( .A(n6939), .Y(n6932) );
  CLKBUFX2TS U3414 ( .A(n6959), .Y(n6952) );
  CLKBUFX2TS U3415 ( .A(n7019), .Y(n7012) );
  CLKBUFX2TS U3416 ( .A(n7335), .Y(n7330) );
  CLKBUFX2TS U3417 ( .A(n7041), .Y(n7037) );
  CLKBUFX2TS U3418 ( .A(n7910), .Y(n7041) );
  CLKBUFX2TS U3419 ( .A(n7037), .Y(n7036) );
  CLKBUFX2TS U3420 ( .A(n7037), .Y(n7035) );
  CLKBUFX2TS U3421 ( .A(n7038), .Y(n7034) );
  CLKBUFX2TS U3422 ( .A(n7038), .Y(n7033) );
  CLKBUFX2TS U3423 ( .A(n7039), .Y(n7032) );
  CLKBUFX2TS U3424 ( .A(n7040), .Y(n7039) );
  CLKBUFX2TS U3425 ( .A(n7910), .Y(n7040) );
  CLKBUFX2TS U3426 ( .A(n7040), .Y(n7038) );
  NAND2X1TS U3427 ( .A(n4325), .B(n7522), .Y(n7538) );
  NOR2X1TS U3428 ( .A(n4325), .B(n7519), .Y(n7536) );
  CLKBUFX2TS U3429 ( .A(n7067), .Y(n7065) );
  INVX2TS U3430 ( .A(n7429), .Y(n7400) );
  CLKBUFX2TS U3431 ( .A(n7068), .Y(n7064) );
  CLKBUFX2TS U3432 ( .A(n7068), .Y(n7063) );
  INVX2TS U3433 ( .A(n7428), .Y(n7397) );
  NOR2X1TS U3434 ( .A(n4325), .B(n7524), .Y(n7529) );
  CLKBUFX2TS U3435 ( .A(n7457), .Y(n7426) );
  CLKBUFX2TS U3436 ( .A(n7453), .Y(n7436) );
  INVX2TS U3437 ( .A(n7063), .Y(n7057) );
  INVX2TS U3438 ( .A(n7062), .Y(n7059) );
  CLKBUFX2TS U3439 ( .A(n7450), .Y(n7448) );
  CLKBUFX2TS U3440 ( .A(n7051), .Y(n7049) );
  CLKBUFX2TS U3441 ( .A(n7456), .Y(n7428) );
  CLKBUFX2TS U3442 ( .A(n7453), .Y(n7438) );
  CLKBUFX2TS U3443 ( .A(n7049), .Y(n7046) );
  CLKBUFX2TS U3444 ( .A(n7452), .Y(n7439) );
  CLKBUFX2TS U3445 ( .A(n7916), .Y(n7051) );
  NAND2X1TS U3446 ( .A(n7902), .B(n7546), .Y(n7620) );
  NAND3X1TS U3447 ( .A(n6754), .B(n6830), .C(n6167), .Y(
        \router/addr_calc/fir_read_calc/counter/N40 ) );
  CLKBUFX2TS U3448 ( .A(n7360), .Y(n7356) );
  NAND3X1TS U3449 ( .A(n6757), .B(n6833), .C(n6168), .Y(
        \router/addr_calc/fft_write_calc/counter/N40 ) );
  NAND3X1TS U3450 ( .A(n6755), .B(n6831), .C(n6166), .Y(
        \router/addr_calc/fir_write_calc/counter/N40 ) );
  NAND2X1TS U3451 ( .A(n7543), .B(n7542), .Y(n7605) );
  NAND2X1TS U3452 ( .A(instruction[2]), .B(n7536), .Y(n7525) );
  CLKBUFX2TS U3453 ( .A(n7460), .Y(n7458) );
  CLKBUFX2TS U3454 ( .A(n1161), .Y(n7232) );
  CLKBUFX2TS U3455 ( .A(n1289), .Y(n7224) );
  CLKBUFX2TS U3456 ( .A(n1353), .Y(n7216) );
  CLKBUFX2TS U3457 ( .A(n1417), .Y(n7208) );
  CLKBUFX2TS U3458 ( .A(n1481), .Y(n7200) );
  NAND2X1TS U3459 ( .A(n7547), .B(n4794), .Y(n7660) );
  CLKBUFX2TS U3460 ( .A(n7337), .Y(n7331) );
  NAND4X1TS U3461 ( .A(n6842), .B(n6841), .C(n6840), .D(n6846), .Y(
        \router/addr_calc/iir_write_calc/counter/N40 ) );
  CLKBUFX2TS U3462 ( .A(n7450), .Y(n7449) );
  CLKBUFX2TS U3463 ( .A(n7452), .Y(n7443) );
  CLKBUFX2TS U3464 ( .A(n7451), .Y(n7446) );
  CLKBUFX2TS U3465 ( .A(n7451), .Y(n7445) );
  CLKBUFX2TS U3466 ( .A(n7453), .Y(n7441) );
  NAND4X1TS U3467 ( .A(n7464), .B(n7463), .C(n7462), .D(n7461), .Y(n7907) );
  CLKBUFX2TS U3468 ( .A(n7456), .Y(n7450) );
  CLKBUFX2TS U3469 ( .A(n7452), .Y(n7444) );
  CLKBUFX2TS U3470 ( .A(n7451), .Y(n7447) );
  CLKBUFX2TS U3471 ( .A(n7452), .Y(n7442) );
  NAND2BX1TS U3472 ( .AN(acc_done), .B(n7417), .Y(n7910) );
  CLKBUFX2TS U3473 ( .A(n7655), .Y(n6930) );
  NOR3X1TS U3474 ( .A(n7619), .B(n7618), .C(n7617), .Y(n7655) );
  CLKBUFX2TS U3475 ( .A(n6909), .Y(n6904) );
  CLKBUFX2TS U3476 ( .A(n6920), .Y(n6915) );
  CLKBUFX2TS U3477 ( .A(n6930), .Y(n6925) );
  CLKBUFX2TS U3478 ( .A(n6909), .Y(n6905) );
  CLKBUFX2TS U3479 ( .A(n6909), .Y(n6906) );
  CLKBUFX2TS U3480 ( .A(n6921), .Y(n6917) );
  CLKBUFX2TS U3481 ( .A(n6911), .Y(n6908) );
  CLKBUFX2TS U3482 ( .A(n6928), .Y(n6926) );
  CLKBUFX2TS U3483 ( .A(n7653), .Y(n6911) );
  CLKBUFX2TS U3484 ( .A(n6920), .Y(n6912) );
  CLKBUFX2TS U3485 ( .A(n6929), .Y(n6923) );
  CLKBUFX2TS U3486 ( .A(n6920), .Y(n6913) );
  CLKBUFX2TS U3487 ( .A(n6909), .Y(n6903) );
  CLKBUFX2TS U3488 ( .A(n6920), .Y(n6914) );
  CLKBUFX2TS U3489 ( .A(n6930), .Y(n6924) );
  CLKBUFX2TS U3490 ( .A(n6908), .Y(n6907) );
  CLKBUFX2TS U3491 ( .A(n6921), .Y(n6919) );
  CLKBUFX2TS U3492 ( .A(n6928), .Y(n6927) );
  CLKBUFX2TS U3493 ( .A(n7051), .Y(n7048) );
  INVX2TS U3494 ( .A(n6745), .Y(n6749) );
  NOR2X1TS U3495 ( .A(\fifo_to_fft/fifo_cell1/controller/f_i_put ), .B(
        \fifo_to_fft/fifo_cell1/controller/f_i_get ), .Y(n7479) );
  NOR2X1TS U3496 ( .A(\fifo_to_fft/fifo_cell2/controller/f_i_put ), .B(
        \fifo_to_fft/fifo_cell2/controller/f_i_get ), .Y(n7481) );
  NOR2X1TS U3497 ( .A(\fifo_to_fft/fifo_cell3/controller/f_i_put ), .B(
        \fifo_to_fft/fifo_cell3/controller/f_i_get ), .Y(n7480) );
  NOR2X1TS U3498 ( .A(\fifo_to_fft/fifo_cell5/controller/f_i_put ), .B(
        \fifo_to_fft/fifo_cell5/controller/f_i_get ), .Y(n7474) );
  NOR2X1TS U3499 ( .A(\fifo_to_fft/fifo_cell4/controller/f_i_put ), .B(
        \fifo_to_fft/fifo_cell4/controller/f_i_get ), .Y(n7475) );
  NOR2X1TS U3500 ( .A(\fifo_to_fft/fifo_cell6/controller/f_i_put ), .B(
        \fifo_to_fft/fifo_cell6/controller/f_i_get ), .Y(n7476) );
  NOR2X1TS U3501 ( .A(\fifo_to_fft/fifo_cell8/controller/f_i_put ), .B(
        \fifo_to_fft/fifo_cell8/controller/f_i_get ), .Y(n7477) );
  NOR2X1TS U3502 ( .A(\fifo_to_fft/fifo_cell7/controller/f_i_put ), .B(
        \fifo_to_fft/fifo_cell7/controller/f_i_get ), .Y(n7470) );
  NOR2X1TS U3503 ( .A(\fifo_to_fft/fifo_cell9/controller/f_i_put ), .B(
        \fifo_to_fft/fifo_cell9/controller/f_i_get ), .Y(n7471) );
  NOR2X1TS U3504 ( .A(\fifo_to_fft/fifo_cell11/controller/f_i_put ), .B(
        \fifo_to_fft/fifo_cell11/controller/f_i_get ), .Y(n7472) );
  NOR2X1TS U3505 ( .A(\fifo_to_fft/fifo_cell10/controller/f_i_put ), .B(
        \fifo_to_fft/fifo_cell10/controller/f_i_get ), .Y(n7473) );
  NOR2X1TS U3506 ( .A(\fifo_to_fft/fifo_cell12/controller/f_i_put ), .B(
        \fifo_to_fft/fifo_cell12/controller/f_i_get ), .Y(n7466) );
  NOR2X1TS U3507 ( .A(\fifo_to_fft/fifo_cell14/controller/f_i_put ), .B(
        \fifo_to_fft/fifo_cell14/controller/f_i_get ), .Y(n7467) );
  NOR2X1TS U3508 ( .A(\fifo_to_fft/fifo_cell13/controller/f_i_put ), .B(
        \fifo_to_fft/fifo_cell13/controller/f_i_get ), .Y(n7468) );
  NOR2X1TS U3509 ( .A(\fifo_to_fft/fifo_cell0/controller/f_i_put ), .B(
        \fifo_to_fft/fifo_cell0/controller/f_i_get ), .Y(n7469) );
  NOR2X1TS U3510 ( .A(\fifo_to_fir/fifo_cell1/controller/f_i_put ), .B(
        \fifo_to_fir/fifo_cell1/controller/f_i_get ), .Y(n7500) );
  NOR2X1TS U3511 ( .A(\fifo_to_fir/fifo_cell3/controller/f_i_put ), .B(
        \fifo_to_fir/fifo_cell3/controller/f_i_get ), .Y(n7501) );
  NOR2X1TS U3512 ( .A(\fifo_to_fir/fifo_cell2/controller/f_i_put ), .B(
        \fifo_to_fir/fifo_cell2/controller/f_i_get ), .Y(n7502) );
  NOR2X1TS U3513 ( .A(\fifo_to_fir/fifo_cell5/controller/f_i_put ), .B(
        \fifo_to_fir/fifo_cell5/controller/f_i_get ), .Y(n7495) );
  NOR2X1TS U3514 ( .A(\fifo_to_fir/fifo_cell4/controller/f_i_put ), .B(
        \fifo_to_fir/fifo_cell4/controller/f_i_get ), .Y(n7496) );
  NOR2X1TS U3515 ( .A(\fifo_to_fir/fifo_cell6/controller/f_i_put ), .B(
        \fifo_to_fir/fifo_cell6/controller/f_i_get ), .Y(n7497) );
  NOR2X1TS U3516 ( .A(\fifo_to_fir/fifo_cell8/controller/f_i_put ), .B(
        \fifo_to_fir/fifo_cell8/controller/f_i_get ), .Y(n7498) );
  NOR2X1TS U3517 ( .A(\fifo_to_fir/fifo_cell7/controller/f_i_put ), .B(
        \fifo_to_fir/fifo_cell7/controller/f_i_get ), .Y(n7491) );
  NOR2X1TS U3518 ( .A(\fifo_to_fir/fifo_cell9/controller/f_i_put ), .B(
        \fifo_to_fir/fifo_cell9/controller/f_i_get ), .Y(n7492) );
  NOR2X1TS U3519 ( .A(\fifo_to_fir/fifo_cell11/controller/f_i_put ), .B(
        \fifo_to_fir/fifo_cell11/controller/f_i_get ), .Y(n7493) );
  NOR2X1TS U3520 ( .A(\fifo_to_fir/fifo_cell10/controller/f_i_put ), .B(
        \fifo_to_fir/fifo_cell10/controller/f_i_get ), .Y(n7494) );
  NOR2X1TS U3521 ( .A(\fifo_to_fir/fifo_cell12/controller/f_i_put ), .B(
        \fifo_to_fir/fifo_cell12/controller/f_i_get ), .Y(n7487) );
  NOR2X1TS U3522 ( .A(\fifo_to_fir/fifo_cell14/controller/f_i_put ), .B(
        \fifo_to_fir/fifo_cell14/controller/f_i_get ), .Y(n7488) );
  NOR2X1TS U3523 ( .A(\fifo_to_fir/fifo_cell13/controller/f_i_put ), .B(
        \fifo_to_fir/fifo_cell13/controller/f_i_get ), .Y(n7489) );
  NOR2X1TS U3524 ( .A(\fifo_to_fir/fifo_cell0/controller/f_i_put ), .B(
        \fifo_to_fir/fifo_cell0/controller/f_i_get ), .Y(n7490) );
  INVX2TS U3525 ( .A(n7066), .Y(n7054) );
  CLKBUFX2TS U3526 ( .A(n7050), .Y(n7043) );
  CLKBUFX2TS U3527 ( .A(n7048), .Y(n7047) );
  INVX2TS U3528 ( .A(n6745), .Y(n6746) );
  CLKBUFX2TS U3529 ( .A(n7050), .Y(n7042) );
  INVX2TS U3530 ( .A(n6750), .Y(n6752) );
  INVX2TS U3531 ( .A(n6745), .Y(n6747) );
  AOI21X1TS U3532 ( .A0(n7586), .A1(n7585), .B0(n7584), .Y(n7611) );
  NAND2X1TS U3533 ( .A(n7070), .B(\fifo_from_fir/fifo_cell14/reg_gtok/token ), 
        .Y(n7539) );
  NAND2X1TS U3534 ( .A(n7080), .B(\fifo_from_fft/fifo_cell14/reg_gtok/token ), 
        .Y(n7616) );
  CLKBUFX2TS U3535 ( .A(n7456), .Y(n7429) );
  CLKBUFX2TS U3536 ( .A(n7454), .Y(n7435) );
  CLKBUFX2TS U3537 ( .A(n7455), .Y(n7431) );
  CLKBUFX2TS U3538 ( .A(n7455), .Y(n7432) );
  CLKBUFX2TS U3539 ( .A(n7455), .Y(n7430) );
  CLKBUFX2TS U3540 ( .A(n7388), .Y(n7381) );
  CLKBUFX2TS U3541 ( .A(n7388), .Y(n7379) );
  NAND3X1TS U3542 ( .A(n6756), .B(n6832), .C(n6169), .Y(
        \router/addr_calc/fft_read_calc/counter/N40 ) );
  CLKBUFX2TS U3543 ( .A(n7388), .Y(n7380) );
  CLKBUFX2TS U3544 ( .A(n7387), .Y(n7383) );
  CLKBUFX2TS U3545 ( .A(n7387), .Y(n7382) );
  INVX2TS U3546 ( .A(n7354), .Y(n7338) );
  INVX2TS U3547 ( .A(n7379), .Y(n7362) );
  CLKBUFX2TS U3548 ( .A(n7335), .Y(n7333) );
  CLKBUFX2TS U3549 ( .A(n7386), .Y(n7385) );
  CLKBUFX2TS U3550 ( .A(n7335), .Y(n7334) );
  INVX2TS U3551 ( .A(n7064), .Y(n7056) );
  CLKBUFX2TS U3552 ( .A(n7069), .Y(n7067) );
  INVX2TS U3553 ( .A(n7065), .Y(n7055) );
  CLKBUFX2TS U3554 ( .A(n7079), .Y(n7070) );
  CLKBUFX2TS U3555 ( .A(n7078), .Y(n7072) );
  CLKBUFX2TS U3556 ( .A(n7078), .Y(n7071) );
  CLKBUFX2TS U3557 ( .A(n7050), .Y(n7045) );
  CLKBUFX2TS U3558 ( .A(n7050), .Y(n7044) );
  NAND3X1TS U3559 ( .A(n6681), .B(n6895), .C(n7362), .Y(n7670) );
  CLKBUFX2TS U3560 ( .A(n7458), .Y(n7425) );
  CLKBUFX2TS U3561 ( .A(n7088), .Y(n7080) );
  CLKBUFX2TS U3562 ( .A(n7087), .Y(n7082) );
  CLKBUFX2TS U3563 ( .A(n7089), .Y(n7087) );
  CLKBUFX2TS U3564 ( .A(n7087), .Y(n7081) );
  CLKBUFX2TS U3565 ( .A(n7456), .Y(n7427) );
  INVX2TS U3566 ( .A(n7383), .Y(fft_enable) );
  CLKBUFX2TS U3567 ( .A(n7653), .Y(n6910) );
  CLKBUFX2TS U3568 ( .A(n6929), .Y(n6922) );
  CLKBUFX2TS U3569 ( .A(n7850), .Y(n7000) );
  CLKBUFX2TS U3570 ( .A(n7806), .Y(n6980) );
  CLKBUFX2TS U3571 ( .A(n7718), .Y(n6940) );
  CLKBUFX2TS U3572 ( .A(n7762), .Y(n6960) );
  CLKBUFX2TS U3573 ( .A(n7011), .Y(n7008) );
  CLKBUFX2TS U3574 ( .A(n6991), .Y(n6988) );
  CLKBUFX2TS U3575 ( .A(n6971), .Y(n6968) );
  CLKBUFX2TS U3576 ( .A(n6951), .Y(n6948) );
  CLKBUFX2TS U3577 ( .A(n7894), .Y(n7020) );
  CLKBUFX2TS U3578 ( .A(n7031), .Y(n7028) );
  CLKBUFX2TS U3579 ( .A(n7359), .Y(n7358) );
  INVX2TS U3580 ( .A(n7379), .Y(n7363) );
  INVX2TS U3581 ( .A(n7426), .Y(n7393) );
  CLKBUFX2TS U3582 ( .A(n7252), .Y(n7251) );
  CLKBUFX2TS U3583 ( .A(n7272), .Y(n7271) );
  CLKBUFX2TS U3584 ( .A(\router/addr_calc/fir_write_calc/counter/N212 ), .Y(
        n7252) );
  CLKBUFX2TS U3585 ( .A(\router/addr_calc/fir_read_calc/counter/N212 ), .Y(
        n7262) );
  CLKBUFX2TS U3586 ( .A(\router/addr_calc/fft_write_calc/counter/N212 ), .Y(
        n7272) );
  CLKBUFX2TS U3587 ( .A(\router/addr_calc/fft_read_calc/counter/N212 ), .Y(
        n7282) );
  CLKBUFX2TS U3588 ( .A(n7271), .Y(n7264) );
  CLKBUFX2TS U3589 ( .A(\router/addr_calc/fir_write_calc/counter/N212 ), .Y(
        n7253) );
  CLKBUFX2TS U3590 ( .A(n7283), .Y(n7280) );
  CLKBUFX2TS U3591 ( .A(n7263), .Y(n7260) );
  CLKBUFX2TS U3592 ( .A(\router/addr_calc/iir_write_calc/counter/N212 ), .Y(
        n7242) );
  CLKBUFX2TS U3593 ( .A(n7243), .Y(n7240) );
  CLKBUFX2TS U3594 ( .A(n7261), .Y(n7254) );
  CLKBUFX2TS U3595 ( .A(n7261), .Y(n7255) );
  CLKBUFX2TS U3596 ( .A(n7261), .Y(n7256) );
  CLKBUFX2TS U3597 ( .A(n7262), .Y(n7257) );
  CLKBUFX2TS U3598 ( .A(n7260), .Y(n7258) );
  CLKBUFX2TS U3599 ( .A(\router/addr_calc/fir_read_calc/counter/N212 ), .Y(
        n7263) );
  CLKBUFX2TS U3600 ( .A(n7263), .Y(n7259) );
  CLKBUFX2TS U3601 ( .A(n7281), .Y(n7274) );
  CLKBUFX2TS U3602 ( .A(n7281), .Y(n7275) );
  CLKBUFX2TS U3603 ( .A(n7281), .Y(n7276) );
  CLKBUFX2TS U3604 ( .A(n7282), .Y(n7277) );
  CLKBUFX2TS U3605 ( .A(n7280), .Y(n7278) );
  CLKBUFX2TS U3606 ( .A(\router/addr_calc/fft_read_calc/counter/N212 ), .Y(
        n7283) );
  CLKBUFX2TS U3607 ( .A(n7283), .Y(n7279) );
  CLKBUFX2TS U3608 ( .A(n7271), .Y(n7265) );
  CLKBUFX2TS U3609 ( .A(n7271), .Y(n7266) );
  CLKBUFX2TS U3610 ( .A(n7272), .Y(n7267) );
  CLKBUFX2TS U3611 ( .A(n7273), .Y(n7270) );
  CLKBUFX2TS U3612 ( .A(n7270), .Y(n7268) );
  CLKBUFX2TS U3613 ( .A(\router/addr_calc/fft_write_calc/counter/N212 ), .Y(
        n7273) );
  CLKBUFX2TS U3614 ( .A(n7273), .Y(n7269) );
  CLKBUFX2TS U3615 ( .A(n7251), .Y(n7244) );
  CLKBUFX2TS U3616 ( .A(n7251), .Y(n7245) );
  CLKBUFX2TS U3617 ( .A(n7251), .Y(n7246) );
  CLKBUFX2TS U3618 ( .A(n7252), .Y(n7247) );
  CLKBUFX2TS U3619 ( .A(n7253), .Y(n7250) );
  CLKBUFX2TS U3620 ( .A(n7250), .Y(n7248) );
  CLKBUFX2TS U3621 ( .A(n7253), .Y(n7249) );
  CLKBUFX2TS U3622 ( .A(n7241), .Y(n7234) );
  CLKBUFX2TS U3623 ( .A(n7241), .Y(n7235) );
  CLKBUFX2TS U3624 ( .A(n7241), .Y(n7236) );
  CLKBUFX2TS U3625 ( .A(n7242), .Y(n7237) );
  CLKBUFX2TS U3626 ( .A(n7240), .Y(n7238) );
  CLKBUFX2TS U3627 ( .A(\router/addr_calc/iir_write_calc/counter/N212 ), .Y(
        n7243) );
  CLKBUFX2TS U3628 ( .A(n7243), .Y(n7239) );
  CLKBUFX2TS U3629 ( .A(n7262), .Y(n7261) );
  CLKBUFX2TS U3630 ( .A(n7282), .Y(n7281) );
  CLKBUFX2TS U3631 ( .A(n7242), .Y(n7241) );
  CLKBUFX2TS U3632 ( .A(n1161), .Y(n7233) );
  CLKBUFX2TS U3633 ( .A(n1289), .Y(n7225) );
  CLKBUFX2TS U3634 ( .A(n1353), .Y(n7217) );
  CLKBUFX2TS U3635 ( .A(n1417), .Y(n7209) );
  CLKBUFX2TS U3636 ( .A(n1481), .Y(n7201) );
  CLKBUFX2TS U3637 ( .A(n7232), .Y(n7231) );
  CLKBUFX2TS U3638 ( .A(n7232), .Y(n7230) );
  CLKBUFX2TS U3639 ( .A(n7232), .Y(n7229) );
  CLKBUFX2TS U3640 ( .A(\router/addr_calc/iir_write_calc/count[14] ), .Y(
        \router/addr_calc/iir_write_addr[14] ) );
  CLKBUFX2TS U3641 ( .A(n7232), .Y(n7228) );
  CLKBUFX2TS U3642 ( .A(\router/addr_calc/iir_write_calc/count[18] ), .Y(
        \router/addr_calc/iir_write_addr[18] ) );
  CLKBUFX2TS U3643 ( .A(n7233), .Y(n7227) );
  CLKBUFX2TS U3644 ( .A(n7224), .Y(n7223) );
  CLKBUFX2TS U3645 ( .A(n7224), .Y(n7222) );
  CLKBUFX2TS U3646 ( .A(\router/addr_calc/fir_write_calc/count[9] ), .Y(
        \router/addr_calc/fir_write_addr[9] ) );
  CLKBUFX2TS U3647 ( .A(n7224), .Y(n7221) );
  CLKBUFX2TS U3648 ( .A(n7224), .Y(n7220) );
  CLKBUFX2TS U3649 ( .A(n7225), .Y(n7219) );
  CLKBUFX2TS U3650 ( .A(n7216), .Y(n7215) );
  CLKBUFX2TS U3651 ( .A(n7216), .Y(n7214) );
  CLKBUFX2TS U3652 ( .A(\router/addr_calc/fir_read_calc/count[9] ), .Y(
        \router/addr_calc/fir_read_addr[9] ) );
  CLKBUFX2TS U3653 ( .A(n7216), .Y(n7213) );
  CLKBUFX2TS U3654 ( .A(\router/addr_calc/fir_read_calc/count[14] ), .Y(
        \router/addr_calc/fir_read_addr[14] ) );
  CLKBUFX2TS U3655 ( .A(n7216), .Y(n7212) );
  CLKBUFX2TS U3656 ( .A(n7217), .Y(n7211) );
  CLKBUFX2TS U3657 ( .A(n7208), .Y(n7207) );
  CLKBUFX2TS U3658 ( .A(n7208), .Y(n7206) );
  CLKBUFX2TS U3659 ( .A(\router/addr_calc/fft_write_calc/count[9] ), .Y(
        \router/addr_calc/fft_write_addr[9] ) );
  CLKBUFX2TS U3660 ( .A(n7208), .Y(n7205) );
  CLKBUFX2TS U3661 ( .A(n7208), .Y(n7204) );
  CLKBUFX2TS U3662 ( .A(\router/addr_calc/fft_write_calc/count[15] ), .Y(
        \router/addr_calc/fft_write_addr[15] ) );
  CLKBUFX2TS U3663 ( .A(n7209), .Y(n7203) );
  CLKBUFX2TS U3664 ( .A(n7200), .Y(n7199) );
  CLKBUFX2TS U3665 ( .A(n7200), .Y(n7198) );
  CLKBUFX2TS U3666 ( .A(\router/addr_calc/fft_read_calc/count[9] ), .Y(
        \router/addr_calc/fft_read_addr[9] ) );
  CLKBUFX2TS U3667 ( .A(n7200), .Y(n7197) );
  CLKBUFX2TS U3668 ( .A(\router/addr_calc/fft_read_calc/count[14] ), .Y(
        \router/addr_calc/fft_read_addr[14] ) );
  CLKBUFX2TS U3669 ( .A(n7200), .Y(n7196) );
  CLKBUFX2TS U3670 ( .A(n7201), .Y(n7195) );
  CLKBUFX2TS U3671 ( .A(n6325), .Y(n7131) );
  CLKBUFX2TS U3672 ( .A(n6246), .Y(n7130) );
  CLKBUFX2TS U3673 ( .A(n6188), .Y(n7129) );
  CLKBUFX2TS U3674 ( .A(n6319), .Y(n7128) );
  CLKBUFX2TS U3675 ( .A(n6240), .Y(n7127) );
  CLKBUFX2TS U3676 ( .A(n6189), .Y(n7126) );
  CLKBUFX2TS U3677 ( .A(n6316), .Y(n7125) );
  CLKBUFX2TS U3678 ( .A(n6234), .Y(n7124) );
  CLKBUFX2TS U3679 ( .A(n6190), .Y(n7123) );
  CLKBUFX2TS U3680 ( .A(n6310), .Y(n7122) );
  CLKBUFX2TS U3681 ( .A(n6228), .Y(n7121) );
  CLKBUFX2TS U3682 ( .A(n6191), .Y(n7120) );
  CLKBUFX2TS U3683 ( .A(n6307), .Y(n7119) );
  CLKBUFX2TS U3684 ( .A(n6222), .Y(n7118) );
  CLKBUFX2TS U3685 ( .A(n6192), .Y(n7117) );
  CLKBUFX2TS U3686 ( .A(n6301), .Y(n7116) );
  CLKBUFX2TS U3687 ( .A(n6216), .Y(n7115) );
  CLKBUFX2TS U3688 ( .A(n6193), .Y(n7114) );
  CLKBUFX2TS U3689 ( .A(n6213), .Y(n7113) );
  CLKBUFX2TS U3690 ( .A(n6298), .Y(n7112) );
  CLKBUFX2TS U3691 ( .A(n6194), .Y(n7111) );
  CLKBUFX2TS U3692 ( .A(n6219), .Y(n7110) );
  CLKBUFX2TS U3693 ( .A(n6292), .Y(n7109) );
  CLKBUFX2TS U3694 ( .A(n6195), .Y(n7108) );
  CLKBUFX2TS U3695 ( .A(n6225), .Y(n7107) );
  CLKBUFX2TS U3696 ( .A(n6289), .Y(n7106) );
  CLKBUFX2TS U3697 ( .A(n6196), .Y(n7105) );
  CLKBUFX2TS U3698 ( .A(n6231), .Y(n7104) );
  CLKBUFX2TS U3699 ( .A(n6283), .Y(n7103) );
  CLKBUFX2TS U3700 ( .A(n6197), .Y(n7102) );
  CLKBUFX2TS U3701 ( .A(n6237), .Y(n7101) );
  CLKBUFX2TS U3702 ( .A(n6280), .Y(n7100) );
  CLKBUFX2TS U3703 ( .A(n6198), .Y(n7099) );
  CLKBUFX2TS U3704 ( .A(n6243), .Y(n7098) );
  CLKBUFX2TS U3705 ( .A(n6274), .Y(n7097) );
  CLKBUFX2TS U3706 ( .A(n6199), .Y(n7096) );
  CLKBUFX2TS U3707 ( .A(n6249), .Y(n7095) );
  CLKBUFX2TS U3708 ( .A(n6271), .Y(n7094) );
  CLKBUFX2TS U3709 ( .A(n6200), .Y(n7093) );
  CLKBUFX2TS U3710 ( .A(n7301), .Y(n7295) );
  CLKBUFX2TS U3711 ( .A(n7301), .Y(n7294) );
  CLKBUFX2TS U3712 ( .A(n6252), .Y(n7092) );
  CLKBUFX2TS U3713 ( .A(n6187), .Y(n7091) );
  CLKBUFX2TS U3714 ( .A(n6252), .Y(n7090) );
  CLKBUFX2TS U3715 ( .A(n6385), .Y(n7178) );
  CLKBUFX2TS U3716 ( .A(n6375), .Y(n7177) );
  CLKBUFX2TS U3717 ( .A(n6174), .Y(n7176) );
  CLKBUFX2TS U3718 ( .A(n6382), .Y(n7175) );
  CLKBUFX2TS U3719 ( .A(n6366), .Y(n7174) );
  CLKBUFX2TS U3720 ( .A(n6175), .Y(n7173) );
  CLKBUFX2TS U3721 ( .A(n6379), .Y(n7172) );
  CLKBUFX2TS U3722 ( .A(n6357), .Y(n7171) );
  CLKBUFX2TS U3723 ( .A(n6176), .Y(n7170) );
  CLKBUFX2TS U3724 ( .A(n6373), .Y(n7169) );
  CLKBUFX2TS U3725 ( .A(n6348), .Y(n7168) );
  CLKBUFX2TS U3726 ( .A(n6177), .Y(n7167) );
  CLKBUFX2TS U3727 ( .A(n6370), .Y(n7166) );
  CLKBUFX2TS U3728 ( .A(n6339), .Y(n7165) );
  CLKBUFX2TS U3729 ( .A(n6178), .Y(n7164) );
  CLKBUFX2TS U3730 ( .A(n6364), .Y(n7163) );
  CLKBUFX2TS U3731 ( .A(n6330), .Y(n7162) );
  CLKBUFX2TS U3732 ( .A(n6179), .Y(n7161) );
  CLKBUFX2TS U3733 ( .A(n6361), .Y(n7160) );
  CLKBUFX2TS U3734 ( .A(n6321), .Y(n7159) );
  CLKBUFX2TS U3735 ( .A(n6180), .Y(n7158) );
  CLKBUFX2TS U3736 ( .A(n6355), .Y(n7157) );
  CLKBUFX2TS U3737 ( .A(n6312), .Y(n7156) );
  CLKBUFX2TS U3738 ( .A(n6181), .Y(n7155) );
  CLKBUFX2TS U3739 ( .A(n6352), .Y(n7154) );
  CLKBUFX2TS U3740 ( .A(n6303), .Y(n7153) );
  CLKBUFX2TS U3741 ( .A(n6182), .Y(n7152) );
  CLKBUFX2TS U3742 ( .A(n6346), .Y(n7151) );
  CLKBUFX2TS U3743 ( .A(n6294), .Y(n7150) );
  CLKBUFX2TS U3744 ( .A(n6183), .Y(n7149) );
  CLKBUFX2TS U3745 ( .A(n6343), .Y(n7148) );
  CLKBUFX2TS U3746 ( .A(n6285), .Y(n7147) );
  CLKBUFX2TS U3747 ( .A(n6184), .Y(n7146) );
  CLKBUFX2TS U3748 ( .A(n6337), .Y(n7145) );
  CLKBUFX2TS U3749 ( .A(n6276), .Y(n7144) );
  CLKBUFX2TS U3750 ( .A(n6185), .Y(n7143) );
  CLKBUFX2TS U3751 ( .A(n6334), .Y(n7142) );
  CLKBUFX2TS U3752 ( .A(n6267), .Y(n7141) );
  CLKBUFX2TS U3753 ( .A(n6186), .Y(n7140) );
  CLKBUFX2TS U3754 ( .A(n7311), .Y(n7305) );
  CLKBUFX2TS U3755 ( .A(n7311), .Y(n7304) );
  CLKBUFX2TS U3756 ( .A(n6173), .Y(n7139) );
  CLKBUFX2TS U3757 ( .A(n6258), .Y(n7138) );
  CLKBUFX2TS U3758 ( .A(n7302), .Y(n7301) );
  CLKBUFX2TS U3759 ( .A(n6258), .Y(n7137) );
  CLKBUFX2TS U3760 ( .A(n7312), .Y(n7311) );
  CLKBUFX2TS U3761 ( .A(n1161), .Y(n7226) );
  CLKBUFX2TS U3762 ( .A(n1289), .Y(n7218) );
  CLKBUFX2TS U3763 ( .A(n1353), .Y(n7210) );
  CLKBUFX2TS U3764 ( .A(n1417), .Y(n7202) );
  CLKBUFX2TS U3765 ( .A(n1481), .Y(n7194) );
  CLKBUFX2TS U3766 ( .A(n7077), .Y(n7073) );
  CLKBUFX2TS U3767 ( .A(n7076), .Y(n7074) );
  CLKBUFX2TS U3768 ( .A(n7079), .Y(n7076) );
  CLKBUFX2TS U3769 ( .A(n7079), .Y(n7075) );
  CLKBUFX2TS U3770 ( .A(n7087), .Y(n7083) );
  CLKBUFX2TS U3771 ( .A(n7086), .Y(n7084) );
  CLKBUFX2TS U3772 ( .A(n7088), .Y(n7086) );
  CLKBUFX2TS U3773 ( .A(n4699), .Y(n7089) );
  CLKBUFX2TS U3774 ( .A(n7088), .Y(n7085) );
  AO21X1TS U3775 ( .A0(\fifo_from_fir/fifo_cell4/reg_gtok/token ), .A1(n6743), 
        .B0(\fifo_from_fir/fifo_cell4/data_out/N35 ), .Y(n5804) );
  AO21X1TS U3776 ( .A0(\fifo_from_fir/fifo_cell3/reg_gtok/token ), .A1(n6742), 
        .B0(\fifo_from_fir/fifo_cell3/data_out/N35 ), .Y(n5805) );
  AO21X1TS U3777 ( .A0(\fifo_from_fir/fifo_cell2/reg_gtok/token ), .A1(n6742), 
        .B0(\fifo_from_fir/fifo_cell2/data_out/N35 ), .Y(n5806) );
  AO21X1TS U3778 ( .A0(\fifo_from_fir/fifo_cell1/reg_gtok/token ), .A1(n6741), 
        .B0(\fifo_from_fir/fifo_cell1/data_out/N35 ), .Y(n5807) );
  AO21X1TS U3779 ( .A0(\fifo_from_fft/fifo_cell4/reg_gtok/token ), .A1(n6738), 
        .B0(\fifo_from_fft/fifo_cell4/data_out/N35 ), .Y(n5663) );
  AO21X1TS U3780 ( .A0(\fifo_from_fft/fifo_cell3/reg_gtok/token ), .A1(n6737), 
        .B0(\fifo_from_fft/fifo_cell3/data_out/N35 ), .Y(n5664) );
  AO21X1TS U3781 ( .A0(\fifo_from_fft/fifo_cell2/reg_gtok/token ), .A1(n6737), 
        .B0(\fifo_from_fft/fifo_cell2/data_out/N35 ), .Y(n5665) );
  AO21X1TS U3782 ( .A0(\fifo_from_fft/fifo_cell1/reg_gtok/token ), .A1(n6736), 
        .B0(\fifo_from_fft/fifo_cell1/data_out/N35 ), .Y(n5666) );
  CLKBUFX2TS U3783 ( .A(\fifo_from_fir/fifo_cell14/control_signal ), .Y(n7302)
         );
  CLKBUFX2TS U3784 ( .A(\fifo_from_fft/fifo_cell14/control_signal ), .Y(n7312)
         );
  CLKBUFX2TS U3785 ( .A(n7135), .Y(n7133) );
  CLKBUFX2TS U3786 ( .A(n6171), .Y(n7132) );
  CLKBUFX2TS U3787 ( .A(n7303), .Y(n7299) );
  CLKBUFX2TS U3788 ( .A(\fifo_from_fir/fifo_cell14/control_signal ), .Y(n7303)
         );
  CLKBUFX2TS U3789 ( .A(n7303), .Y(n7300) );
  CLKBUFX2TS U3790 ( .A(n7300), .Y(n7298) );
  CLKBUFX2TS U3791 ( .A(n7182), .Y(n7180) );
  CLKBUFX2TS U3792 ( .A(n6172), .Y(n7179) );
  CLKBUFX2TS U3793 ( .A(n7313), .Y(n7309) );
  CLKBUFX2TS U3794 ( .A(\fifo_from_fft/fifo_cell14/control_signal ), .Y(n7313)
         );
  CLKBUFX2TS U3795 ( .A(n7313), .Y(n7310) );
  CLKBUFX2TS U3796 ( .A(n7310), .Y(n7308) );
  AOI222XLTS U3797 ( .A0(n6924), .A1(\router/data_cntl/data_in[23] ), .B0(
        n6914), .B1(fir_data_in[23]), .C0(n6903), .C1(fft_data_in[23]), .Y(
        n7645) );
  AOI222XLTS U3798 ( .A0(n6923), .A1(\router/data_cntl/data_in[25] ), .B0(
        n6913), .B1(fir_data_in[25]), .C0(n6902), .C1(fft_data_in[25]), .Y(
        n7647) );
  AOI222XLTS U3799 ( .A0(n6923), .A1(\router/data_cntl/data_in[27] ), .B0(
        n6913), .B1(fir_data_in[27]), .C0(n6902), .C1(fft_data_in[27]), .Y(
        n7649) );
  AOI222XLTS U3800 ( .A0(n6927), .A1(\router/data_cntl/data_in[1] ), .B0(n6919), .B1(fir_data_in[1]), .C0(n6907), .C1(fft_data_in[1]), .Y(n7623) );
  AOI222XLTS U3801 ( .A0(n6931), .A1(\router/data_cntl/data_in[2] ), .B0(n6919), .B1(fir_data_in[2]), .C0(n6907), .C1(fft_data_in[2]), .Y(n7624) );
  AOI222XLTS U3802 ( .A0(n6927), .A1(\router/data_cntl/data_in[4] ), .B0(n6918), .B1(fir_data_in[4]), .C0(n6911), .C1(fft_data_in[4]), .Y(n7626) );
  AOI222XLTS U3803 ( .A0(n6926), .A1(\router/data_cntl/data_in[6] ), .B0(n6918), .B1(fir_data_in[6]), .C0(n6911), .C1(fft_data_in[6]), .Y(n7628) );
  AOI222XLTS U3804 ( .A0(n6926), .A1(\router/data_cntl/data_in[8] ), .B0(n6917), .B1(fir_data_in[8]), .C0(n6906), .C1(fft_data_in[8]), .Y(n7630) );
  AOI222XLTS U3805 ( .A0(n6931), .A1(\router/data_cntl/data_in[10] ), .B0(
        n6917), .B1(fir_data_in[10]), .C0(n6906), .C1(fft_data_in[10]), .Y(
        n7632) );
  AOI222XLTS U3806 ( .A0(n6925), .A1(\router/data_cntl/data_in[15] ), .B0(
        n6916), .B1(fir_data_in[15]), .C0(n6905), .C1(fft_data_in[15]), .Y(
        n7637) );
  AOI222XLTS U3807 ( .A0(n6929), .A1(\router/data_cntl/data_in[19] ), .B0(
        n6915), .B1(fir_data_in[19]), .C0(n6904), .C1(fft_data_in[19]), .Y(
        n7641) );
  AOI222XLTS U3808 ( .A0(n6924), .A1(\router/data_cntl/data_in[21] ), .B0(
        n6914), .B1(fir_data_in[21]), .C0(n6903), .C1(fft_data_in[21]), .Y(
        n7643) );
  AOI222XLTS U3809 ( .A0(n6925), .A1(\router/data_cntl/data_in[31] ), .B0(
        n6912), .B1(fir_data_in[31]), .C0(n6910), .C1(fft_data_in[31]), .Y(
        n7656) );
  AOI222XLTS U3810 ( .A0(n6922), .A1(\router/data_cntl/data_in[30] ), .B0(
        n6912), .B1(fir_data_in[30]), .C0(n6910), .C1(fft_data_in[30]), .Y(
        n7652) );
  AOI222XLTS U3811 ( .A0(n6930), .A1(\router/data_cntl/data_in[20] ), .B0(
        n6914), .B1(fir_data_in[20]), .C0(n6903), .C1(fft_data_in[20]), .Y(
        n7642) );
  AOI222XLTS U3812 ( .A0(n6925), .A1(\router/data_cntl/data_in[14] ), .B0(
        n6916), .B1(fir_data_in[14]), .C0(n6905), .C1(fft_data_in[14]), .Y(
        n7636) );
  AOI222XLTS U3813 ( .A0(n6929), .A1(\router/data_cntl/data_in[12] ), .B0(
        n6916), .B1(fir_data_in[12]), .C0(n6905), .C1(fft_data_in[12]), .Y(
        n7634) );
  AOI222XLTS U3814 ( .A0(n6928), .A1(\router/data_cntl/data_in[11] ), .B0(
        n6917), .B1(fir_data_in[11]), .C0(n6906), .C1(fft_data_in[11]), .Y(
        n7633) );
  AO21X1TS U3815 ( .A0(\fifo_from_fir/fifo_cell14/reg_gtok/token ), .A1(n6742), 
        .B0(\fifo_from_fir/fifo_cell14/data_out/N35 ), .Y(n5794) );
  AO21X1TS U3816 ( .A0(\fifo_from_fft/fifo_cell14/reg_gtok/token ), .A1(n6737), 
        .B0(\fifo_from_fft/fifo_cell14/data_out/N35 ), .Y(n5653) );
  AO21X1TS U3817 ( .A0(\fifo_from_fir/fifo_cell0/reg_gtok/token ), .A1(n6741), 
        .B0(\fifo_from_fir/fifo_cell0/data_out/N35 ), .Y(n5808) );
  AO21X1TS U3818 ( .A0(\fifo_from_fir/fifo_cell13/reg_gtok/token ), .A1(n6743), 
        .B0(\fifo_from_fir/fifo_cell13/data_out/N35 ), .Y(n5795) );
  AO21X1TS U3819 ( .A0(\fifo_from_fir/fifo_cell12/reg_gtok/token ), .A1(n6741), 
        .B0(\fifo_from_fir/fifo_cell12/data_out/N35 ), .Y(n5796) );
  AO21X1TS U3820 ( .A0(\fifo_from_fir/fifo_cell11/reg_gtok/token ), .A1(n6741), 
        .B0(\fifo_from_fir/fifo_cell11/data_out/N35 ), .Y(n5797) );
  AO21X1TS U3821 ( .A0(\fifo_from_fir/fifo_cell10/reg_gtok/token ), .A1(n6744), 
        .B0(\fifo_from_fir/fifo_cell10/data_out/N35 ), .Y(n5798) );
  AO21X1TS U3822 ( .A0(\fifo_from_fir/fifo_cell9/reg_gtok/token ), .A1(n6742), 
        .B0(\fifo_from_fir/fifo_cell9/data_out/N35 ), .Y(n5799) );
  AO21X1TS U3823 ( .A0(\fifo_from_fir/fifo_cell8/reg_gtok/token ), .A1(n6743), 
        .B0(\fifo_from_fir/fifo_cell8/data_out/N35 ), .Y(n5800) );
  AO21X1TS U3824 ( .A0(\fifo_from_fir/fifo_cell7/reg_gtok/token ), .A1(n6743), 
        .B0(\fifo_from_fir/fifo_cell7/data_out/N35 ), .Y(n5801) );
  AO21X1TS U3825 ( .A0(\fifo_from_fir/fifo_cell6/reg_gtok/token ), .A1(n6744), 
        .B0(\fifo_from_fir/fifo_cell6/data_out/N35 ), .Y(n5802) );
  AO21X1TS U3826 ( .A0(\fifo_from_fir/fifo_cell5/reg_gtok/token ), .A1(n6744), 
        .B0(\fifo_from_fir/fifo_cell5/data_out/N35 ), .Y(n5803) );
  AO21X1TS U3827 ( .A0(\fifo_from_fft/fifo_cell0/reg_gtok/token ), .A1(n6736), 
        .B0(\fifo_from_fft/fifo_cell0/data_out/N35 ), .Y(n5667) );
  AO21X1TS U3828 ( .A0(\fifo_from_fft/fifo_cell13/reg_gtok/token ), .A1(n6738), 
        .B0(\fifo_from_fft/fifo_cell13/data_out/N35 ), .Y(n5654) );
  AO21X1TS U3829 ( .A0(\fifo_from_fft/fifo_cell12/reg_gtok/token ), .A1(n6736), 
        .B0(\fifo_from_fft/fifo_cell12/data_out/N35 ), .Y(n5655) );
  AO21X1TS U3830 ( .A0(\fifo_from_fft/fifo_cell11/reg_gtok/token ), .A1(n6736), 
        .B0(\fifo_from_fft/fifo_cell11/data_out/N35 ), .Y(n5656) );
  AO21X1TS U3831 ( .A0(\fifo_from_fft/fifo_cell10/reg_gtok/token ), .A1(n6739), 
        .B0(\fifo_from_fft/fifo_cell10/data_out/N35 ), .Y(n5657) );
  AO21X1TS U3832 ( .A0(\fifo_from_fft/fifo_cell9/reg_gtok/token ), .A1(n6737), 
        .B0(\fifo_from_fft/fifo_cell9/data_out/N35 ), .Y(n5658) );
  AO21X1TS U3833 ( .A0(\fifo_from_fft/fifo_cell8/reg_gtok/token ), .A1(n6738), 
        .B0(\fifo_from_fft/fifo_cell8/data_out/N35 ), .Y(n5659) );
  AO21X1TS U3834 ( .A0(\fifo_from_fft/fifo_cell7/reg_gtok/token ), .A1(n6738), 
        .B0(\fifo_from_fft/fifo_cell7/data_out/N35 ), .Y(n5660) );
  AO21X1TS U3835 ( .A0(\fifo_from_fft/fifo_cell6/reg_gtok/token ), .A1(n6739), 
        .B0(\fifo_from_fft/fifo_cell6/data_out/N35 ), .Y(n5661) );
  AO21X1TS U3836 ( .A0(\fifo_from_fft/fifo_cell5/reg_gtok/token ), .A1(n6739), 
        .B0(\fifo_from_fft/fifo_cell5/data_out/N35 ), .Y(n5662) );
  OAI2BB1X1TS U3837 ( .A0N(\fifo_from_fir/fifo_cell15/reg_gtok/token ), .A1N(
        n6744), .B0(n7539), .Y(n5793) );
  OAI2BB1X1TS U3838 ( .A0N(\fifo_from_fft/fifo_cell15/reg_gtok/token ), .A1N(
        n6739), .B0(n7616), .Y(n5652) );
  INVX2TS U3839 ( .A(n7435), .Y(n7417) );
  NAND2X1TS U3840 ( .A(\mips/mips/accbypass ), .B(n7393), .Y(\mips/mips/a/N49 ) );
  NOR3X1TS U3841 ( .A(n7338), .B(n7362), .C(n7333), .Y(\router/data_cntl/N160 ) );
  CLKBUFX2TS U3842 ( .A(n7067), .Y(n7066) );
  CLKBUFX2TS U3843 ( .A(n6893), .Y(n7069) );
  AND2X2TS U3844 ( .A(n7071), .B(\fifo_from_fir/fifo_cell0/reg_gtok/token ), 
        .Y(\fifo_from_fir/fifo_cell1/data_out/N35 ) );
  AND2X2TS U3845 ( .A(n7071), .B(\fifo_from_fir/fifo_cell1/reg_gtok/token ), 
        .Y(\fifo_from_fir/fifo_cell2/data_out/N35 ) );
  AND2X2TS U3846 ( .A(n7072), .B(\fifo_from_fir/fifo_cell2/reg_gtok/token ), 
        .Y(\fifo_from_fir/fifo_cell3/data_out/N35 ) );
  AND2X2TS U3847 ( .A(n7071), .B(\fifo_from_fir/fifo_cell3/reg_gtok/token ), 
        .Y(\fifo_from_fir/fifo_cell4/data_out/N35 ) );
  AND2X2TS U3848 ( .A(n7070), .B(\fifo_from_fir/fifo_cell4/reg_gtok/token ), 
        .Y(\fifo_from_fir/fifo_cell5/data_out/N35 ) );
  AND2X2TS U3849 ( .A(n7072), .B(\fifo_from_fir/fifo_cell5/reg_gtok/token ), 
        .Y(\fifo_from_fir/fifo_cell6/data_out/N35 ) );
  AND2X2TS U3850 ( .A(n7072), .B(\fifo_from_fir/fifo_cell6/reg_gtok/token ), 
        .Y(\fifo_from_fir/fifo_cell7/data_out/N35 ) );
  AND2X2TS U3851 ( .A(n7073), .B(\fifo_from_fir/fifo_cell7/reg_gtok/token ), 
        .Y(\fifo_from_fir/fifo_cell8/data_out/N35 ) );
  AND2X2TS U3852 ( .A(n7072), .B(\fifo_from_fir/fifo_cell8/reg_gtok/token ), 
        .Y(\fifo_from_fir/fifo_cell9/data_out/N35 ) );
  AND2X2TS U3853 ( .A(n7071), .B(\fifo_from_fir/fifo_cell13/reg_gtok/token ), 
        .Y(\fifo_from_fir/fifo_cell14/data_out/N35 ) );
  AND2X2TS U3854 ( .A(n7081), .B(\fifo_from_fft/fifo_cell0/reg_gtok/token ), 
        .Y(\fifo_from_fft/fifo_cell1/data_out/N35 ) );
  AND2X2TS U3855 ( .A(n7081), .B(\fifo_from_fft/fifo_cell1/reg_gtok/token ), 
        .Y(\fifo_from_fft/fifo_cell2/data_out/N35 ) );
  AND2X2TS U3856 ( .A(n7082), .B(\fifo_from_fft/fifo_cell2/reg_gtok/token ), 
        .Y(\fifo_from_fft/fifo_cell3/data_out/N35 ) );
  AND2X2TS U3857 ( .A(n7081), .B(\fifo_from_fft/fifo_cell3/reg_gtok/token ), 
        .Y(\fifo_from_fft/fifo_cell4/data_out/N35 ) );
  AND2X2TS U3858 ( .A(n7080), .B(\fifo_from_fft/fifo_cell4/reg_gtok/token ), 
        .Y(\fifo_from_fft/fifo_cell5/data_out/N35 ) );
  AND2X2TS U3859 ( .A(n7082), .B(\fifo_from_fft/fifo_cell5/reg_gtok/token ), 
        .Y(\fifo_from_fft/fifo_cell6/data_out/N35 ) );
  AND2X2TS U3860 ( .A(n7082), .B(\fifo_from_fft/fifo_cell6/reg_gtok/token ), 
        .Y(\fifo_from_fft/fifo_cell7/data_out/N35 ) );
  AND2X2TS U3861 ( .A(n7083), .B(\fifo_from_fft/fifo_cell7/reg_gtok/token ), 
        .Y(\fifo_from_fft/fifo_cell8/data_out/N35 ) );
  AND2X2TS U3862 ( .A(n7082), .B(\fifo_from_fft/fifo_cell8/reg_gtok/token ), 
        .Y(\fifo_from_fft/fifo_cell9/data_out/N35 ) );
  AND2X2TS U3863 ( .A(n7081), .B(\fifo_from_fft/fifo_cell13/reg_gtok/token ), 
        .Y(\fifo_from_fft/fifo_cell14/data_out/N35 ) );
  CLKBUFX2TS U3864 ( .A(n7290), .Y(n7289) );
  CLKBUFX2TS U3865 ( .A(n7291), .Y(n7288) );
  CLKBUFX2TS U3866 ( .A(n7292), .Y(n7287) );
  CLKBUFX2TS U3867 ( .A(n7292), .Y(n7286) );
  CLKBUFX2TS U3868 ( .A(n7293), .Y(n7285) );
  CLKBUFX2TS U3869 ( .A(n7293), .Y(n7284) );
  CLKBUFX2TS U3870 ( .A(n6910), .Y(n6909) );
  NOR2X1TS U3871 ( .A(n6922), .B(n7621), .Y(n7653) );
  NOR2X1TS U3872 ( .A(n6922), .B(n7620), .Y(n7654) );
  CLKBUFX2TS U3873 ( .A(n7000), .Y(n6999) );
  CLKBUFX2TS U3874 ( .A(n6980), .Y(n6979) );
  CLKBUFX2TS U3875 ( .A(n6940), .Y(n6939) );
  CLKBUFX2TS U3876 ( .A(n6960), .Y(n6959) );
  AOI21X1TS U3877 ( .A0(n7818), .A1(n7817), .B0(n7008), .Y(n7850) );
  AOI21X1TS U3878 ( .A0(n7774), .A1(n7773), .B0(n6988), .Y(n7806) );
  CLKBUFX2TS U3879 ( .A(n7184), .Y(n7192) );
  AOI21X1TS U3880 ( .A0(n7730), .A1(n7729), .B0(n6968), .Y(n7762) );
  AOI21X1TS U3881 ( .A0(n7686), .A1(n7685), .B0(n6948), .Y(n7718) );
  CLKBUFX2TS U3882 ( .A(n7916), .Y(n7050) );
  CLKBUFX2TS U3883 ( .A(n7020), .Y(n7019) );
  AOI21X1TS U3884 ( .A0(n7862), .A1(n7861), .B0(n7028), .Y(n7894) );
  AND4X1TS U3885 ( .A(n7669), .B(\router/fir_put_req_reg ), .C(n7390), .D(
        n7907), .Y(n6893) );
  INVX2TS U3886 ( .A(n6684), .Y(n7902) );
  NOR4XLTS U3887 ( .A(n7672), .B(n6682), .C(\router/fir_read_done ), .D(n6683), 
        .Y(n7669) );
  NAND2X1TS U3888 ( .A(n7668), .B(n6733), .Y(n7606) );
  NOR2X1TS U3889 ( .A(n7358), .B(n7540), .Y(n7672) );
  CLKBUFX2TS U3890 ( .A(n7457), .Y(n7451) );
  CLKBUFX2TS U3891 ( .A(n6689), .Y(n7459) );
  CLKBUFX2TS U3892 ( .A(n7337), .Y(n7335) );
  CLKBUFX2TS U3893 ( .A(n7389), .Y(n7388) );
  CLKBUFX2TS U3894 ( .A(n7361), .Y(n7360) );
  NOR4XLTS U3895 ( .A(n7501), .B(n7502), .C(n7500), .D(n7499), .Y(n7461) );
  NOR4XLTS U3896 ( .A(n7498), .B(n7497), .C(n7496), .D(n7495), .Y(n7462) );
  NOR4XLTS U3897 ( .A(n7494), .B(n7493), .C(n7492), .D(n7491), .Y(n7463) );
  NOR4XLTS U3898 ( .A(n7490), .B(n7489), .C(n7488), .D(n7487), .Y(n7464) );
  NOR4XLTS U3899 ( .A(n7856), .B(n7855), .C(n7854), .D(n7853), .Y(n7862) );
  NOR4XLTS U3900 ( .A(n7812), .B(n7811), .C(n7810), .D(n7809), .Y(n7818) );
  NOR4XLTS U3901 ( .A(n7680), .B(n7679), .C(n7678), .D(n7677), .Y(n7686) );
  NOR4XLTS U3902 ( .A(n7768), .B(n7767), .C(n7766), .D(n7765), .Y(n7774) );
  NOR4XLTS U3903 ( .A(n7724), .B(n7723), .C(n7722), .D(n7721), .Y(n7730) );
  NOR4XLTS U3904 ( .A(n6854), .B(n6850), .C(n6843), .D(n6847), .Y(n6840) );
  NOR4XLTS U3905 ( .A(n6853), .B(n6848), .C(n6845), .D(n6851), .Y(n6841) );
  NOR4XLTS U3906 ( .A(n6852), .B(n6834), .C(n6844), .D(n6849), .Y(n6842) );
  NOR4XLTS U3907 ( .A(n7860), .B(n7859), .C(n7858), .D(n7857), .Y(n7861) );
  NOR4XLTS U3908 ( .A(n7816), .B(n7815), .C(n7814), .D(n7813), .Y(n7817) );
  NOR4XLTS U3909 ( .A(n7684), .B(n7683), .C(n7682), .D(n7681), .Y(n7685) );
  NOR4XLTS U3910 ( .A(n7772), .B(n7771), .C(n7770), .D(n7769), .Y(n7773) );
  NOR4XLTS U3911 ( .A(n7728), .B(n7727), .C(n7726), .D(n7725), .Y(n7729) );
  AOI222XLTS U3912 ( .A0(n6925), .A1(\router/data_cntl/data_in[16] ), .B0(
        n6915), .B1(fir_data_in[16]), .C0(n6904), .C1(fft_data_in[16]), .Y(
        n7638) );
  AOI222XLTS U3913 ( .A0(n6928), .A1(\router/data_cntl/data_in[5] ), .B0(n6918), .B1(fir_data_in[5]), .C0(n6911), .C1(fft_data_in[5]), .Y(n7627) );
  NOR4XLTS U3914 ( .A(n6682), .B(\router/iir_read_done ), .C(
        \router/iir_write_done ), .D(n7906), .Y(n5957) );
  NOR3BX1TS U3915 ( .AN(n7670), .B(n7669), .C(n5957), .Y(n7674) );
  AOI222XLTS U3916 ( .A0(n6926), .A1(\router/data_cntl/data_in[9] ), .B0(n6917), .B1(fir_data_in[9]), .C0(n6906), .C1(fft_data_in[9]), .Y(n7631) );
  AOI222XLTS U3917 ( .A0(n6923), .A1(\router/data_cntl/data_in[28] ), .B0(
        n6912), .B1(fir_data_in[28]), .C0(n6910), .C1(fft_data_in[28]), .Y(
        n7650) );
  NOR3X1TS U3918 ( .A(instruction[15]), .B(instruction[14]), .C(
        instruction[16]), .Y(n5958) );
  NOR4XLTS U3919 ( .A(instruction[17]), .B(instruction[12]), .C(
        instruction[10]), .D(instruction[11]), .Y(n5959) );
  NOR4XLTS U3920 ( .A(instruction[5]), .B(instruction[6]), .C(instruction[20]), 
        .D(instruction[21]), .Y(n5960) );
  NOR4XLTS U3921 ( .A(instruction[7]), .B(instruction[9]), .C(instruction[4]), 
        .D(instruction[8]), .Y(n5961) );
  NOR4XLTS U3922 ( .A(instruction[13]), .B(instruction[22]), .C(
        instruction[23]), .D(instruction[24]), .Y(n5962) );
  NOR4BX1TS U3923 ( .AN(\router/pla_top/instruction_valid ), .B(
        instruction[19]), .C(instruction[25]), .D(instruction[18]), .Y(n5963)
         );
  NAND4X1TS U3924 ( .A(n5960), .B(n5961), .C(n5962), .D(n5963), .Y(n5964) );
  NOR3X1TS U3925 ( .A(instruction[3]), .B(n7911), .C(n5964), .Y(n5965) );
  NAND4X1TS U3926 ( .A(instruction[27]), .B(n5958), .C(n5959), .D(n5965), .Y(
        n7519) );
  AND4X1TS U3927 ( .A(\fifo_from_fir/fifo_cell2/controller/f_i_get ), .B(
        \fifo_from_fir/fifo_cell5/controller/f_i_get ), .C(
        \fifo_from_fir/fifo_cell4/controller/f_i_get ), .D(
        \fifo_from_fir/fifo_cell6/controller/f_i_get ), .Y(n5966) );
  NAND4X1TS U3928 ( .A(n7391), .B(
        \fifo_from_fir/fifo_cell7/controller/f_i_get ), .C(
        \fifo_from_fir/fifo_cell9/controller/f_i_get ), .D(
        \fifo_from_fir/fifo_cell8/controller/f_i_get ), .Y(n5967) );
  NAND4X1TS U3929 ( .A(\fifo_from_fir/fifo_cell0/controller/f_i_get ), .B(
        \fifo_from_fir/fifo_cell1/controller/f_i_get ), .C(
        \fifo_from_fir/fifo_cell11/controller/f_i_get ), .D(
        \fifo_from_fir/fifo_cell13/controller/f_i_get ), .Y(n5968) );
  NAND4X1TS U3930 ( .A(\fifo_from_fir/fifo_cell12/controller/f_i_get ), .B(
        \fifo_from_fir/fifo_cell15/controller/f_i_get ), .C(
        \fifo_from_fir/fifo_cell14/controller/f_i_get ), .D(
        \fifo_from_fir/fifo_cell3/controller/f_i_get ), .Y(n5969) );
  NOR4BX1TS U3931 ( .AN(\fifo_from_fir/fifo_cell10/controller/f_i_get ), .B(
        n5967), .C(n5968), .D(n5969), .Y(n5970) );
  NOR4XLTS U3932 ( .A(\fifo_from_fir/hold[6] ), .B(\fifo_from_fir/hold[7] ), 
        .C(\fifo_from_fir/hold[8] ), .D(\fifo_from_fir/hold[9] ), .Y(n5971) );
  NOR4XLTS U3933 ( .A(\fifo_from_fir/hold[2] ), .B(\fifo_from_fir/hold[3] ), 
        .C(\fifo_from_fir/hold[4] ), .D(\fifo_from_fir/hold[5] ), .Y(n5972) );
  NOR4XLTS U3934 ( .A(\fifo_from_fir/hold[13] ), .B(\fifo_from_fir/hold[14] ), 
        .C(\fifo_from_fir/hold[15] ), .D(\fifo_from_fir/hold[1] ), .Y(n5973)
         );
  NOR4XLTS U3935 ( .A(\fifo_from_fir/hold[0] ), .B(\fifo_from_fir/hold[10] ), 
        .C(\fifo_from_fir/hold[11] ), .D(\fifo_from_fir/hold[12] ), .Y(n5974)
         );
  NAND4X1TS U3936 ( .A(n5971), .B(n5972), .C(n5973), .D(n5974), .Y(n5975) );
  AOI22X1TS U3937 ( .A0(n5966), .A1(n5970), .B0(n7390), .B1(n5975), .Y(n7901)
         );
  NOR2X1TS U3938 ( .A(n6681), .B(\router/fft_read_done ), .Y(n5976) );
  NOR4XLTS U3939 ( .A(n5976), .B(from_fft_empty), .C(n7541), .D(n7537), .Y(
        n4699) );
  AOI222XLTS U3940 ( .A0(n6926), .A1(\router/data_cntl/data_in[7] ), .B0(n6918), .B1(fir_data_in[7]), .C0(n6908), .C1(fft_data_in[7]), .Y(n7629) );
  AOI222XLTS U3941 ( .A0(n6923), .A1(\router/data_cntl/data_in[26] ), .B0(
        n6913), .B1(fir_data_in[26]), .C0(n6902), .C1(fft_data_in[26]), .Y(
        n7648) );
  AOI22X1TS U3942 ( .A0(\fifo_to_fir/hang[1] ), .A1(\fifo_to_fir/hang[0] ), 
        .B0(n6464), .B1(n6448), .Y(n5977) );
  AOI22X1TS U3943 ( .A0(n7061), .A1(n5977), .B0(n7060), .B1(
        \fifo_to_fir/tok_xnor_put ), .Y(n5978) );
  AOI22X1TS U3944 ( .A0(\fifo_to_fir/hang[5] ), .A1(\fifo_to_fir/hang[4] ), 
        .B0(n6472), .B1(n6468), .Y(n5979) );
  AOI22X1TS U3945 ( .A0(\fifo_to_fir/hang[8] ), .A1(\fifo_to_fir/hang[7] ), 
        .B0(n6484), .B1(n6480), .Y(n5980) );
  XOR2X1TS U3946 ( .A(n5979), .B(\fifo_to_fir/hang[3] ), .Y(n5981) );
  XOR2X1TS U3947 ( .A(n5980), .B(n5981), .Y(n5982) );
  XOR2X1TS U3948 ( .A(n5982), .B(\fifo_to_fir/hang[9] ), .Y(n5983) );
  AOI22X1TS U3949 ( .A0(\fifo_to_fir/hang[11] ), .A1(\fifo_to_fir/hang[12] ), 
        .B0(n6456), .B1(n6460), .Y(n5984) );
  XOR2X1TS U3950 ( .A(n5984), .B(\fifo_to_fir/hang[13] ), .Y(n5985) );
  XOR2X1TS U3951 ( .A(n5985), .B(\fifo_to_fir/hang[2] ), .Y(n5986) );
  OAI22X1TS U3952 ( .A0(\fifo_to_fir/hang[6] ), .A1(\fifo_to_fir/hang[10] ), 
        .B0(n6452), .B1(n6476), .Y(n5987) );
  NOR2BX1TS U3953 ( .AN(n7067), .B(n5987), .Y(n5988) );
  OAI21X1TS U3954 ( .A0(n5983), .A1(n5986), .B0(n7061), .Y(n5989) );
  AOI21X1TS U3955 ( .A0(n5983), .A1(n5986), .B0(n5989), .Y(n5990) );
  XOR2X1TS U3956 ( .A(n5988), .B(n5990), .Y(n5991) );
  OAI21X1TS U3957 ( .A0(n5978), .A1(n5991), .B0(n7392), .Y(n5992) );
  AOI21X1TS U3958 ( .A0(n5978), .A1(n5991), .B0(n5992), .Y(n7614) );
  NAND4BX1TS U3959 ( .AN(n7535), .B(n7530), .C(n7523), .D(acc_done), .Y(n5993)
         );
  NAND2X1TS U3960 ( .A(\router/iir_read_done ), .B(\router/iir_write_done ), 
        .Y(n5994) );
  AOI222XLTS U3961 ( .A0(n7525), .A1(n5993), .B0(n7525), .B1(n7524), .C0(n5993), .C1(n5994), .Y(n5995) );
  AOI31X1TS U3962 ( .A0(n6732), .A1(n7529), .A2(\router/fir_write_done ), .B0(
        n5995), .Y(n5996) );
  NAND3X1TS U3963 ( .A(\router/fft_write_done ), .B(n7531), .C(
        \router/fft_read_done ), .Y(n5997) );
  AOI21X1TS U3964 ( .A0(n5996), .A1(n5997), .B0(n7449), .Y(n5943) );
  AOI222XLTS U3965 ( .A0(n6931), .A1(\router/data_cntl/data_in[13] ), .B0(
        n6916), .B1(fir_data_in[13]), .C0(n6905), .C1(fft_data_in[13]), .Y(
        n7635) );
  AOI222XLTS U3966 ( .A0(n6927), .A1(\router/data_cntl/data_in[3] ), .B0(n6919), .B1(fir_data_in[3]), .C0(n6907), .C1(fft_data_in[3]), .Y(n7625) );
  AOI222XLTS U3967 ( .A0(n6924), .A1(\router/data_cntl/data_in[24] ), .B0(
        n6913), .B1(fir_data_in[24]), .C0(n6902), .C1(fft_data_in[24]), .Y(
        n7646) );
  NAND4BBX1TS U3968 ( .AN(\router/fft_get_req_reg ), .BN(n6669), .C(
        \router/iir_get_req_reg ), .D(n6734), .Y(n7657) );
  AND4X1TS U3969 ( .A(instruction[26]), .B(instruction[28]), .C(
        instruction[29]), .D(instruction[0]), .Y(n5998) );
  NAND3X1TS U3970 ( .A(instruction[30]), .B(n5998), .C(instruction[31]), .Y(
        n7911) );
  NOR4XLTS U3971 ( .A(n7478), .B(n7480), .C(n7479), .D(n7481), .Y(n5999) );
  NOR4XLTS U3972 ( .A(n7474), .B(n7475), .C(n7477), .D(n7476), .Y(n6000) );
  NOR4XLTS U3973 ( .A(n7470), .B(n7471), .C(n7473), .D(n7472), .Y(n6001) );
  NOR4XLTS U3974 ( .A(n7466), .B(n7467), .C(n7468), .D(n7469), .Y(n6002) );
  NAND4X1TS U3975 ( .A(n5999), .B(n6000), .C(n6001), .D(n6002), .Y(n7899) );
  XOR2X1TS U3976 ( .A(\add_x_22_5/carry[31] ), .B(n6137), .Y(n6003) );
  AOI22X1TS U3977 ( .A0(n7017), .A1(n6003), .B0(n7025), .B1(n6401), .Y(n6004)
         );
  NAND2X1TS U3978 ( .A(n7317), .B(n6004), .Y(
        \router/addr_calc/iir_write_calc/counter/N209 ) );
  NOR4XLTS U3979 ( .A(\router/addr_calc/iir_read_calc/count[29] ), .B(
        \router/addr_calc/iir_read_calc/count[31] ), .C(
        \router/addr_calc/iir_read_calc/count[0] ), .D(
        \router/addr_calc/iir_read_calc/count[28] ), .Y(n6005) );
  NOR4XLTS U3980 ( .A(\router/addr_calc/iir_read_calc/count[12] ), .B(
        \router/addr_calc/iir_read_calc/count[10] ), .C(
        \router/addr_calc/iir_read_calc/count[13] ), .D(
        \router/addr_calc/iir_read_calc/count[11] ), .Y(n6006) );
  OR4X1TS U3981 ( .A(\router/addr_calc/iir_read_calc/count[6] ), .B(
        \router/addr_calc/iir_read_calc/count[8] ), .C(
        \router/addr_calc/iir_read_calc/count[9] ), .D(
        \router/addr_calc/iir_read_calc/count[7] ), .Y(n6007) );
  NOR4BX1TS U3982 ( .AN(\router/addr_calc/iir_read_calc/count[3] ), .B(
        \router/addr_calc/iir_read_calc/count[5] ), .C(
        \router/addr_calc/iir_read_calc/count[4] ), .D(n6007), .Y(n6008) );
  NAND4X1TS U3983 ( .A(\router/addr_calc/iir_read_calc/count[2] ), .B(n6005), 
        .C(n6006), .D(n6008), .Y(n6009) );
  NOR4XLTS U3984 ( .A(\router/addr_calc/iir_read_calc/count[18] ), .B(
        \router/addr_calc/iir_read_calc/count[20] ), .C(
        \router/addr_calc/iir_read_calc/count[21] ), .D(
        \router/addr_calc/iir_read_calc/count[19] ), .Y(n6010) );
  NOR4XLTS U3985 ( .A(\router/addr_calc/iir_read_calc/count[14] ), .B(
        \router/addr_calc/iir_read_calc/count[16] ), .C(
        \router/addr_calc/iir_read_calc/count[17] ), .D(
        \router/addr_calc/iir_read_calc/count[15] ), .Y(n6011) );
  NOR4BX1TS U3986 ( .AN(\router/addr_calc/iir_read_calc/count[1] ), .B(
        \router/addr_calc/iir_read_calc/count[26] ), .C(
        \router/addr_calc/iir_read_calc/count[30] ), .D(
        \router/addr_calc/iir_read_calc/count[27] ), .Y(n6012) );
  NOR4XLTS U3987 ( .A(\router/addr_calc/iir_read_calc/count[22] ), .B(
        \router/addr_calc/iir_read_calc/count[24] ), .C(
        \router/addr_calc/iir_read_calc/count[25] ), .D(
        \router/addr_calc/iir_read_calc/count[23] ), .Y(n6013) );
  NAND4X1TS U3988 ( .A(n6010), .B(n6011), .C(n6012), .D(n6013), .Y(n6014) );
  NOR3X1TS U3989 ( .A(n7334), .B(n6009), .C(n6014), .Y(n5944) );
  AOI222XLTS U3990 ( .A0(n6924), .A1(\router/data_cntl/data_in[22] ), .B0(
        n6914), .B1(fir_data_in[22]), .C0(n6903), .C1(fft_data_in[22]), .Y(
        n7644) );
  AOI222XLTS U3991 ( .A0(fir_data_in[0]), .A1(n6919), .B0(n6927), .B1(
        \router/data_cntl/data_in[0] ), .C0(fft_data_in[0]), .C1(n6907), .Y(
        n7622) );
  XOR2X1TS U3992 ( .A(\fifo_from_fir/fifo_cell8/data_out/N35 ), .B(
        \fifo_from_fir/fifo_cell9/data_out/N35 ), .Y(n6015) );
  XOR2X1TS U3993 ( .A(\fifo_from_fir/fifo_cell6/data_out/N35 ), .B(
        \fifo_from_fir/fifo_cell7/data_out/N35 ), .Y(n6016) );
  XOR2X1TS U3994 ( .A(n6015), .B(n6016), .Y(n6017) );
  XOR2X1TS U3995 ( .A(\fifo_from_fir/fifo_cell12/data_out/N35 ), .B(
        \fifo_from_fir/fifo_cell13/data_out/N35 ), .Y(n6018) );
  XOR2X1TS U3996 ( .A(\fifo_from_fir/fifo_cell10/data_out/N35 ), .B(
        \fifo_from_fir/fifo_cell11/data_out/N35 ), .Y(n6019) );
  XOR2X1TS U3997 ( .A(n6018), .B(n6019), .Y(n6020) );
  XOR2X1TS U3998 ( .A(n6017), .B(n6020), .Y(n6021) );
  XOR2X1TS U3999 ( .A(n7539), .B(\fifo_from_fir/fifo_cell14/data_out/N35 ), 
        .Y(n6022) );
  XOR2X1TS U4000 ( .A(n6021), .B(n6022), .Y(n6023) );
  XOR2X1TS U4001 ( .A(\fifo_from_fir/fifo_cell4/data_out/N35 ), .B(
        \fifo_from_fir/fifo_cell5/data_out/N35 ), .Y(n6024) );
  XOR2X1TS U4002 ( .A(\fifo_from_fir/fifo_cell2/data_out/N35 ), .B(
        \fifo_from_fir/fifo_cell3/data_out/N35 ), .Y(n6025) );
  XOR2X1TS U4003 ( .A(n6024), .B(n6025), .Y(n6026) );
  XOR2X1TS U4004 ( .A(\fifo_from_fir/fifo_cell1/data_out/N35 ), .B(n6026), .Y(
        n6027) );
  XOR2X1TS U4005 ( .A(n6023), .B(n6027), .Y(n6028) );
  OA21XLTS U4006 ( .A0(n6028), .A1(\fifo_from_fir/fifo_cell15/reg_gtok/token ), 
        .B0(n7070), .Y(\fifo_from_fir/fifo_cell0/data_out/N35 ) );
  XOR2X1TS U4007 ( .A(\fifo_from_fft/fifo_cell4/data_out/N35 ), .B(
        \fifo_from_fft/fifo_cell5/data_out/N35 ), .Y(n6029) );
  XOR2X1TS U4008 ( .A(\fifo_from_fft/fifo_cell2/data_out/N35 ), .B(
        \fifo_from_fft/fifo_cell3/data_out/N35 ), .Y(n6030) );
  XOR2X1TS U4009 ( .A(n6029), .B(n6030), .Y(n6031) );
  XOR2X1TS U4010 ( .A(\fifo_from_fft/fifo_cell12/data_out/N35 ), .B(
        \fifo_from_fft/fifo_cell13/data_out/N35 ), .Y(n6032) );
  XOR2X1TS U4011 ( .A(\fifo_from_fft/fifo_cell10/data_out/N35 ), .B(
        \fifo_from_fft/fifo_cell11/data_out/N35 ), .Y(n6033) );
  XOR2X1TS U4012 ( .A(n6032), .B(n6033), .Y(n6034) );
  XOR2X1TS U4013 ( .A(\fifo_from_fft/fifo_cell8/data_out/N35 ), .B(
        \fifo_from_fft/fifo_cell9/data_out/N35 ), .Y(n6035) );
  XOR2X1TS U4014 ( .A(\fifo_from_fft/fifo_cell6/data_out/N35 ), .B(
        \fifo_from_fft/fifo_cell7/data_out/N35 ), .Y(n6036) );
  XOR2X1TS U4015 ( .A(n6035), .B(n6036), .Y(n6037) );
  XOR2X1TS U4016 ( .A(n6037), .B(n6034), .Y(n6038) );
  XOR2X1TS U4017 ( .A(n7616), .B(\fifo_from_fft/fifo_cell14/data_out/N35 ), 
        .Y(n6039) );
  XOR2X1TS U4018 ( .A(n6038), .B(n6039), .Y(n6040) );
  XOR2X1TS U4019 ( .A(\fifo_from_fft/fifo_cell1/data_out/N35 ), .B(n6031), .Y(
        n6041) );
  XOR2X1TS U4020 ( .A(n6040), .B(n6041), .Y(n6042) );
  OA21XLTS U4021 ( .A0(n6042), .A1(\fifo_from_fft/fifo_cell15/reg_gtok/token ), 
        .B0(n7080), .Y(\fifo_from_fft/fifo_cell0/data_out/N35 ) );
  NOR4XLTS U4022 ( .A(\fifo_from_fir/fifo_cell9/controller/f_i_get ), .B(
        \fifo_from_fir/fifo_cell0/controller/f_i_get ), .C(
        \fifo_from_fir/fifo_cell8/controller/f_i_get ), .D(
        \fifo_from_fir/fifo_cell10/controller/f_i_get ), .Y(n6043) );
  NOR4XLTS U4023 ( .A(\fifo_from_fir/fifo_cell1/controller/f_i_get ), .B(
        \fifo_from_fir/fifo_cell11/controller/f_i_get ), .C(
        \fifo_from_fir/fifo_cell12/controller/f_i_get ), .D(
        \fifo_from_fir/fifo_cell13/controller/f_i_get ), .Y(n6044) );
  NOR4XLTS U4024 ( .A(\fifo_from_fir/fifo_cell15/controller/f_i_get ), .B(
        \fifo_from_fir/fifo_cell14/controller/f_i_get ), .C(
        \fifo_from_fir/fifo_cell2/controller/f_i_get ), .D(
        \fifo_from_fir/fifo_cell3/controller/f_i_get ), .Y(n6045) );
  NOR4XLTS U4025 ( .A(\fifo_from_fir/fifo_cell7/controller/f_i_get ), .B(
        \fifo_from_fir/fifo_cell5/controller/f_i_get ), .C(
        \fifo_from_fir/fifo_cell4/controller/f_i_get ), .D(
        \fifo_from_fir/fifo_cell6/controller/f_i_get ), .Y(n6046) );
  NAND4X1TS U4026 ( .A(n6043), .B(n6044), .C(n6045), .D(n6046), .Y(n5575) );
  NOR4XLTS U4027 ( .A(\fifo_from_fft/fifo_cell9/controller/f_i_get ), .B(
        \fifo_from_fft/fifo_cell0/controller/f_i_get ), .C(
        \fifo_from_fft/fifo_cell8/controller/f_i_get ), .D(
        \fifo_from_fft/fifo_cell10/controller/f_i_get ), .Y(n6047) );
  NOR4XLTS U4028 ( .A(\fifo_from_fft/fifo_cell1/controller/f_i_get ), .B(
        \fifo_from_fft/fifo_cell11/controller/f_i_get ), .C(
        \fifo_from_fft/fifo_cell12/controller/f_i_get ), .D(
        \fifo_from_fft/fifo_cell13/controller/f_i_get ), .Y(n6048) );
  NOR4XLTS U4029 ( .A(\fifo_from_fft/fifo_cell15/controller/f_i_get ), .B(
        \fifo_from_fft/fifo_cell14/controller/f_i_get ), .C(
        \fifo_from_fft/fifo_cell2/controller/f_i_get ), .D(
        \fifo_from_fft/fifo_cell3/controller/f_i_get ), .Y(n6049) );
  NOR4XLTS U4030 ( .A(\fifo_from_fft/fifo_cell7/controller/f_i_get ), .B(
        \fifo_from_fft/fifo_cell5/controller/f_i_get ), .C(
        \fifo_from_fft/fifo_cell4/controller/f_i_get ), .D(
        \fifo_from_fft/fifo_cell6/controller/f_i_get ), .Y(n6050) );
  NAND4X1TS U4031 ( .A(n6047), .B(n6048), .C(n6049), .D(n6050), .Y(n5595) );
  CLKBUFX2TS U4032 ( .A(n7655), .Y(n6931) );
  CLKBUFX2TS U4033 ( .A(n6931), .Y(n6928) );
  CLKBUFX2TS U4034 ( .A(n6930), .Y(n6929) );
  CLKBUFX2TS U4035 ( .A(n7361), .Y(n7359) );
  AND2X2TS U4036 ( .A(n7400), .B(n7060), .Y(n6750) );
  INVX2TS U4037 ( .A(n6674), .Y(n6733) );
  CLKBUFX2TS U4038 ( .A(n2633), .Y(n7134) );
  CLKBUFX2TS U4039 ( .A(n1609), .Y(n7181) );
  CLKBUFX2TS U4040 ( .A(n7360), .Y(n7357) );
  CLKBUFX2TS U4041 ( .A(n7453), .Y(n7437) );
  INVXLTS U4042 ( .A(\router/addr_calc/N95 ), .Y(n6201) );
  INVXLTS U4043 ( .A(\router/addr_calc/N99 ), .Y(n6202) );
  INVXLTS U4044 ( .A(\router/addr_calc/N63 ), .Y(n6203) );
  INVXLTS U4045 ( .A(n6204), .Y(n6205) );
  INVXLTS U4046 ( .A(\router/addr_calc/N9 ), .Y(n6206) );
  CLKBUFX2TS U4047 ( .A(n7192), .Y(n7188) );
  CLKBUFX2TS U4048 ( .A(n7192), .Y(n7189) );
  CLKBUFX2TS U4049 ( .A(n7184), .Y(n7187) );
  NAND4X1TS U4050 ( .A(n4725), .B(n6897), .C(n6894), .D(n7917), .Y(n1545) );
  CLKBUFX2TS U4051 ( .A(n1545), .Y(n7184) );
  CLKBUFX2TS U4052 ( .A(n7192), .Y(n7190) );
  CLKBUFX2TS U4053 ( .A(n7193), .Y(n7186) );
  CLKBUFX2TS U4054 ( .A(n1545), .Y(n7185) );
  CLKBUFX2TS U4055 ( .A(n7192), .Y(n7191) );
  CLKBUFX2TS U4056 ( .A(n7185), .Y(n7193) );
  AOI22X1TS U4061 ( .A0(n6525), .A1(n6985), .B0(n6978), .B1(
        \router/addr_calc/fir_read_calc/counter/N77 ), .Y(n7808) );
  AOI22X1TS U4062 ( .A0(n6621), .A1(n6945), .B0(n6938), .B1(
        \router/addr_calc/fft_read_calc/counter/N77 ), .Y(n7720) );
  AOI22X1TS U4063 ( .A0(n6467), .A1(n7005), .B0(n6998), .B1(
        \router/addr_calc/fir_write_calc/counter/N77 ), .Y(n7852) );
  AOI22X1TS U4064 ( .A0(\router/addr_calc/fft_write_calc/count[31] ), .A1(
        n6965), .B0(n6958), .B1(\router/addr_calc/fft_write_calc/counter/N77 ), 
        .Y(n7764) );
  AOI22X1TS U4065 ( .A0(\router/addr_calc/fir_write_calc/count[30] ), .A1(
        n7010), .B0(n7001), .B1(\router/addr_calc/fir_write_calc/counter/N76 ), 
        .Y(n7849) );
  AOI22X1TS U4066 ( .A0(n6573), .A1(n6970), .B0(n6961), .B1(
        \router/addr_calc/fft_write_calc/counter/N76 ), .Y(n7761) );
  AOI22X1TS U4067 ( .A0(\router/addr_calc/fft_read_calc/count[30] ), .A1(n6950), .B0(n6941), .B1(\router/addr_calc/fft_read_calc/counter/N76 ), .Y(n7717) );
  AOI22X1TS U4068 ( .A0(\router/addr_calc/fir_read_calc/count[30] ), .A1(n6990), .B0(n6981), .B1(\router/addr_calc/fir_read_calc/counter/N76 ), .Y(n7805) );
  AOI22X1TS U4069 ( .A0(\router/addr_calc/iir_write_calc/count[30] ), .A1(
        n7029), .B0(n7017), .B1(\router/addr_calc/iir_write_calc/counter/N76 ), 
        .Y(n7893) );
  AOI22X1TS U4070 ( .A0(n6575), .A1(n7763), .B0(n6961), .B1(
        \router/addr_calc/fft_write_calc/counter/N75 ), .Y(n7760) );
  AOI22X1TS U4071 ( .A0(n6471), .A1(n7851), .B0(n7001), .B1(
        \router/addr_calc/fir_write_calc/counter/N75 ), .Y(n7848) );
  AOI22X1TS U4072 ( .A0(n6397), .A1(n7029), .B0(n7017), .B1(
        \router/addr_calc/iir_write_calc/counter/N75 ), .Y(n7892) );
  AOI22X1TS U4073 ( .A0(n6623), .A1(n7719), .B0(n6941), .B1(
        \router/addr_calc/fft_read_calc/counter/N75 ), .Y(n7716) );
  AOI22X1TS U4074 ( .A0(n6527), .A1(n7807), .B0(n6981), .B1(
        \router/addr_calc/fir_read_calc/counter/N75 ), .Y(n7804) );
  AOI22X1TS U4075 ( .A0(\router/addr_calc/fft_write_calc/count[28] ), .A1(
        n6969), .B0(n6961), .B1(\router/addr_calc/fft_write_calc/counter/N74 ), 
        .Y(n7759) );
  AOI22X1TS U4076 ( .A0(n6393), .A1(n7029), .B0(n7017), .B1(
        \router/addr_calc/iir_write_calc/counter/N74 ), .Y(n7891) );
  AOI22X1TS U4077 ( .A0(n6625), .A1(n6949), .B0(n6941), .B1(
        \router/addr_calc/fft_read_calc/counter/N74 ), .Y(n7715) );
  AOI22X1TS U4078 ( .A0(n6529), .A1(n6989), .B0(n6981), .B1(
        \router/addr_calc/fir_read_calc/counter/N74 ), .Y(n7803) );
  AOI22X1TS U4079 ( .A0(n6475), .A1(n7009), .B0(n7001), .B1(
        \router/addr_calc/fir_write_calc/counter/N74 ), .Y(n7847) );
  AOI22X1TS U4080 ( .A0(\router/addr_calc/fir_read_calc/count[27] ), .A1(n6990), .B0(n6977), .B1(\router/addr_calc/fir_read_calc/counter/N73 ), .Y(n7802) );
  AOI22X1TS U4081 ( .A0(\router/addr_calc/fft_write_calc/count[27] ), .A1(
        n6970), .B0(n6957), .B1(\router/addr_calc/fft_write_calc/counter/N73 ), 
        .Y(n7758) );
  AOI22X1TS U4082 ( .A0(\router/addr_calc/fft_read_calc/count[27] ), .A1(n6950), .B0(n6937), .B1(\router/addr_calc/fft_read_calc/counter/N73 ), .Y(n7714) );
  AOI22X1TS U4083 ( .A0(\router/addr_calc/iir_write_calc/count[27] ), .A1(
        n7895), .B0(n7021), .B1(\router/addr_calc/iir_write_calc/counter/N73 ), 
        .Y(n7890) );
  AOI22X1TS U4084 ( .A0(\router/addr_calc/fir_write_calc/count[27] ), .A1(
        n7010), .B0(n6997), .B1(\router/addr_calc/fir_write_calc/counter/N73 ), 
        .Y(n7846) );
  AOI22X1TS U4085 ( .A0(n6531), .A1(n6982), .B0(n6977), .B1(
        \router/addr_calc/fir_read_calc/counter/N72 ), .Y(n7801) );
  AOI22X1TS U4086 ( .A0(n6577), .A1(n6962), .B0(n6957), .B1(
        \router/addr_calc/fft_write_calc/counter/N72 ), .Y(n7757) );
  AOI22X1TS U4087 ( .A0(n6627), .A1(n6942), .B0(n6937), .B1(
        \router/addr_calc/fft_read_calc/counter/N72 ), .Y(n7713) );
  AOI22X1TS U4088 ( .A0(n6479), .A1(n7002), .B0(n6997), .B1(
        \router/addr_calc/fir_write_calc/counter/N72 ), .Y(n7845) );
  AOI22X1TS U4089 ( .A0(n6389), .A1(n7022), .B0(n7021), .B1(
        \router/addr_calc/iir_write_calc/counter/N72 ), .Y(n7889) );
  CLKINVX1TS U4090 ( .A(n7643), .Y(n5612) );
  CLKINVX1TS U4091 ( .A(n7623), .Y(n5632) );
  CLKINVX1TS U4092 ( .A(n7636), .Y(n5619) );
  CLKINVX1TS U4093 ( .A(n7648), .Y(n5607) );
  CLKINVX1TS U4094 ( .A(n7631), .Y(n5624) );
  CLKINVX1TS U4095 ( .A(n7638), .Y(n5617) );
  CLKINVX1TS U4096 ( .A(n7630), .Y(n5625) );
  CLKINVX1TS U4097 ( .A(n7625), .Y(n5630) );
  CLKINVX1TS U4098 ( .A(n7632), .Y(n5623) );
  CLKINVX1TS U4099 ( .A(n7640), .Y(n5615) );
  CLKINVX1TS U4100 ( .A(n7651), .Y(n5604) );
  CLKINVX1TS U4101 ( .A(n7650), .Y(n5605) );
  CLKINVX1TS U4102 ( .A(n7637), .Y(n5618) );
  CLKINVX1TS U4103 ( .A(n7624), .Y(n5631) );
  CLKINVX1TS U4104 ( .A(n7634), .Y(n5621) );
  CLKINVX1TS U4105 ( .A(n7646), .Y(n5609) );
  CLKINVX1TS U4106 ( .A(n7652), .Y(n5603) );
  CLKINVX1TS U4107 ( .A(n7633), .Y(n5622) );
  CLKINVX1TS U4108 ( .A(n7641), .Y(n5614) );
  CLKINVX1TS U4109 ( .A(n7645), .Y(n5610) );
  CLKINVX1TS U4110 ( .A(n7644), .Y(n5611) );
  CLKINVX1TS U4111 ( .A(n7622), .Y(n5633) );
  CLKINVX1TS U4112 ( .A(n7635), .Y(n5620) );
  CLKINVX1TS U4113 ( .A(n7649), .Y(n5606) );
  CLKINVX1TS U4114 ( .A(n7642), .Y(n5613) );
  CLKINVX1TS U4115 ( .A(n7647), .Y(n5608) );
  CLKINVX1TS U4116 ( .A(n7639), .Y(n5616) );
  CLKINVX1TS U4117 ( .A(n7656), .Y(n5602) );
  AOI22X1TS U4118 ( .A0(n6533), .A1(n6982), .B0(n6977), .B1(
        \router/addr_calc/fir_read_calc/counter/N71 ), .Y(n7800) );
  AOI22X1TS U4119 ( .A0(n6483), .A1(n7002), .B0(n6997), .B1(
        \router/addr_calc/fir_write_calc/counter/N71 ), .Y(n7844) );
  AOI22X1TS U4120 ( .A0(n6579), .A1(n6962), .B0(n6957), .B1(
        \router/addr_calc/fft_write_calc/counter/N71 ), .Y(n7756) );
  AOI22X1TS U4121 ( .A0(n6629), .A1(n6942), .B0(n6937), .B1(
        \router/addr_calc/fft_read_calc/counter/N71 ), .Y(n7712) );
  AOI22X1TS U4122 ( .A0(n6387), .A1(n7022), .B0(n7021), .B1(
        \router/addr_calc/iir_write_calc/counter/N71 ), .Y(n7888) );
  CLKINVX1TS U4123 ( .A(n7629), .Y(n5626) );
  AOI22X1TS U4124 ( .A0(n6094), .A1(n6962), .B0(n6957), .B1(
        \router/addr_calc/fft_write_calc/counter/N70 ), .Y(n7755) );
  AOI22X1TS U4125 ( .A0(n6064), .A1(n6942), .B0(n6937), .B1(
        \router/addr_calc/fft_read_calc/counter/N70 ), .Y(n7711) );
  AOI22X1TS U4126 ( .A0(n6092), .A1(n7002), .B0(n6997), .B1(
        \router/addr_calc/fir_write_calc/counter/N70 ), .Y(n7843) );
  AOI22X1TS U4127 ( .A0(n6098), .A1(n7022), .B0(n7018), .B1(
        \router/addr_calc/iir_write_calc/counter/N70 ), .Y(n7887) );
  AOI22X1TS U4128 ( .A0(n6093), .A1(n6982), .B0(n6977), .B1(
        \router/addr_calc/fir_read_calc/counter/N70 ), .Y(n7799) );
  CLKINVX1TS U4129 ( .A(n7627), .Y(n5628) );
  CLKINVX1TS U4130 ( .A(n7628), .Y(n5627) );
  CLKINVX1TS U4131 ( .A(n7626), .Y(n5629) );
  AOI22X1TS U4132 ( .A0(\router/addr_calc/fir_write_calc/count[23] ), .A1(
        n7002), .B0(n6996), .B1(\router/addr_calc/fir_write_calc/counter/N69 ), 
        .Y(n7842) );
  AOI22X1TS U4133 ( .A0(\router/addr_calc/fft_read_calc/count[23] ), .A1(n6942), .B0(n6936), .B1(\router/addr_calc/fft_read_calc/counter/N69 ), .Y(n7710) );
  AOI22X1TS U4134 ( .A0(\router/addr_calc/fft_write_calc/count[23] ), .A1(
        n6962), .B0(n6956), .B1(\router/addr_calc/fft_write_calc/counter/N69 ), 
        .Y(n7754) );
  AOI22X1TS U4135 ( .A0(\router/addr_calc/iir_write_calc/count[23] ), .A1(
        n7022), .B0(n7016), .B1(\router/addr_calc/iir_write_calc/counter/N69 ), 
        .Y(n7886) );
  AOI22X1TS U4136 ( .A0(\router/addr_calc/fir_read_calc/count[23] ), .A1(n6982), .B0(n6976), .B1(\router/addr_calc/fir_read_calc/counter/N69 ), .Y(n7798) );
  AOI22X1TS U4137 ( .A0(n6127), .A1(n6943), .B0(n6936), .B1(
        \router/addr_calc/fft_read_calc/counter/N68 ), .Y(n7709) );
  AOI22X1TS U4138 ( .A0(n6129), .A1(n6963), .B0(n6956), .B1(
        \router/addr_calc/fft_write_calc/counter/N68 ), .Y(n7753) );
  AOI22X1TS U4139 ( .A0(n6145), .A1(n7023), .B0(n7016), .B1(
        \router/addr_calc/iir_write_calc/counter/N68 ), .Y(n7885) );
  AOI22X1TS U4140 ( .A0(n6128), .A1(n6983), .B0(n6976), .B1(
        \router/addr_calc/fir_read_calc/counter/N68 ), .Y(n7797) );
  AOI22X1TS U4141 ( .A0(n6126), .A1(n7003), .B0(n6996), .B1(
        \router/addr_calc/fir_write_calc/counter/N68 ), .Y(n7841) );
  AOI22X1TS U4142 ( .A0(n6063), .A1(n6983), .B0(n6976), .B1(
        \router/addr_calc/fir_read_calc/counter/N67 ), .Y(n7796) );
  AOI22X1TS U4143 ( .A0(n6080), .A1(n6943), .B0(n6936), .B1(
        \router/addr_calc/fft_read_calc/counter/N67 ), .Y(n7708) );
  AOI22X1TS U4144 ( .A0(n6399), .A1(n7023), .B0(n7016), .B1(
        \router/addr_calc/iir_write_calc/counter/N67 ), .Y(n7884) );
  AOI22X1TS U4145 ( .A0(n6079), .A1(n6963), .B0(n6956), .B1(
        \router/addr_calc/fft_write_calc/counter/N67 ), .Y(n7752) );
  AOI22X1TS U4146 ( .A0(n6078), .A1(n7003), .B0(n6996), .B1(
        \router/addr_calc/fir_write_calc/counter/N67 ), .Y(n7840) );
  NAND2XLTS U4147 ( .A(n7366), .B(n7750), .Y(
        \router/addr_calc/fft_write_calc/counter/N197 ) );
  AOI22X1TS U4148 ( .A0(n6587), .A1(n6963), .B0(n6956), .B1(
        \router/addr_calc/fft_write_calc/counter/N66 ), .Y(n7751) );
  AOI22X1TS U4149 ( .A0(n6493), .A1(n7003), .B0(n6996), .B1(
        \router/addr_calc/fir_write_calc/counter/N66 ), .Y(n7839) );
  NAND2XLTS U4150 ( .A(n7342), .B(n7838), .Y(
        \router/addr_calc/fir_write_calc/counter/N197 ) );
  AOI22X1TS U4151 ( .A0(n6637), .A1(n6943), .B0(n6936), .B1(
        \router/addr_calc/fft_read_calc/counter/N66 ), .Y(n7707) );
  AOI22X1TS U4152 ( .A0(n6541), .A1(n6983), .B0(n6976), .B1(
        \router/addr_calc/fir_read_calc/counter/N66 ), .Y(n7795) );
  NAND2XLTS U4153 ( .A(n7342), .B(n7834), .Y(
        \router/addr_calc/fir_write_calc/counter/N193 ) );
  AOI22X1TS U4154 ( .A0(n6403), .A1(n7023), .B0(n7016), .B1(
        \router/addr_calc/iir_write_calc/counter/N66 ), .Y(n7883) );
  CLKINVX1TS U4155 ( .A(n7819), .Y(
        \router/addr_calc/fir_write_calc/counter/N178 ) );
  CLKINVX1TS U4156 ( .A(n7775), .Y(
        \router/addr_calc/fir_read_calc/counter/N178 ) );
  AOI22X1TS U4157 ( .A0(n6549), .A1(n6984), .B0(n6975), .B1(
        \router/addr_calc/fir_read_calc/counter/N61 ), .Y(n7790) );
  CLKINVX1TS U4158 ( .A(n7687), .Y(
        \router/addr_calc/fft_read_calc/counter/N178 ) );
  AOI22X1TS U4159 ( .A0(n6505), .A1(n7005), .B0(n6995), .B1(
        \router/addr_calc/fir_write_calc/counter/N58 ), .Y(n7831) );
  AOI22X1TS U4160 ( .A0(n6513), .A1(n7007), .B0(n6993), .B1(
        \router/addr_calc/fir_write_calc/counter/N53 ), .Y(n7826) );
  AOI22X1TS U4161 ( .A0(n6561), .A1(n6987), .B0(n6973), .B1(
        \router/addr_calc/fir_read_calc/counter/N53 ), .Y(n7782) );
  AOI22X1TS U4162 ( .A0(n6553), .A1(n6985), .B0(n6975), .B1(
        \router/addr_calc/fir_read_calc/counter/N58 ), .Y(n7787) );
  AOI22X1TS U4163 ( .A0(n6565), .A1(n6987), .B0(n6973), .B1(
        \router/addr_calc/fir_read_calc/counter/N50 ), .Y(n7779) );
  AOI22X1TS U4164 ( .A0(n6557), .A1(n6986), .B0(n6974), .B1(
        \router/addr_calc/fir_read_calc/counter/N56 ), .Y(n7785) );
  AOI22X1TS U4165 ( .A0(n6559), .A1(n6986), .B0(n6974), .B1(
        \router/addr_calc/fir_read_calc/counter/N54 ), .Y(n7783) );
  AOI221X1TS U4166 ( .A0(n6727), .A1(n6972), .B0(
        \router/addr_calc/fir_read_addr[0] ), .B1(n6988), .C0(n7355), .Y(n7775) );
  CLKINVX1TS U4167 ( .A(n7731), .Y(
        \router/addr_calc/fft_write_calc/counter/N178 ) );
  AOI221X1TS U4168 ( .A0(n6728), .A1(n6992), .B0(
        \router/addr_calc/fir_write_addr[0] ), .B1(n7008), .C0(n7354), .Y(
        n7819) );
  AOI22X1TS U4169 ( .A0(n6515), .A1(n7007), .B0(n6993), .B1(
        \router/addr_calc/fir_write_calc/counter/N52 ), .Y(n7825) );
  AOI22X1TS U4170 ( .A0(n6571), .A1(n6991), .B0(n6972), .B1(
        \router/addr_calc/fir_read_calc/counter/N47 ), .Y(n7776) );
  AOI22X1TS U4171 ( .A0(n6509), .A1(n7006), .B0(n6994), .B1(
        \router/addr_calc/fir_write_calc/counter/N56 ), .Y(n7829) );
  AOI22X1TS U4172 ( .A0(n6555), .A1(n6986), .B0(n6974), .B1(
        \router/addr_calc/fir_read_calc/counter/N57 ), .Y(n7786) );
  AOI22X1TS U4173 ( .A0(n6563), .A1(n6987), .B0(n6973), .B1(
        \router/addr_calc/fir_read_calc/counter/N52 ), .Y(n7781) );
  AOI22X1TS U4174 ( .A0(n6543), .A1(n6983), .B0(n6980), .B1(
        \router/addr_calc/fir_read_calc/counter/N65 ), .Y(n7794) );
  NAND2XLTS U4175 ( .A(n7373), .B(n7705), .Y(
        \router/addr_calc/fft_read_calc/counter/N196 ) );
  AOI22X1TS U4176 ( .A0(n6551), .A1(n6985), .B0(n6975), .B1(
        \router/addr_calc/fir_read_calc/counter/N59 ), .Y(n7788) );
  AOI22X1TS U4177 ( .A0(n6511), .A1(n7006), .B0(n6994), .B1(
        \router/addr_calc/fir_write_calc/counter/N54 ), .Y(n7827) );
  AOI22X1TS U4178 ( .A0(n6569), .A1(n6988), .B0(n6972), .B1(
        \router/addr_calc/fir_read_calc/counter/N48 ), .Y(n7777) );
  AOI22X1TS U4179 ( .A0(n6567), .A1(n6991), .B0(n6972), .B1(
        \router/addr_calc/fir_read_calc/counter/N49 ), .Y(n7778) );
  AOI22X1TS U4180 ( .A0(n6639), .A1(n6943), .B0(n6940), .B1(
        \router/addr_calc/fft_read_calc/counter/N65 ), .Y(n7706) );
  AOI22X1TS U4181 ( .A0(n6407), .A1(n7023), .B0(n7020), .B1(
        \router/addr_calc/iir_write_calc/counter/N65 ), .Y(n7882) );
  AOI22X1TS U4182 ( .A0(n6521), .A1(n7008), .B0(n6992), .B1(
        \router/addr_calc/fir_write_calc/counter/N48 ), .Y(n7821) );
  AOI22X1TS U4183 ( .A0(\router/addr_calc/fir_write_calc/count[5] ), .A1(n7007), .B0(n6993), .B1(\router/addr_calc/fir_write_calc/counter/N51 ), .Y(n7824) );
  AOI22X1TS U4184 ( .A0(n6501), .A1(n7005), .B0(n6995), .B1(
        \router/addr_calc/fir_write_calc/counter/N60 ), .Y(n7833) );
  AOI22X1TS U4185 ( .A0(n6523), .A1(n7011), .B0(n6992), .B1(
        \router/addr_calc/fir_write_calc/counter/N47 ), .Y(n7820) );
  AOI22X1TS U4186 ( .A0(n6517), .A1(n7007), .B0(n6993), .B1(
        \router/addr_calc/fir_write_calc/counter/N50 ), .Y(n7823) );
  NAND2XLTS U4187 ( .A(n7367), .B(n7746), .Y(
        \router/addr_calc/fft_write_calc/counter/N193 ) );
  AOI22X1TS U4188 ( .A0(\router/addr_calc/fir_read_calc/count[14] ), .A1(n6985), .B0(n6975), .B1(\router/addr_calc/fir_read_calc/counter/N60 ), .Y(n7789) );
  AOI22X1TS U4189 ( .A0(n6503), .A1(n7005), .B0(n6995), .B1(
        \router/addr_calc/fir_write_calc/counter/N59 ), .Y(n7832) );
  AOI22X1TS U4190 ( .A0(\router/addr_calc/fir_write_calc/count[9] ), .A1(n7006), .B0(n6994), .B1(\router/addr_calc/fir_write_calc/counter/N55 ), .Y(n7828) );
  AOI22X1TS U4191 ( .A0(n6507), .A1(n7006), .B0(n6994), .B1(
        \router/addr_calc/fir_write_calc/counter/N57 ), .Y(n7830) );
  AOI22X1TS U4192 ( .A0(\router/addr_calc/fir_read_calc/count[9] ), .A1(n6986), 
        .B0(n6974), .B1(\router/addr_calc/fir_read_calc/counter/N55 ), .Y(
        n7784) );
  AOI22X1TS U4193 ( .A0(\router/addr_calc/fir_read_calc/count[5] ), .A1(n6987), 
        .B0(n6973), .B1(\router/addr_calc/fir_read_calc/counter/N51 ), .Y(
        n7780) );
  NAND2XLTS U4194 ( .A(n7350), .B(n7793), .Y(
        \router/addr_calc/fir_read_calc/counter/N196 ) );
  AOI22X1TS U4195 ( .A0(n6519), .A1(n7011), .B0(n6992), .B1(
        \router/addr_calc/fir_write_calc/counter/N49 ), .Y(n7822) );
  INVX2TS U4196 ( .A(n6677), .Y(n6678) );
  AOI31XLTS U4197 ( .A0(n6686), .A1(n6680), .A2(n4773), .B0(n7611), .Y(n7610)
         );
  AOI22X1TS U4198 ( .A0(n6655), .A1(n6946), .B0(n6934), .B1(
        \router/addr_calc/fft_read_calc/counter/N54 ), .Y(n7695) );
  AOI22X1TS U4199 ( .A0(n6647), .A1(n6945), .B0(n6935), .B1(
        \router/addr_calc/fft_read_calc/counter/N59 ), .Y(n7700) );
  AOI22X1TS U4200 ( .A0(n6667), .A1(n6951), .B0(n6932), .B1(
        \router/addr_calc/fft_read_calc/counter/N47 ), .Y(n7688) );
  AOI22X1TS U4201 ( .A0(n6653), .A1(n6946), .B0(n6934), .B1(
        \router/addr_calc/fft_read_calc/counter/N56 ), .Y(n7697) );
  AOI22X1TS U4202 ( .A0(n6597), .A1(n6965), .B0(n6955), .B1(
        \router/addr_calc/fft_write_calc/counter/N59 ), .Y(n7744) );
  AOI22X1TS U4203 ( .A0(n6589), .A1(n6964), .B0(n6960), .B1(
        \router/addr_calc/fft_write_calc/counter/N64 ), .Y(n7749) );
  AOI22X1TS U4204 ( .A0(n6651), .A1(n6946), .B0(n6934), .B1(
        \router/addr_calc/fft_read_calc/counter/N57 ), .Y(n7698) );
  AOI22X1TS U4205 ( .A0(n6665), .A1(n6948), .B0(n6932), .B1(
        \router/addr_calc/fft_read_calc/counter/N48 ), .Y(n7689) );
  AOI22X1TS U4206 ( .A0(n6659), .A1(n6947), .B0(n6933), .B1(
        \router/addr_calc/fft_read_calc/counter/N52 ), .Y(n7693) );
  AOI22X1TS U4207 ( .A0(n6595), .A1(n6965), .B0(n6955), .B1(
        \router/addr_calc/fft_write_calc/counter/N60 ), .Y(n7745) );
  AOI22X1TS U4208 ( .A0(n6649), .A1(n6945), .B0(n6935), .B1(
        \router/addr_calc/fft_read_calc/counter/N58 ), .Y(n7699) );
  AOI22X1TS U4209 ( .A0(n6663), .A1(n6951), .B0(n6932), .B1(
        \router/addr_calc/fft_read_calc/counter/N49 ), .Y(n7690) );
  AOI22X1TS U4210 ( .A0(n6661), .A1(n6947), .B0(n6933), .B1(
        \router/addr_calc/fft_read_calc/counter/N50 ), .Y(n7691) );
  AOI22X1TS U4211 ( .A0(n6657), .A1(n6947), .B0(n6933), .B1(
        \router/addr_calc/fft_read_calc/counter/N53 ), .Y(n7694) );
  AOI22X1TS U4212 ( .A0(\router/addr_calc/fft_read_calc/count[5] ), .A1(n6947), 
        .B0(n6933), .B1(\router/addr_calc/fft_read_calc/counter/N51 ), .Y(
        n7692) );
  AOI22X1TS U4213 ( .A0(n6609), .A1(n6967), .B0(n6953), .B1(
        \router/addr_calc/fft_write_calc/counter/N52 ), .Y(n7737) );
  AOI22X1TS U4214 ( .A0(n6599), .A1(n6965), .B0(n6955), .B1(
        \router/addr_calc/fft_write_calc/counter/N58 ), .Y(n7743) );
  AOI22X1TS U4215 ( .A0(n6603), .A1(n6966), .B0(n6954), .B1(
        \router/addr_calc/fft_write_calc/counter/N56 ), .Y(n7741) );
  AOI22X1TS U4216 ( .A0(n6611), .A1(n6967), .B0(n6953), .B1(
        \router/addr_calc/fft_write_calc/counter/N51 ), .Y(n7736) );
  AOI22X1TS U4217 ( .A0(n6645), .A1(n6944), .B0(n6935), .B1(
        \router/addr_calc/fft_read_calc/counter/N61 ), .Y(n7702) );
  AOI22X1TS U4218 ( .A0(n6617), .A1(n6968), .B0(n6952), .B1(
        \router/addr_calc/fft_write_calc/counter/N48 ), .Y(n7733) );
  AOI22X1TS U4219 ( .A0(n6607), .A1(n6967), .B0(n6953), .B1(
        \router/addr_calc/fft_write_calc/counter/N53 ), .Y(n7738) );
  AOI22X1TS U4220 ( .A0(n6495), .A1(n7004), .B0(n7000), .B1(
        \router/addr_calc/fir_write_calc/counter/N64 ), .Y(n7837) );
  AOI22X1TS U4221 ( .A0(\router/addr_calc/fft_write_calc/count[9] ), .A1(n6966), .B0(n6954), .B1(\router/addr_calc/fft_write_calc/counter/N55 ), .Y(n7740) );
  AOI22X1TS U4222 ( .A0(n6619), .A1(n6971), .B0(n6952), .B1(
        \router/addr_calc/fft_write_calc/counter/N47 ), .Y(n7732) );
  AOI22X1TS U4223 ( .A0(n6613), .A1(n6967), .B0(n6953), .B1(
        \router/addr_calc/fft_write_calc/counter/N50 ), .Y(n7735) );
  AOI221X1TS U4224 ( .A0(n6730), .A1(n6952), .B0(
        \router/addr_calc/fft_write_addr[0] ), .B1(n6968), .C0(n7380), .Y(
        n7731) );
  NAND2XLTS U4225 ( .A(n7373), .B(n7704), .Y(
        \router/addr_calc/fft_read_calc/counter/N195 ) );
  AOI22X1TS U4226 ( .A0(n6605), .A1(n6966), .B0(n6954), .B1(
        \router/addr_calc/fft_write_calc/counter/N54 ), .Y(n7739) );
  AOI221X1TS U4227 ( .A0(n6729), .A1(n6932), .B0(
        \router/addr_calc/fft_read_addr[0] ), .B1(n6948), .C0(n7379), .Y(n7687) );
  AOI22X1TS U4228 ( .A0(n6615), .A1(n6971), .B0(n6952), .B1(
        \router/addr_calc/fft_write_calc/counter/N49 ), .Y(n7734) );
  AOI22X1TS U4229 ( .A0(n6601), .A1(n6966), .B0(n6954), .B1(
        \router/addr_calc/fft_write_calc/counter/N57 ), .Y(n7742) );
  AOI22X1TS U4230 ( .A0(\router/addr_calc/fft_read_calc/count[14] ), .A1(n6945), .B0(n6935), .B1(\router/addr_calc/fft_read_calc/counter/N60 ), .Y(n7701) );
  AOI22X1TS U4231 ( .A0(\router/addr_calc/fft_read_calc/count[9] ), .A1(n6946), 
        .B0(n6934), .B1(\router/addr_calc/fft_read_calc/counter/N55 ), .Y(
        n7696) );
  NAND2XLTS U4232 ( .A(n7667), .B(\router/ram_write_enable_reg ), .Y(n7666) );
  INVX2TS U4233 ( .A(n6747), .Y(n6677) );
  OAI32XLTS U4234 ( .A0(\fifo_to_fft/hang[11] ), .A1(n7916), .A2(n6412), .B0(
        n6746), .B1(n6417), .Y(n5707) );
  AOI22X1TS U4235 ( .A0(n6499), .A1(n7004), .B0(n7000), .B1(
        \router/addr_calc/fir_write_calc/counter/N62 ), .Y(n7835) );
  AOI22X1TS U4236 ( .A0(n6547), .A1(n6984), .B0(n6980), .B1(
        \router/addr_calc/fir_read_calc/counter/N62 ), .Y(n7791) );
  AOI22X1TS U4237 ( .A0(n6411), .A1(n7024), .B0(n7020), .B1(
        \router/addr_calc/iir_write_calc/counter/N63 ), .Y(n7880) );
  AO21XLTS U4238 ( .A0(n6669), .A1(n7658), .B0(n7617), .Y(n5774) );
  AOI22X1TS U4239 ( .A0(n6415), .A1(n7024), .B0(n7020), .B1(
        \router/addr_calc/iir_write_calc/counter/N62 ), .Y(n7879) );
  AOI22X1TS U4240 ( .A0(n6593), .A1(n6964), .B0(n6960), .B1(
        \router/addr_calc/fft_write_calc/counter/N62 ), .Y(n7747) );
  AOI22X1TS U4241 ( .A0(n6643), .A1(n6944), .B0(n6940), .B1(
        \router/addr_calc/fft_read_calc/counter/N62 ), .Y(n7703) );
  OAI22XLTS U4242 ( .A0(n7460), .A1(
        \fifo_to_fft/fifo_cell11/controller/valid_read ), .B0(n7602), .B1(
        n7047), .Y(n5679) );
  NAND3XLTS U4243 ( .A(n7662), .B(n7661), .C(n7660), .Y(n7663) );
  NOR2X1TS U4244 ( .A(n6894), .B(n7660), .Y(n7617) );
  AOI22X1TS U4245 ( .A0(n6419), .A1(n7024), .B0(n7015), .B1(
        \router/addr_calc/iir_write_calc/counter/N61 ), .Y(n7878) );
  NAND2XLTS U4246 ( .A(n7318), .B(n7877), .Y(
        \router/addr_calc/iir_write_calc/counter/N192 ) );
  OAI22XLTS U4247 ( .A0(n7457), .A1(
        \fifo_to_fft/fifo_cell12/controller/valid_read ), .B0(n6412), .B1(
        n7048), .Y(n5681) );
  AO21XLTS U4248 ( .A0(\router/iir_get_req_reg ), .A1(n7657), .B0(n7618), .Y(
        n5773) );
  OAI22XLTS U4249 ( .A0(n7460), .A1(
        \fifo_to_fft/fifo_cell1/controller/valid_read ), .B0(n4773), .B1(n7048), .Y(n5675) );
  AO21XLTS U4250 ( .A0(\router/fft_get_req_reg ), .A1(n6674), .B0(n7619), .Y(
        n5771) );
  AOI32X1TS U4251 ( .A0(n7062), .A1(n6671), .A2(n6676), .B0(n7614), .B1(n6751), 
        .Y(n7552) );
  CLKINVX1TS U4252 ( .A(n7863), .Y(
        \router/addr_calc/iir_write_calc/counter/N178 ) );
  NAND2XLTS U4253 ( .A(n7319), .B(n7872), .Y(
        \router/addr_calc/iir_write_calc/counter/N187 ) );
  NOR2X1TS U4254 ( .A(n4725), .B(n7661), .Y(n7618) );
  OAI22XLTS U4255 ( .A0(n7439), .A1(
        \fifo_to_fft/fifo_cell3/controller/valid_read ), .B0(n6424), .B1(n7051), .Y(n5688) );
  OAI22XLTS U4256 ( .A0(n7429), .A1(
        \fifo_to_fft/fifo_cell2/controller/valid_read ), .B0(n6408), .B1(n7051), .Y(n5677) );
  NOR3X1TS U4257 ( .A(\router/data_to_fft ), .B(n6897), .C(n7621), .Y(n7619)
         );
  AOI22X1TS U4258 ( .A0(n6443), .A1(n7027), .B0(n7013), .B1(
        \router/addr_calc/iir_write_calc/counter/N53 ), .Y(n7870) );
  AOI22X1TS U4259 ( .A0(n6459), .A1(n7028), .B0(n7012), .B1(
        \router/addr_calc/iir_write_calc/counter/N48 ), .Y(n7865) );
  AOI22X1TS U4260 ( .A0(n6423), .A1(n7025), .B0(n7015), .B1(
        \router/addr_calc/iir_write_calc/counter/N59 ), .Y(n7876) );
  AOI22X1TS U4261 ( .A0(n6455), .A1(n7031), .B0(n7012), .B1(
        \router/addr_calc/iir_write_calc/counter/N49 ), .Y(n7866) );
  AOI22X1TS U4262 ( .A0(n6427), .A1(n7025), .B0(n7015), .B1(
        \router/addr_calc/iir_write_calc/counter/N58 ), .Y(n7875) );
  AOI22X1TS U4263 ( .A0(n6463), .A1(n7031), .B0(n7012), .B1(
        \router/addr_calc/iir_write_calc/counter/N47 ), .Y(n7864) );
  AOI22X1TS U4264 ( .A0(n6431), .A1(n7026), .B0(n7014), .B1(
        \router/addr_calc/iir_write_calc/counter/N57 ), .Y(n7874) );
  AOI22X1TS U4265 ( .A0(n6439), .A1(n7026), .B0(n7014), .B1(
        \router/addr_calc/iir_write_calc/counter/N54 ), .Y(n7871) );
  INVX2TS U4266 ( .A(n6670), .Y(n6672) );
  AOI22X1TS U4267 ( .A0(n6447), .A1(n7027), .B0(n7013), .B1(
        \router/addr_calc/iir_write_calc/counter/N52 ), .Y(n7869) );
  AOI221X1TS U4268 ( .A0(n6731), .A1(n7012), .B0(
        \router/addr_calc/iir_write_addr[0] ), .B1(n7028), .C0(n7330), .Y(
        n7863) );
  AOI22X1TS U4269 ( .A0(\router/addr_calc/iir_write_calc/count[5] ), .A1(n7027), .B0(n7013), .B1(\router/addr_calc/iir_write_calc/counter/N51 ), .Y(n7868) );
  AOI22X1TS U4270 ( .A0(n6451), .A1(n7027), .B0(n7013), .B1(
        \router/addr_calc/iir_write_calc/counter/N50 ), .Y(n7867) );
  AOI22X1TS U4271 ( .A0(n6435), .A1(n7026), .B0(n7014), .B1(
        \router/addr_calc/iir_write_calc/counter/N56 ), .Y(n7873) );
  INVX2TS U4272 ( .A(n6670), .Y(n6671) );
  INVX2TS U4273 ( .A(n6752), .Y(n6670) );
  AO22XLTS U4274 ( .A0(n7424), .A1(\fifo_to_fft/fifo_cell2/controller/f_i_put ), .B0(n6901), .B1(n7604), .Y(n5676) );
  AO22XLTS U4275 ( .A0(n7421), .A1(\fifo_to_fft/fifo_cell4/controller/f_i_put ), .B0(n6900), .B1(n7596), .Y(n5689) );
  AO22XLTS U4276 ( .A0(n7422), .A1(\fifo_to_fft/fifo_cell6/controller/f_i_put ), .B0(n6687), .B1(n7592), .Y(n5693) );
  AO22XLTS U4277 ( .A0(n7421), .A1(\fifo_to_fft/fifo_cell9/controller/f_i_put ), .B0(n6686), .B1(n7589), .Y(n5699) );
  AO22XLTS U4278 ( .A0(n7422), .A1(\fifo_to_fft/fifo_cell7/controller/f_i_put ), .B0(n6685), .B1(n7591), .Y(n5695) );
  AO22XLTS U4279 ( .A0(n7423), .A1(\fifo_to_fft/fifo_cell3/controller/f_i_put ), .B0(n6687), .B1(n7597), .Y(n5687) );
  AO22XLTS U4280 ( .A0(n7421), .A1(
        \fifo_to_fft/fifo_cell10/controller/f_i_put ), .B0(n6685), .B1(n7588), 
        .Y(n5701) );
  OAI211XLTS U4281 ( .A0(\fifo_to_fft/hang[9] ), .A1(n7576), .B0(n6687), .C0(
        n7575), .Y(n7583) );
  AO22XLTS U4282 ( .A0(n7423), .A1(
        \fifo_to_fft/fifo_cell12/controller/f_i_put ), .B0(n6686), .B1(n7601), 
        .Y(n5680) );
  NOR2X1TS U4283 ( .A(\router/data_cntl/N168 ), .B(n7605), .Y(n7546) );
  AO22XLTS U4284 ( .A0(n7422), .A1(
        \fifo_to_fft/fifo_cell13/controller/f_i_put ), .B0(n6685), .B1(n7600), 
        .Y(n5682) );
  NOR2BXLTS U4285 ( .AN(n7543), .B(n7542), .Y(n7549) );
  OAI22XLTS U4286 ( .A0(n7435), .A1(
        \fifo_to_fir/fifo_cell7/controller/valid_read ), .B0(n6472), .B1(n7057), .Y(n5745) );
  AO22XLTS U4287 ( .A0(n7418), .A1(\fifo_to_fir/fifo_cell9/controller/f_i_put ), .B0(n7066), .B1(n7554), .Y(n5748) );
  OAI22XLTS U4288 ( .A0(n7426), .A1(
        \fifo_to_fir/fifo_cell8/controller/valid_read ), .B0(n6476), .B1(n7056), .Y(n5747) );
  AO22XLTS U4289 ( .A0(n7418), .A1(\fifo_to_fir/fifo_cell7/controller/f_i_put ), .B0(n7065), .B1(n7556), .Y(n5744) );
  AO22XLTS U4290 ( .A0(n7418), .A1(\fifo_to_fir/fifo_cell8/controller/f_i_put ), .B0(n7066), .B1(n7555), .Y(n5746) );
  OAI22XLTS U4291 ( .A0(n7457), .A1(
        \fifo_to_fir/fifo_cell5/controller/valid_read ), .B0(n7558), .B1(n7057), .Y(n5741) );
  AO22XLTS U4292 ( .A0(n7418), .A1(\fifo_to_fir/fifo_cell6/controller/f_i_put ), .B0(n7065), .B1(n7557), .Y(n5742) );
  AO22XLTS U4293 ( .A0(n7419), .A1(\fifo_to_fir/fifo_cell5/controller/f_i_put ), .B0(n7065), .B1(n7559), .Y(n5740) );
  AND3X2TS U4294 ( .A(n7073), .B(\fifo_from_fir/fifo_cell15/reg_gtok/token ), 
        .C(n6263), .Y(\fifo_from_fir/fifo_cell15/N7 ) );
  AO22XLTS U4295 ( .A0(n7423), .A1(
        \fifo_to_fft/fifo_cell11/controller/f_i_put ), .B0(n4714), .B1(n7603), 
        .Y(n5678) );
  AO22XLTS U4296 ( .A0(n7421), .A1(\fifo_to_fft/fifo_cell8/controller/f_i_put ), .B0(n6901), .B1(n7590), .Y(n5697) );
  AO22XLTS U4297 ( .A0(n7423), .A1(
        \fifo_to_fft/fifo_cell14/controller/f_i_put ), .B0(n6900), .B1(n7599), 
        .Y(n5684) );
  AO22XLTS U4298 ( .A0(n7422), .A1(\fifo_to_fft/fifo_cell5/controller/f_i_put ), .B0(n4714), .B1(n7594), .Y(n5691) );
  OAI211XLTS U4299 ( .A0(\fifo_to_fft/hang[2] ), .A1(n7579), .B0(n6900), .C0(
        n7578), .Y(n7580) );
  NAND3XLTS U4300 ( .A(n7389), .B(n7906), .C(n7905), .Y(
        \router/data_cntl/N155 ) );
  AND3X2TS U4301 ( .A(n6762), .B(n6807), .C(
        \router/addr_calc/fir_read_addr[27] ), .Y(n6830) );
  AND3X2TS U4302 ( .A(n6763), .B(n6809), .C(
        \router/addr_calc/fir_write_addr[27] ), .Y(n6831) );
  AOI21X1TS U4303 ( .A0(n5162), .A1(n7528), .B0(n7527), .Y(n5940) );
  AO22XLTS U4304 ( .A0(n7417), .A1(
        \fifo_to_fir/fifo_cell10/controller/f_i_put ), .B0(n7067), .B1(n7553), 
        .Y(n5750) );
  AND3X2TS U4305 ( .A(n6764), .B(n6811), .C(
        \router/addr_calc/fft_read_addr[27] ), .Y(n6832) );
  AO22XLTS U4306 ( .A0(n7419), .A1(\fifo_to_fir/fifo_cell4/controller/f_i_put ), .B0(n7064), .B1(n7561), .Y(n5738) );
  CLKINVX1TS U4307 ( .A(n7526), .Y(n5941) );
  AO22XLTS U4308 ( .A0(n7419), .A1(\fifo_to_fir/fifo_cell3/controller/f_i_put ), .B0(n7064), .B1(n7562), .Y(n5736) );
  AO22XLTS U4309 ( .A0(n7419), .A1(
        \fifo_to_fir/fifo_cell14/controller/f_i_put ), .B0(n7063), .B1(n7564), 
        .Y(n5733) );
  AO22XLTS U4310 ( .A0(n7420), .A1(
        \fifo_to_fir/fifo_cell13/controller/f_i_put ), .B0(n7064), .B1(n7565), 
        .Y(n5731) );
  AND3X2TS U4311 ( .A(n6765), .B(n6813), .C(
        \router/addr_calc/fft_write_addr[27] ), .Y(n6833) );
  AO22XLTS U4312 ( .A0(n7420), .A1(
        \fifo_to_fir/fifo_cell12/controller/f_i_put ), .B0(n7063), .B1(n7566), 
        .Y(n5729) );
  AO22XLTS U4313 ( .A0(n7420), .A1(
        \fifo_to_fir/fifo_cell11/controller/f_i_put ), .B0(n7063), .B1(n7568), 
        .Y(n5727) );
  NOR2X1TS U4314 ( .A(n6404), .B(n4348), .Y(n7607) );
  CLKINVX1TS U4315 ( .A(n6901), .Y(n6211) );
  NOR2XLTS U4316 ( .A(n6684), .B(n7903), .Y(\router/data_cntl/N154 ) );
  OAI21XLTS U4317 ( .A0(n7904), .A1(n7903), .B0(n7902), .Y(n7905) );
  CLKINVX2TS U4318 ( .A(n7069), .Y(n7052) );
  CLKINVX2TS U4319 ( .A(n7069), .Y(n7053) );
  OAI211X1TS U4320 ( .A0(\mips/mips/a/countflag ), .A1(\mips/mips/a/count[0] ), 
        .B0(n5165), .C0(n7528), .Y(n7526) );
  AND3X2TS U4321 ( .A(n6761), .B(n6829), .C(
        \router/addr_calc/fft_write_addr[23] ), .Y(n6813) );
  AND2X1TS U4322 ( .A(n4915), .B(\fifo_from_fir/fifo_cell9/reg_gtok/token ), 
        .Y(\fifo_from_fir/fifo_cell10/data_out/N35 ) );
  AND3X2TS U4323 ( .A(n6758), .B(n6820), .C(
        \router/addr_calc/fir_read_addr[23] ), .Y(n6807) );
  AND3X2TS U4324 ( .A(n6759), .B(n6823), .C(
        \router/addr_calc/fir_write_addr[23] ), .Y(n6809) );
  INVX1TS U4325 ( .A(n7068), .Y(n7058) );
  AND3X2TS U4326 ( .A(n6760), .B(n6826), .C(
        \router/addr_calc/fft_read_addr[23] ), .Y(n6811) );
  NAND3XLTS U4327 ( .A(n6683), .B(n7906), .C(n7898), .Y(
        \router/data_cntl/N151 ) );
  INVX2TS U4328 ( .A(n7915), .Y(n6405) );
  NAND2XLTS U4329 ( .A(n6726), .B(from_fir_full), .Y(n7909) );
  AND3X2TS U4330 ( .A(n7083), .B(\fifo_from_fft/fifo_cell15/reg_gtok/token ), 
        .C(n6326), .Y(\fifo_from_fft/fifo_cell15/N7 ) );
  CLKINVX2TS U4331 ( .A(n7915), .Y(n6404) );
  NAND2XLTS U4332 ( .A(\mips/mips/a/countflag ), .B(\mips/mips/a/count[0] ), 
        .Y(n7528) );
  NOR2XLTS U4333 ( .A(n7674), .B(n6734), .Y(ram_read_enable) );
  AND3X2TS U4334 ( .A(n6775), .B(n6804), .C(n6127), .Y(n6826) );
  NOR2X1TS U4335 ( .A(\mips/mips/a/countflag ), .B(\mips/mips/a/N49 ), .Y(
        \mips/mips/a/N46 ) );
  OAI32XLTS U4336 ( .A0(n7917), .A1(n7676), .A2(n7675), .B0(n7674), .B1(n7917), 
        .Y(ram_write_enable) );
  AO22XLTS U4337 ( .A0(n7420), .A1(\fifo_to_fir/fifo_cell2/controller/f_i_put ), .B0(n6893), .B1(n7569), .Y(n5725) );
  NOR4BX1TS U4338 ( .AN(n6669), .B(n7425), .C(from_fir_empty), .D(n7465), .Y(
        n4915) );
  AND3X2TS U4339 ( .A(n6777), .B(n6805), .C(n6129), .Y(n6829) );
  AND3X2TS U4340 ( .A(n6771), .B(n6802), .C(n6128), .Y(n6820) );
  AND3X2TS U4341 ( .A(n6773), .B(n6803), .C(n6126), .Y(n6823) );
  INVXLTS U4342 ( .A(n7544), .Y(n6726) );
  NAND2XLTS U4343 ( .A(n7899), .B(from_fft_full), .Y(n7900) );
  NOR2XLTS U4344 ( .A(n7383), .B(n7897), .Y(\router/data_cntl/N152 ) );
  OAI32XLTS U4345 ( .A0(n7425), .A1(\router/iir_write_done ), .A2(n7525), .B0(
        n7521), .B1(n7458), .Y(n5945) );
  AND3X2TS U4346 ( .A(n6780), .B(n6825), .C(n6088), .Y(n6804) );
  AND3X2TS U4347 ( .A(n6779), .B(n6822), .C(n6083), .Y(n6803) );
  AND3X2TS U4348 ( .A(n6778), .B(n6819), .C(n6085), .Y(n6802) );
  AOI21X1TS U4349 ( .A0(\router/fir_read_done ), .A1(n7902), .B0(n7669), .Y(
        n7465) );
  AND3X2TS U4350 ( .A(n6781), .B(n6828), .C(n6086), .Y(n6805) );
  NOR2BXLTS U4351 ( .AN(\mips/mips/accfullinstruction[30] ), .B(n7040), .Y(
        n5815) );
  CLKINVX1TS U4352 ( .A(n7907), .Y(n7544) );
  NOR2BXLTS U4353 ( .AN(\mips/mips/accfullinstruction[20] ), .B(n7041), .Y(
        n5825) );
  NOR2BXLTS U4354 ( .AN(\mips/mips/accfullinstruction[23] ), .B(n7041), .Y(
        n5822) );
  INVX1TS U4355 ( .A(n7896), .Y(from_fft_full) );
  CLKBUFX2TS U4356 ( .A(n7899), .Y(n7915) );
  NOR2BXLTS U4357 ( .AN(\mips/mips/accfullinstruction[28] ), .B(n7040), .Y(
        n5817) );
  NOR2BXLTS U4358 ( .AN(\mips/mips/accfullinstruction[25] ), .B(n7041), .Y(
        n5820) );
  INVX1TS U4359 ( .A(n7901), .Y(from_fir_full) );
  AND3X2TS U4360 ( .A(n6769), .B(n6812), .C(
        \router/addr_calc/fft_write_calc/count[15] ), .Y(n6828) );
  NAND3XLTS U4361 ( .A(n7338), .B(n7393), .C(n7530), .Y(n7533) );
  AND3X2TS U4362 ( .A(n6766), .B(n6806), .C(n6084), .Y(n6819) );
  AND3X2TS U4363 ( .A(n6767), .B(n6808), .C(
        \router/addr_calc/fir_write_calc/count[15] ), .Y(n6822) );
  AND3X2TS U4364 ( .A(n6768), .B(n6810), .C(n6087), .Y(n6825) );
  AND2X1TS U4365 ( .A(n4699), .B(\fifo_from_fft/fifo_cell9/reg_gtok/token ), 
        .Y(\fifo_from_fft/fifo_cell10/data_out/N35 ) );
  NOR2BXLTS U4366 ( .AN(\mips/mips/accfullinstruction[24] ), .B(n7910), .Y(
        n5821) );
  AOI211XLTS U4367 ( .A0(n4325), .A1(instruction[2]), .B0(n7911), .C0(n7910), 
        .Y(n7912) );
  INVX2TS U4368 ( .A(n7908), .Y(n6684) );
  AND3X2TS U4369 ( .A(n6772), .B(n6821), .C(n6117), .Y(n6808) );
  AND3X2TS U4370 ( .A(n6770), .B(n6818), .C(n6118), .Y(n6806) );
  INVX1TS U4371 ( .A(n7529), .Y(n7534) );
  AND3X2TS U4372 ( .A(n6776), .B(n6827), .C(n6119), .Y(n6812) );
  NAND2XLTS U4373 ( .A(\fifo_to_fft/hang[9] ), .B(n7576), .Y(n7575) );
  AND3X2TS U4374 ( .A(n6839), .B(n6838), .C(n6152), .Y(n6846) );
  INVX2TS U4375 ( .A(n7908), .Y(n6683) );
  AND3X2TS U4376 ( .A(n6774), .B(n6824), .C(n6120), .Y(n6810) );
  NAND2XLTS U4377 ( .A(n7397), .B(n6449), .Y(n7569) );
  NAND2XLTS U4378 ( .A(n7400), .B(n6473), .Y(n7556) );
  NAND2XLTS U4379 ( .A(n7397), .B(n6445), .Y(n7588) );
  NAND2XLTS U4380 ( .A(n7400), .B(n6481), .Y(n7554) );
  NAND2XLTS U4381 ( .A(n7400), .B(n6485), .Y(n7553) );
  NAND2XLTS U4382 ( .A(n7397), .B(n7567), .Y(n7568) );
  CLKINVX1TS U4383 ( .A(\mips/mips/a/N49 ), .Y(n5165) );
  NAND4XLTS U4384 ( .A(n7481), .B(n7480), .C(n7479), .D(n7478), .Y(n7482) );
  NAND4XLTS U4385 ( .A(n7502), .B(n7501), .C(n7500), .D(n7499), .Y(n7503) );
  AND3X2TS U4386 ( .A(n6793), .B(n6801), .C(n6069), .Y(n6827) );
  NAND2XLTS U4387 ( .A(\fifo_to_fft/hang[2] ), .B(n7579), .Y(n7578) );
  CLKINVX2TS U4388 ( .A(n7538), .Y(n7531) );
  NOR2X1TS U4389 ( .A(n6397), .B(n6837), .Y(n6839) );
  CLKINVX2TS U4390 ( .A(n7525), .Y(n7532) );
  AND3X2TS U4391 ( .A(n6792), .B(n6800), .C(n6070), .Y(n6824) );
  AND3X2TS U4392 ( .A(n6790), .B(n6798), .C(n6068), .Y(n6818) );
  AND3X2TS U4393 ( .A(n6791), .B(n6799), .C(n6066), .Y(n6821) );
  CLKINVX1TS U4394 ( .A(\router/data_cntl/N160 ), .Y(n7906) );
  OAI22XLTS U4395 ( .A0(n7357), .A1(n7658), .B0(n7331), .B1(n7657), .Y(n7659)
         );
  NAND4XLTS U4396 ( .A(\fifo_from_fft/fifo_cell8/controller/f_i_get ), .B(
        \fifo_from_fft/fifo_cell9/controller/f_i_get ), .C(
        \fifo_from_fft/fifo_cell7/controller/f_i_get ), .D(n7390), .Y(n7508)
         );
  CLKINVX2TS U4397 ( .A(n7433), .Y(n7412) );
  CLKINVX2TS U4398 ( .A(n7433), .Y(n7411) );
  CLKINVX2TS U4399 ( .A(n7432), .Y(n7410) );
  CLKINVX2TS U4400 ( .A(n7430), .Y(n7403) );
  CLKINVX2TS U4401 ( .A(n7430), .Y(n7402) );
  CLKINVX2TS U4402 ( .A(n7432), .Y(n7409) );
  CLKINVX2TS U4403 ( .A(n7434), .Y(n7416) );
  CLKINVX2TS U4404 ( .A(n7434), .Y(n7415) );
  CLKINVX2TS U4405 ( .A(n7434), .Y(n7414) );
  CLKINVX2TS U4406 ( .A(n7433), .Y(n7413) );
  CLKINVX2TS U4407 ( .A(n7431), .Y(n7407) );
  CLKINVX2TS U4408 ( .A(n7431), .Y(n7406) );
  CLKINVX2TS U4409 ( .A(n7431), .Y(n7405) );
  CLKINVX2TS U4410 ( .A(n7432), .Y(n7408) );
  CLKINVX2TS U4411 ( .A(n7430), .Y(n7404) );
  CLKINVX2TS U4412 ( .A(n7429), .Y(n7401) );
  CLKINVX1TS U4413 ( .A(n7435), .Y(n7418) );
  CLKINVX2TS U4414 ( .A(n7429), .Y(n7399) );
  CLKINVX1TS U4415 ( .A(n7435), .Y(n7419) );
  CLKINVX2TS U4416 ( .A(n7428), .Y(n7398) );
  INVXLTS U4417 ( .A(n7427), .Y(n7424) );
  CLKINVX2TS U4418 ( .A(n7428), .Y(n7396) );
  NAND3XLTS U4419 ( .A(\router/fir_get_req_reg ), .B(n6733), .C(n7541), .Y(
        n7658) );
  OAI31XLTS U4420 ( .A0(n7672), .A1(n7332), .A2(n7671), .B0(n7384), .Y(n7673)
         );
  AND3X2TS U4421 ( .A(n6816), .B(n6784), .C(n6058), .Y(n6800) );
  CLKAND2X2TS U4422 ( .A(n7338), .B(n7384), .Y(n7908) );
  AND3X2TS U4423 ( .A(n6814), .B(n6782), .C(n6054), .Y(n6798) );
  AND3X2TS U4424 ( .A(n6815), .B(n6783), .C(n6053), .Y(n6799) );
  XOR2XLTS U4425 ( .A(\fifo_to_fft/hang[3] ), .B(n7572), .Y(n7573) );
  AND3X2TS U4426 ( .A(n6817), .B(n6785), .C(n6056), .Y(n6801) );
  NOR2XLTS U4427 ( .A(n7382), .B(n6734), .Y(n7914) );
  CLKINVX1TS U4428 ( .A(n7454), .Y(n7390) );
  INVX1TS U4429 ( .A(n7426), .Y(n7391) );
  INVX1TS U4430 ( .A(n7426), .Y(n7392) );
  INVX1TS U4431 ( .A(n7354), .Y(n7340) );
  NOR2X1TS U4432 ( .A(n6393), .B(n6458), .Y(n6836) );
  AND3X2TS U4433 ( .A(n6795), .B(n6787), .C(n6065), .Y(n6783) );
  INVX1TS U4434 ( .A(n7354), .Y(n7339) );
  AND3X2TS U4435 ( .A(n6796), .B(n6788), .C(n6057), .Y(n6784) );
  CLKINVX2TS U4436 ( .A(n6212), .Y(n6214) );
  CLKINVX2TS U4437 ( .A(n6218), .Y(n6220) );
  CLKINVX2TS U4438 ( .A(n6224), .Y(n6226) );
  CLKINVX2TS U4439 ( .A(n6230), .Y(n6232) );
  CLKINVX2TS U4440 ( .A(n6236), .Y(n6238) );
  CLKINVX2TS U4441 ( .A(n6242), .Y(n6244) );
  CLKINVX2TS U4442 ( .A(n6248), .Y(n6250) );
  CLKINVX2TS U4443 ( .A(n6251), .Y(n6253) );
  INVX2TS U4444 ( .A(n6212), .Y(n6213) );
  INVX2TS U4445 ( .A(n6218), .Y(n6219) );
  INVX2TS U4446 ( .A(n6224), .Y(n6225) );
  INVX2TS U4447 ( .A(n6230), .Y(n6231) );
  INVX2TS U4448 ( .A(n6236), .Y(n6237) );
  INVX2TS U4449 ( .A(n6242), .Y(n6243) );
  INVX2TS U4450 ( .A(n6248), .Y(n6249) );
  INVX2TS U4451 ( .A(n6251), .Y(n6252) );
  INVX1TS U4452 ( .A(n7384), .Y(n7373) );
  INVX1TS U4453 ( .A(n7384), .Y(n7372) );
  CLKINVX2TS U4454 ( .A(n6374), .Y(n6376) );
  CLKINVX2TS U4455 ( .A(n6365), .Y(n6367) );
  CLKINVX2TS U4456 ( .A(n6356), .Y(n6358) );
  CLKINVX2TS U4457 ( .A(n6347), .Y(n6349) );
  CLKINVX2TS U4458 ( .A(n6338), .Y(n6340) );
  CLKINVX2TS U4459 ( .A(n6329), .Y(n6331) );
  CLKINVX2TS U4460 ( .A(n6320), .Y(n6322) );
  CLKINVX2TS U4461 ( .A(n6311), .Y(n6313) );
  CLKINVX2TS U4462 ( .A(n6302), .Y(n6304) );
  CLKINVX2TS U4463 ( .A(n6293), .Y(n6295) );
  CLKINVX2TS U4464 ( .A(n6284), .Y(n6286) );
  CLKINVX2TS U4465 ( .A(n6275), .Y(n6277) );
  CLKINVX2TS U4466 ( .A(n6266), .Y(n6268) );
  CLKINVX2TS U4467 ( .A(\router/ram_read_enable_reg ), .Y(n6734) );
  NAND3XLTS U4468 ( .A(n7359), .B(n7385), .C(n7334), .Y(
        \router/data_cntl/N159 ) );
  AND3X2TS U4469 ( .A(n6794), .B(n6786), .C(n6067), .Y(n6782) );
  INVX2TS U4470 ( .A(n6329), .Y(n6330) );
  INVX2TS U4471 ( .A(n6338), .Y(n6339) );
  INVX2TS U4472 ( .A(n6347), .Y(n6348) );
  INVX2TS U4473 ( .A(n6320), .Y(n6321) );
  INVX2TS U4474 ( .A(n6356), .Y(n6357) );
  INVX2TS U4475 ( .A(n6215), .Y(n6216) );
  INVX2TS U4476 ( .A(n6311), .Y(n6312) );
  INVX2TS U4477 ( .A(n6365), .Y(n6366) );
  INVX2TS U4478 ( .A(n6221), .Y(n6222) );
  AND3X2TS U4479 ( .A(n6797), .B(n6789), .C(n6055), .Y(n6785) );
  INVX2TS U4480 ( .A(n6302), .Y(n6303) );
  INVX2TS U4481 ( .A(n6374), .Y(n6375) );
  INVX2TS U4482 ( .A(n6227), .Y(n6228) );
  INVX2TS U4483 ( .A(n6233), .Y(n6234) );
  INVX2TS U4484 ( .A(n6293), .Y(n6294) );
  INVX2TS U4485 ( .A(n6239), .Y(n6240) );
  INVX2TS U4486 ( .A(n6245), .Y(n6246) );
  CLKINVX2TS U4487 ( .A(n6221), .Y(n6223) );
  CLKINVX2TS U4488 ( .A(n6215), .Y(n6217) );
  CLKINVX2TS U4489 ( .A(n6227), .Y(n6229) );
  CLKINVX2TS U4490 ( .A(n6239), .Y(n6241) );
  CLKINVX2TS U4491 ( .A(n6257), .Y(n6259) );
  CLKINVX2TS U4492 ( .A(n6245), .Y(n6247) );
  CLKINVX2TS U4493 ( .A(n6233), .Y(n6235) );
  INVX2TS U4494 ( .A(n6257), .Y(n6258) );
  INVX2TS U4495 ( .A(n6275), .Y(n6276) );
  INVX2TS U4496 ( .A(n6266), .Y(n6267) );
  INVX2TS U4497 ( .A(n6284), .Y(n6285) );
  NAND4XLTS U4498 ( .A(n6543), .B(n6571), .C(n6545), .D(
        \router/addr_calc/fir_read_calc/count[18] ), .Y(n7771) );
  AND2X2TS U4499 ( .A(n6125), .B(n6090), .Y(n6769) );
  AND2X2TS U4500 ( .A(n6074), .B(n6100), .Y(n6776) );
  INVX1TS U4501 ( .A(n7386), .Y(n7375) );
  INVX1TS U4502 ( .A(n7386), .Y(n7374) );
  NAND4XLTS U4503 ( .A(n6639), .B(n6667), .C(n6641), .D(
        \router/addr_calc/fft_read_calc/count[18] ), .Y(n7683) );
  NAND4XLTS U4504 ( .A(n6645), .B(n6643), .C(n6647), .D(
        \router/addr_calc/fft_read_calc/count[14] ), .Y(n7682) );
  NAND4XLTS U4505 ( .A(\router/addr_calc/fft_read_calc/count[0] ), .B(n6651), 
        .C(n6649), .D(n6653), .Y(n7681) );
  AND2X2TS U4506 ( .A(n6621), .B(\router/addr_calc/fft_read_addr[30] ), .Y(
        n6756) );
  AND2X2TS U4507 ( .A(n6627), .B(n6625), .Y(n6764) );
  AND2X2TS U4508 ( .A(n6064), .B(n6629), .Y(n6760) );
  AND2X2TS U4509 ( .A(n6123), .B(n6080), .Y(n6775) );
  AND2X2TS U4510 ( .A(n6060), .B(n6059), .Y(n6774) );
  NAND4XLTS U4511 ( .A(n6511), .B(\router/addr_calc/fir_write_calc/count[9] ), 
        .C(n6515), .D(n6513), .Y(n7812) );
  NAND4XLTS U4512 ( .A(n6517), .B(\router/addr_calc/fir_write_calc/count[5] ), 
        .C(n6151), .D(n6519), .Y(n7811) );
  NAND4XLTS U4513 ( .A(n6521), .B(\router/addr_calc/fir_write_calc/count[30] ), 
        .C(n6096), .D(n6471), .Y(n7810) );
  NAND4XLTS U4514 ( .A(n6156), .B(\router/addr_calc/fir_write_calc/count[27] ), 
        .C(n6092), .D(n6138), .Y(n7809) );
  NAND4XLTS U4515 ( .A(n6126), .B(\router/addr_calc/fir_write_calc/count[23] ), 
        .C(n6493), .D(n6078), .Y(n7816) );
  NAND4XLTS U4516 ( .A(\router/addr_calc/fir_write_calc/count[19] ), .B(n6523), 
        .C(n6497), .D(n6495), .Y(n7815) );
  NAND4XLTS U4517 ( .A(\router/addr_calc/fir_write_calc/count[15] ), .B(n6499), 
        .C(n6503), .D(n6501), .Y(n7814) );
  NAND4XLTS U4518 ( .A(\router/addr_calc/fir_write_calc/count[0] ), .B(n6507), 
        .C(n6505), .D(n6509), .Y(n7813) );
  AND2X2TS U4519 ( .A(n6467), .B(\router/addr_calc/fir_write_addr[30] ), .Y(
        n6755) );
  AND2X2TS U4520 ( .A(n6479), .B(n6475), .Y(n6763) );
  AND2X2TS U4521 ( .A(n6092), .B(n6483), .Y(n6759) );
  NAND4XLTS U4522 ( .A(n6127), .B(\router/addr_calc/fft_read_calc/count[23] ), 
        .C(n6637), .D(n6080), .Y(n7684) );
  AND2X2TS U4523 ( .A(n6121), .B(n6078), .Y(n6773) );
  AND2X2TS U4524 ( .A(n6124), .B(n6089), .Y(n6767) );
  AND2X2TS U4525 ( .A(n6072), .B(n6099), .Y(n6772) );
  AND2X2TS U4526 ( .A(n6073), .B(n6071), .Y(n6770) );
  NAND4XLTS U4527 ( .A(n6559), .B(\router/addr_calc/fir_read_calc/count[9] ), 
        .C(n6563), .D(n6561), .Y(n7768) );
  NAND4XLTS U4528 ( .A(n6565), .B(\router/addr_calc/fir_read_calc/count[5] ), 
        .C(n6150), .D(n6567), .Y(n7767) );
  AND2X2TS U4529 ( .A(n6091), .B(n6063), .Y(n6771) );
  AND2X2TS U4530 ( .A(n6093), .B(n6533), .Y(n6758) );
  NAND4XLTS U4531 ( .A(n6569), .B(\router/addr_calc/fir_read_calc/count[30] ), 
        .C(n6097), .D(n6527), .Y(n7766) );
  AND2X2TS U4532 ( .A(n6531), .B(n6529), .Y(n6762) );
  AND2X2TS U4533 ( .A(n6525), .B(\router/addr_calc/fir_read_addr[30] ), .Y(
        n6754) );
  NAND4XLTS U4534 ( .A(n6155), .B(\router/addr_calc/fir_read_calc/count[27] ), 
        .C(n6093), .D(n6139), .Y(n7765) );
  NAND4XLTS U4535 ( .A(n6128), .B(\router/addr_calc/fir_read_calc/count[23] ), 
        .C(n6541), .D(n6063), .Y(n7772) );
  NAND4XLTS U4536 ( .A(\router/addr_calc/fir_read_calc/count[0] ), .B(n6555), 
        .C(n6553), .D(n6557), .Y(n7769) );
  NAND4XLTS U4537 ( .A(n6549), .B(n6547), .C(n6551), .D(
        \router/addr_calc/fir_read_calc/count[14] ), .Y(n7770) );
  AND2X2TS U4538 ( .A(n6122), .B(n6079), .Y(n6777) );
  AND2X2TS U4539 ( .A(n6094), .B(n6579), .Y(n6761) );
  AND2X2TS U4540 ( .A(n6577), .B(\router/addr_calc/fft_write_addr[28] ), .Y(
        n6765) );
  AND2X2TS U4541 ( .A(\router/addr_calc/fft_write_addr[31] ), .B(n6573), .Y(
        n6757) );
  NAND4XLTS U4542 ( .A(\router/addr_calc/fft_write_calc/count[0] ), .B(n6601), 
        .C(n6599), .D(n6603), .Y(n7725) );
  NAND4XLTS U4543 ( .A(\router/addr_calc/fft_write_calc/count[15] ), .B(n6593), 
        .C(n6597), .D(n6595), .Y(n7726) );
  NAND4XLTS U4544 ( .A(\router/addr_calc/fft_write_calc/count[19] ), .B(n6619), 
        .C(n6591), .D(n6589), .Y(n7727) );
  NOR2X1TS U4545 ( .A(n6401), .B(\router/addr_calc/iir_write_calc/count[0] ), 
        .Y(n6835) );
  NAND4XLTS U4546 ( .A(n6129), .B(\router/addr_calc/fft_write_calc/count[23] ), 
        .C(n6587), .D(n6079), .Y(n7728) );
  OR2X2TS U4547 ( .A(n6115), .B(n6081), .Y(n6847) );
  NAND4XLTS U4548 ( .A(n6154), .B(\router/addr_calc/fft_write_calc/count[27] ), 
        .C(n6094), .D(n6140), .Y(n7721) );
  OR2X1TS U4549 ( .A(n6130), .B(\router/addr_calc/iir_write_calc/count[9] ), 
        .Y(n6843) );
  OR2X2TS U4550 ( .A(n6147), .B(n6082), .Y(n6850) );
  OR2X2TS U4551 ( .A(n6148), .B(n6163), .Y(n6854) );
  OR2X1TS U4552 ( .A(\router/addr_calc/iir_write_calc/count[14] ), .B(n6160), 
        .Y(n6851) );
  OR2X2TS U4553 ( .A(n6164), .B(n6165), .Y(n6845) );
  NAND4XLTS U4554 ( .A(n6617), .B(n6143), .C(
        \router/addr_calc/fft_write_calc/count[28] ), .D(n6575), .Y(n7722) );
  OR2X1TS U4555 ( .A(\router/addr_calc/iir_write_calc/count[18] ), .B(n6161), 
        .Y(n6848) );
  OR2X2TS U4556 ( .A(n6170), .B(n6162), .Y(n6853) );
  NAND4XLTS U4557 ( .A(n6613), .B(n6611), .C(
        \router/addr_calc/fft_write_calc/count[31] ), .D(n6615), .Y(n7723) );
  OR2X2TS U4558 ( .A(n6145), .B(\router/addr_calc/iir_write_addr[23] ), .Y(
        n6849) );
  OR2X2TS U4559 ( .A(n6098), .B(n6387), .Y(n6844) );
  OR2X2TS U4560 ( .A(n6389), .B(\router/addr_calc/iir_write_addr[27] ), .Y(
        n6852) );
  NAND4XLTS U4561 ( .A(n6605), .B(\router/addr_calc/fft_write_calc/count[9] ), 
        .C(n6609), .D(n6607), .Y(n7724) );
  NAND4XLTS U4562 ( .A(\router/addr_calc/iir_write_calc/count[0] ), .B(n6431), 
        .C(n6427), .D(n6435), .Y(n7857) );
  NAND4XLTS U4563 ( .A(n6419), .B(n6415), .C(n6423), .D(
        \router/addr_calc/iir_write_calc/count[14] ), .Y(n7858) );
  NAND4XLTS U4564 ( .A(n6407), .B(n6463), .C(n6411), .D(
        \router/addr_calc/iir_write_calc/count[18] ), .Y(n7859) );
  NAND4XLTS U4565 ( .A(n6145), .B(\router/addr_calc/iir_write_calc/count[23] ), 
        .C(n6403), .D(n6399), .Y(n7860) );
  NAND4XLTS U4566 ( .A(n6159), .B(\router/addr_calc/iir_write_calc/count[27] ), 
        .C(n6098), .D(n6158), .Y(n7853) );
  NAND4XLTS U4567 ( .A(n6459), .B(\router/addr_calc/iir_write_calc/count[30] ), 
        .C(n6141), .D(n6142), .Y(n7854) );
  NAND4XLTS U4568 ( .A(n6451), .B(\router/addr_calc/iir_write_calc/count[5] ), 
        .C(n6137), .D(n6455), .Y(n7855) );
  NAND4XLTS U4569 ( .A(n6439), .B(\router/addr_calc/iir_write_calc/count[9] ), 
        .C(n6447), .D(n6443), .Y(n7856) );
  NOR3X1TS U4570 ( .A(\router/iir_get_req_reg ), .B(n6669), .C(n6725), .Y(
        n7668) );
  NAND4XLTS U4571 ( .A(n6655), .B(\router/addr_calc/fft_read_calc/count[9] ), 
        .C(n6659), .D(n6657), .Y(n7680) );
  NAND4XLTS U4572 ( .A(n6661), .B(\router/addr_calc/fft_read_calc/count[5] ), 
        .C(n6149), .D(n6663), .Y(n7679) );
  NAND4XLTS U4573 ( .A(n6665), .B(\router/addr_calc/fft_read_calc/count[30] ), 
        .C(n6144), .D(n6623), .Y(n7678) );
  NAND4XLTS U4574 ( .A(n6153), .B(\router/addr_calc/fft_read_calc/count[27] ), 
        .C(n6064), .D(n6095), .Y(n7677) );
  INVX2TS U4575 ( .A(n3081), .Y(n6212) );
  INVX2TS U4576 ( .A(\fifo_to_fir/hang[5] ), .Y(n6473) );
  INVX2TS U4577 ( .A(\fifo_to_fir/hang[6] ), .Y(n6477) );
  INVX2TS U4578 ( .A(\fifo_to_fir/hang[7] ), .Y(n6481) );
  INVX2TS U4579 ( .A(\fifo_to_fir/hang[8] ), .Y(n6485) );
  INVX2TS U4580 ( .A(\fifo_to_fir/hang[7] ), .Y(n6480) );
  INVX2TS U4581 ( .A(\fifo_to_fir/hang[8] ), .Y(n6484) );
  INVX2TS U4582 ( .A(\fifo_to_fir/hang[4] ), .Y(n6468) );
  INVX2TS U4583 ( .A(\fifo_to_fir/hang[5] ), .Y(n6472) );
  INVX2TS U4584 ( .A(\fifo_to_fir/hang[10] ), .Y(n6452) );
  INVX2TS U4585 ( .A(\fifo_to_fir/hang[6] ), .Y(n6476) );
  INVX2TS U4586 ( .A(\fifo_to_fir/hang[12] ), .Y(n6460) );
  INVX2TS U4587 ( .A(\fifo_to_fir/hang[11] ), .Y(n6456) );
  INVX2TS U4588 ( .A(\fifo_to_fir/hang[0] ), .Y(n6448) );
  INVX2TS U4589 ( .A(\fifo_to_fir/hang[1] ), .Y(n6464) );
  INVX2TS U4590 ( .A(\fifo_to_fir/hang[4] ), .Y(n6469) );
  INVX2TS U4591 ( .A(n3145), .Y(n6218) );
  INVX2TS U4592 ( .A(n3209), .Y(n6224) );
  INVX2TS U4593 ( .A(n3273), .Y(n6230) );
  INVX2TS U4594 ( .A(n3337), .Y(n6236) );
  INVX2TS U4595 ( .A(n3401), .Y(n6242) );
  INVX2TS U4596 ( .A(n3465), .Y(n6248) );
  INVX2TS U4597 ( .A(n6187), .Y(n6251) );
  INVX2TS U4598 ( .A(\fifo_to_fft/hang[0] ), .Y(n6409) );
  INVX2TS U4599 ( .A(\fifo_to_fft/hang[10] ), .Y(n6413) );
  INVX2TS U4600 ( .A(\fifo_to_fft/hang[11] ), .Y(n6417) );
  INVX2TS U4601 ( .A(\fifo_to_fft/hang[12] ), .Y(n6421) );
  INVX2TS U4602 ( .A(\fifo_to_fft/hang[1] ), .Y(n6425) );
  INVX2TS U4603 ( .A(\fifo_to_fft/hang[4] ), .Y(n6429) );
  INVX2TS U4604 ( .A(\fifo_to_fft/hang[5] ), .Y(n6433) );
  INVX2TS U4605 ( .A(\fifo_to_fft/hang[6] ), .Y(n6437) );
  INVX2TS U4606 ( .A(\fifo_to_fft/hang[7] ), .Y(n6441) );
  INVX2TS U4607 ( .A(\fifo_to_fft/hang[8] ), .Y(n6445) );
  INVX2TS U4608 ( .A(\fifo_to_fft/hang[7] ), .Y(n6440) );
  INVX2TS U4609 ( .A(\fifo_to_fft/hang[8] ), .Y(n6444) );
  INVX2TS U4610 ( .A(\fifo_to_fft/hang[4] ), .Y(n6428) );
  INVX2TS U4611 ( .A(\fifo_to_fft/hang[5] ), .Y(n6432) );
  INVX2TS U4612 ( .A(\fifo_to_fft/hang[10] ), .Y(n6412) );
  INVX2TS U4613 ( .A(\fifo_to_fft/hang[6] ), .Y(n6436) );
  INVX2TS U4614 ( .A(\fifo_to_fft/hang[12] ), .Y(n6420) );
  INVX2TS U4615 ( .A(\fifo_to_fft/hang[11] ), .Y(n6416) );
  INVX2TS U4616 ( .A(\fifo_to_fft/hang[0] ), .Y(n6408) );
  INVX2TS U4617 ( .A(\fifo_to_fft/hang[1] ), .Y(n6424) );
  INVX2TS U4618 ( .A(\fifo_to_fir/hang[0] ), .Y(n6449) );
  INVX2TS U4619 ( .A(\fifo_to_fir/hang[10] ), .Y(n6453) );
  INVX2TS U4620 ( .A(\fifo_to_fir/hang[11] ), .Y(n6457) );
  INVX2TS U4621 ( .A(\fifo_to_fir/hang[12] ), .Y(n6461) );
  INVX2TS U4622 ( .A(\fifo_to_fir/hang[1] ), .Y(n6465) );
  INVX2TS U4623 ( .A(n2185), .Y(n6302) );
  INVX2TS U4624 ( .A(n3017), .Y(n6215) );
  INVX2TS U4625 ( .A(n2953), .Y(n6221) );
  INVX2TS U4626 ( .A(n2889), .Y(n6227) );
  INVX2TS U4627 ( .A(n2825), .Y(n6233) );
  INVX2TS U4628 ( .A(n2761), .Y(n6239) );
  INVX2TS U4629 ( .A(n1673), .Y(n6374) );
  INVX2TS U4630 ( .A(n1737), .Y(n6365) );
  INVX2TS U4631 ( .A(n2697), .Y(n6245) );
  INVX2TS U4632 ( .A(n1801), .Y(n6356) );
  INVX2TS U4633 ( .A(n1865), .Y(n6347) );
  INVX2TS U4634 ( .A(n1929), .Y(n6338) );
  INVX2TS U4635 ( .A(n6173), .Y(n6257) );
  INVX2TS U4636 ( .A(n1993), .Y(n6329) );
  INVX2TS U4637 ( .A(n2441), .Y(n6266) );
  INVX2TS U4638 ( .A(n2057), .Y(n6320) );
  INVX2TS U4639 ( .A(n2377), .Y(n6275) );
  INVX2TS U4640 ( .A(n2121), .Y(n6311) );
  INVX2TS U4641 ( .A(n2313), .Y(n6284) );
  INVX2TS U4642 ( .A(n2249), .Y(n6293) );
  NOR2XLTS U4643 ( .A(n6689), .B(
        \fifo_from_fir/fifo_cell4/controller/valid_read ), .Y(n5788) );
  CLKINVX1TS U4644 ( .A(n6388), .Y(n6389) );
  CLKINVX1TS U4645 ( .A(n6530), .Y(n6531) );
  INVX2TS U4646 ( .A(n6660), .Y(n6661) );
  CLKINVX1TS U4647 ( .A(n6478), .Y(n6479) );
  INVX2TS U4648 ( .A(n6482), .Y(n6483) );
  CLKINVX1TS U4649 ( .A(n6536), .Y(n6537) );
  CLKINVX1TS U4650 ( .A(n6488), .Y(n6489) );
  INVX2TS U4651 ( .A(n6656), .Y(n6657) );
  CLKINVX1TS U4652 ( .A(n6582), .Y(n6583) );
  INVX2TS U4653 ( .A(n6658), .Y(n6659) );
  CLKINVX1TS U4654 ( .A(n6630), .Y(n6631) );
  CLKINVX1TS U4655 ( .A(n6632), .Y(n6633) );
  CLKINVX1TS U4656 ( .A(n6580), .Y(n6581) );
  INVX2TS U4657 ( .A(n6654), .Y(n6655) );
  CLKINVX1TS U4658 ( .A(n6534), .Y(n6535) );
  CLKINVX1TS U4659 ( .A(n6486), .Y(n6487) );
  INVX2TS U4660 ( .A(n6675), .Y(n6676) );
  INVX2TS U4661 ( .A(n6679), .Y(n6680) );
  INVX2TS U4662 ( .A(n6628), .Y(n6629) );
  CLKINVX1TS U4663 ( .A(n6390), .Y(n6391) );
  INVXLTS U4664 ( .A(n7570), .Y(n6732) );
  INVX2TS U4665 ( .A(n6638), .Y(n6639) );
  INVX2TS U4666 ( .A(n6640), .Y(n6641) );
  NAND4XLTS U4667 ( .A(n7498), .B(n7497), .C(n7496), .D(n7495), .Y(n7504) );
  INVX2TS U4668 ( .A(n6644), .Y(n6645) );
  INVX2TS U4669 ( .A(n6673), .Y(n6674) );
  NAND4XLTS U4670 ( .A(n7494), .B(n7493), .C(n7492), .D(n7491), .Y(n7505) );
  NAND4XLTS U4671 ( .A(n7490), .B(n7489), .C(n7488), .D(n7487), .Y(n7506) );
  INVX2TS U4672 ( .A(n6642), .Y(n6643) );
  NAND4XLTS U4673 ( .A(n7477), .B(n7476), .C(n7475), .D(n7474), .Y(n7483) );
  INVX2TS U4674 ( .A(n6636), .Y(n6637) );
  NAND4XLTS U4675 ( .A(n7473), .B(n7472), .C(n7471), .D(n7470), .Y(n7484) );
  NAND4XLTS U4676 ( .A(n7469), .B(n7468), .C(n7467), .D(n7466), .Y(n7485) );
  INVX2TS U4677 ( .A(n6646), .Y(n6647) );
  INVX2TS U4678 ( .A(n6681), .Y(n6682) );
  INVX2TS U4679 ( .A(n6650), .Y(n6651) );
  INVX2TS U4680 ( .A(n6648), .Y(n6649) );
  INVX2TS U4681 ( .A(n6652), .Y(n6653) );
  CLKINVX1TS U4682 ( .A(n6620), .Y(n6621) );
  CLKINVX1TS U4683 ( .A(n6524), .Y(n6525) );
  INVX2TS U4684 ( .A(n6666), .Y(n6667) );
  CLKINVX1TS U4685 ( .A(n6466), .Y(n6467) );
  CLKINVX1TS U4686 ( .A(n6400), .Y(n6401) );
  CLKINVX1TS U4687 ( .A(n6572), .Y(n6573) );
  CLKINVX1TS U4688 ( .A(n6396), .Y(n6397) );
  CLKINVX1TS U4689 ( .A(n6624), .Y(n6625) );
  CLKINVX1TS U4690 ( .A(n6528), .Y(n6529) );
  CLKINVX1TS U4691 ( .A(n6474), .Y(n6475) );
  CLKINVX1TS U4692 ( .A(n6392), .Y(n6393) );
  INVX2TS U4693 ( .A(n6664), .Y(n6665) );
  INVX2TS U4694 ( .A(n6662), .Y(n6663) );
  CLKINVX1TS U4695 ( .A(n6626), .Y(n6627) );
  CLKINVX1TS U4696 ( .A(n6576), .Y(n6577) );
  CLKINVX1TS U4697 ( .A(n6394), .Y(n6395) );
  INVX2TS U4698 ( .A(n6546), .Y(n6547) );
  INVX2TS U4699 ( .A(n6520), .Y(n6521) );
  INVX2TS U4700 ( .A(n6548), .Y(n6549) );
  INVX2TS U4701 ( .A(n6518), .Y(n6519) );
  INVX2TS U4702 ( .A(n6618), .Y(n6619) );
  INVX2TS U4703 ( .A(n6544), .Y(n6545) );
  INVX2TS U4704 ( .A(n6516), .Y(n6517) );
  INVX2TS U4705 ( .A(n6512), .Y(n6513) );
  INVX2TS U4706 ( .A(n6514), .Y(n6515) );
  INVX2TS U4707 ( .A(n6570), .Y(n6571) );
  INVX2TS U4708 ( .A(n6510), .Y(n6511) );
  INVX2TS U4709 ( .A(n6542), .Y(n6543) );
  INVX2TS U4710 ( .A(n6540), .Y(n6541) );
  INVX2TS U4711 ( .A(n6558), .Y(n6559) );
  INVX2TS U4712 ( .A(n6562), .Y(n6563) );
  INVX2TS U4713 ( .A(n6560), .Y(n6561) );
  INVX2TS U4714 ( .A(n6564), .Y(n6565) );
  INVX2TS U4715 ( .A(n6566), .Y(n6567) );
  CLKINVX1TS U4716 ( .A(n6634), .Y(n6635) );
  CLKINVX1TS U4717 ( .A(n6584), .Y(n6585) );
  CLKINVX1TS U4718 ( .A(n6538), .Y(n6539) );
  CLKINVX1TS U4719 ( .A(n6490), .Y(n6491) );
  INVX2TS U4720 ( .A(n6532), .Y(n6533) );
  INVX2TS U4721 ( .A(n6604), .Y(n6605) );
  INVX2TS U4722 ( .A(n6608), .Y(n6609) );
  INVX2TS U4723 ( .A(n6508), .Y(n6509) );
  INVX2TS U4724 ( .A(n6606), .Y(n6607) );
  INVX2TS U4725 ( .A(n6504), .Y(n6505) );
  INVX2TS U4726 ( .A(n6612), .Y(n6613) );
  INVX2TS U4727 ( .A(n6610), .Y(n6611) );
  INVX2TS U4728 ( .A(n6614), .Y(n6615) );
  INVX2TS U4729 ( .A(n6616), .Y(n6617) );
  INVX2TS U4730 ( .A(n6506), .Y(n6507) );
  INVX2TS U4731 ( .A(n6500), .Y(n6501) );
  INVX2TS U4732 ( .A(n6586), .Y(n6587) );
  INVX2TS U4733 ( .A(n6502), .Y(n6503) );
  INVX2TS U4734 ( .A(n6498), .Y(n6499) );
  INVX2TS U4735 ( .A(n6590), .Y(n6591) );
  INVX2TS U4736 ( .A(n6588), .Y(n6589) );
  INVX2TS U4737 ( .A(n6592), .Y(n6593) );
  INVX2TS U4738 ( .A(n6596), .Y(n6597) );
  INVX2TS U4739 ( .A(n6494), .Y(n6495) );
  INVX2TS U4740 ( .A(n6594), .Y(n6595) );
  INVX2TS U4741 ( .A(n6600), .Y(n6601) );
  INVX2TS U4742 ( .A(n6496), .Y(n6497) );
  INVX2TS U4743 ( .A(n6598), .Y(n6599) );
  INVX2TS U4744 ( .A(n6522), .Y(n6523) );
  INVX2TS U4745 ( .A(n6602), .Y(n6603) );
  INVX2TS U4746 ( .A(n6556), .Y(n6557) );
  INVX2TS U4747 ( .A(n6492), .Y(n6493) );
  INVX2TS U4748 ( .A(n6552), .Y(n6553) );
  INVX2TS U4749 ( .A(n6578), .Y(n6579) );
  INVX2TS U4750 ( .A(n6554), .Y(n6555) );
  INVX2TS U4751 ( .A(n6550), .Y(n6551) );
  INVX2TS U4752 ( .A(n6568), .Y(n6569) );
  CLKINVX2TS U4753 ( .A(n6344), .Y(n6346) );
  INVX2TS U4754 ( .A(n6341), .Y(n6342) );
  CLKINVX2TS U4755 ( .A(n6317), .Y(n6319) );
  INVX2TS U4756 ( .A(n6344), .Y(n6345) );
  INVX2TS U4757 ( .A(n6350), .Y(n6351) );
  INVX2TS U4758 ( .A(n6305), .Y(n6306) );
  CLKINVX2TS U4759 ( .A(n6335), .Y(n6337) );
  CLKINVX2TS U4760 ( .A(n6377), .Y(n6379) );
  INVX2TS U4761 ( .A(n6353), .Y(n6354) );
  INVX1TS U4762 ( .A(n6260), .Y(n6262) );
  INVX2TS U4763 ( .A(n6434), .Y(n6435) );
  INVX2TS U4764 ( .A(n6287), .Y(n6288) );
  INVX2TS U4765 ( .A(n6359), .Y(n6360) );
  CLKINVX2TS U4766 ( .A(n6350), .Y(n6352) );
  CLKINVX2TS U4767 ( .A(n6281), .Y(n6283) );
  INVX2TS U4768 ( .A(n6362), .Y(n6363) );
  INVX2TS U4769 ( .A(n6368), .Y(n6369) );
  INVX1TS U4770 ( .A(n7541), .Y(n6725) );
  INVX1TS U4771 ( .A(n6668), .Y(n6669) );
  CLKINVX2TS U4772 ( .A(n6296), .Y(n6298) );
  INVX2TS U4773 ( .A(n6371), .Y(n6372) );
  CLKINVX2TS U4774 ( .A(n6341), .Y(n6343) );
  INVX2TS U4775 ( .A(n6377), .Y(n6378) );
  CLKINVX2TS U4776 ( .A(n6278), .Y(n6280) );
  INVX2TS U4777 ( .A(n6380), .Y(n6381) );
  INVX2TS U4778 ( .A(n6290), .Y(n6291) );
  INVX2TS U4779 ( .A(n6426), .Y(n6427) );
  INVX2TS U4780 ( .A(n6430), .Y(n6431) );
  INVX2TS U4781 ( .A(n6335), .Y(n6336) );
  INVX2TS U4782 ( .A(n6383), .Y(n6384) );
  INVX2TS U4783 ( .A(n6299), .Y(n6300) );
  INVX2TS U4784 ( .A(n6263), .Y(n6264) );
  CLKINVX2TS U4785 ( .A(n6272), .Y(n6274) );
  INVX2TS U4786 ( .A(n6260), .Y(n6261) );
  INVX2TS U4787 ( .A(n6438), .Y(n6439) );
  CLKINVX2TS U4788 ( .A(n6263), .Y(n6265) );
  INVX2TS U4789 ( .A(n6446), .Y(n6447) );
  CLKINVX2TS U4790 ( .A(n6323), .Y(n6325) );
  CLKINVX2TS U4791 ( .A(n6359), .Y(n6361) );
  INVX2TS U4792 ( .A(n6442), .Y(n6443) );
  CLKINVX2TS U4793 ( .A(n6371), .Y(n6373) );
  INVX2TS U4794 ( .A(n6422), .Y(n6423) );
  CLKINVX2TS U4795 ( .A(n6450), .Y(n6451) );
  CLKINVX2TS U4796 ( .A(n6353), .Y(n6355) );
  INVX2TS U4797 ( .A(n6414), .Y(n6415) );
  INVX1TS U4798 ( .A(n6454), .Y(n6455) );
  INVX2TS U4799 ( .A(n6458), .Y(n6459) );
  CLKINVX2TS U4800 ( .A(n6326), .Y(n6328) );
  INVX2TS U4801 ( .A(n6418), .Y(n6419) );
  INVX2TS U4802 ( .A(n6402), .Y(n6403) );
  CLKINVX2TS U4803 ( .A(n6287), .Y(n6289) );
  INVX2TS U4804 ( .A(n6296), .Y(n6297) );
  CLKINVX2TS U4805 ( .A(n6269), .Y(n6271) );
  INVX2TS U4806 ( .A(n6398), .Y(n6399) );
  INVX2TS U4807 ( .A(n6406), .Y(n6407) );
  INVX2TS U4808 ( .A(n6410), .Y(n6411) );
  CLKINVX2TS U4809 ( .A(n6462), .Y(n6463) );
  CLKINVX2TS U4810 ( .A(n6308), .Y(n6310) );
  CLKINVX2TS U4811 ( .A(n6380), .Y(n6382) );
  INVX2TS U4812 ( .A(n6254), .Y(n6255) );
  CLKINVX2TS U4813 ( .A(n6299), .Y(n6301) );
  INVX2TS U4814 ( .A(n6281), .Y(n6282) );
  CLKINVX2TS U4815 ( .A(n6290), .Y(n6292) );
  CLKINVX2TS U4816 ( .A(n6383), .Y(n6385) );
  INVX2TS U4817 ( .A(n6323), .Y(n6324) );
  INVX2TS U4818 ( .A(n6278), .Y(n6279) );
  INVX2TS U4819 ( .A(n6269), .Y(n6270) );
  CLKINVX2TS U4820 ( .A(n6362), .Y(n6364) );
  INVX2TS U4821 ( .A(n6326), .Y(n6327) );
  INVX2TS U4822 ( .A(n6386), .Y(n6387) );
  INVX2TS U4823 ( .A(n6308), .Y(n6309) );
  INVX2TS U4824 ( .A(n6317), .Y(n6318) );
  CLKINVX2TS U4825 ( .A(n6332), .Y(n6334) );
  INVX2TS U4826 ( .A(n6272), .Y(n6273) );
  INVX1TS U4827 ( .A(n6254), .Y(n6256) );
  CLKINVX2TS U4828 ( .A(n6314), .Y(n6316) );
  CLKINVX2TS U4829 ( .A(n6368), .Y(n6370) );
  INVX2TS U4830 ( .A(n6314), .Y(n6315) );
  CLKINVX2TS U4831 ( .A(n6305), .Y(n6307) );
  INVX2TS U4832 ( .A(n6332), .Y(n6333) );
  INVX2TS U4833 ( .A(\fifo_to_fft/hang[9] ), .Y(n7602) );
  INVX2TS U4834 ( .A(n6359), .Y(n2057) );
  INVX2TS U4835 ( .A(n6371), .Y(n1865) );
  INVX1TS U4836 ( .A(n6260), .Y(n1609) );
  INVX2TS U4837 ( .A(n6383), .Y(n1673) );
  INVX2TS U4838 ( .A(n6362), .Y(n1993) );
  INVX1TS U4839 ( .A(n6254), .Y(n2633) );
  INVX2TS U4840 ( .A(n6323), .Y(n2697) );
  CLKINVX2TS U4841 ( .A(\fifo_to_fir/hang[14] ), .Y(n6675) );
  INVX2TS U4842 ( .A(\router/addr_calc/fir_write_calc/counter/hold ), .Y(
        \router/addr_calc/fir_write_calc/counter/N212 ) );
  INVX2TS U4843 ( .A(n6380), .Y(n1737) );
  INVX2TS U4844 ( .A(n6305), .Y(n2953) );
  INVX2TS U4845 ( .A(n6368), .Y(n1929) );
  INVX2TS U4846 ( .A(n6377), .Y(n1801) );
  INVX2TS U4847 ( .A(n6353), .Y(n2121) );
  INVX2TS U4848 ( .A(n6350), .Y(n2185) );
  INVX2TS U4849 ( .A(n6344), .Y(n2249) );
  INVX2TS U4850 ( .A(\fifo_to_fir/tok_xnor_put ), .Y(n4843) );
  INVX1TS U4851 ( .A(\router/iir_write_done ), .Y(n7520) );
  INVX2TS U4852 ( .A(\fifo_to_fir/hang[13] ), .Y(n7563) );
  INVX2TS U4853 ( .A(\router/addr_calc/iir_write_calc/counter/hold ), .Y(
        \router/addr_calc/iir_write_calc/counter/N212 ) );
  INVX2TS U4854 ( .A(\fifo_to_fir/hang[3] ), .Y(n7558) );
  INVX2TS U4855 ( .A(n6341), .Y(n2313) );
  INVX2TS U4856 ( .A(\fifo_to_fft/hang[2] ), .Y(n7595) );
  INVX2TS U4857 ( .A(\fifo_to_fir/hang[2] ), .Y(n7560) );
  INVX2TS U4858 ( .A(\fifo_to_fft/hang[3] ), .Y(n7593) );
  INVX2TS U4859 ( .A(n6317), .Y(n2761) );
  INVX2TS U4860 ( .A(n6335), .Y(n2377) );
  INVX2TS U4861 ( .A(\mips/mips/a/count[0] ), .Y(n7518) );
  INVX2TS U4862 ( .A(n6308), .Y(n2889) );
  INVX2TS U4863 ( .A(\fifo_to_fir/hang[9] ), .Y(n7567) );
  INVX2TS U4864 ( .A(n6332), .Y(n2441) );
  INVX2TS U4865 ( .A(\router/addr_calc/fir_read_calc/counter/hold ), .Y(
        \router/addr_calc/fir_read_calc/counter/N212 ) );
  CLKINVX2TS U4866 ( .A(\fifo_to_fft/hang[14] ), .Y(n6679) );
  INVX2TS U4867 ( .A(n6314), .Y(n2825) );
  INVX2TS U4868 ( .A(\router/addr_calc/fft_write_calc/counter/hold ), .Y(
        \router/addr_calc/fft_write_calc/counter/N212 ) );
  INVXLTS U4869 ( .A(\router/iir_read_done ), .Y(n7671) );
  INVX2TS U4870 ( .A(\router/addr_calc/fft_read_calc/counter/hold ), .Y(
        \router/addr_calc/fft_read_calc/counter/N212 ) );
  INVX2TS U4871 ( .A(n6296), .Y(n3081) );
  INVX2TS U4872 ( .A(\router/ram_write_enable_reg ), .Y(n7917) );
  INVX2TS U4873 ( .A(n6290), .Y(n3145) );
  INVX2TS U4874 ( .A(\router/fir_write_done ), .Y(n7540) );
  INVX2TS U4875 ( .A(n6287), .Y(n3209) );
  INVX2TS U4876 ( .A(n6281), .Y(n3273) );
  CLKINVX2TS U4877 ( .A(\router/fft_write_done ), .Y(n6681) );
  INVX2TS U4878 ( .A(n6278), .Y(n3337) );
  INVX2TS U4879 ( .A(n6272), .Y(n3401) );
  INVX2TS U4880 ( .A(n6269), .Y(n3465) );
  INVX2TS U4881 ( .A(iir_enable), .Y(n7337) );
  CLKINVX2TS U4882 ( .A(\router/ram_read_enable_reg ), .Y(n6673) );
  INVX2TS U4883 ( .A(n6263), .Y(n3593) );
  INVX2TS U4884 ( .A(\fifo_to_fft/hang[13] ), .Y(n7598) );
  INVX2TS U4885 ( .A(\router/fft_get_req_reg ), .Y(n7541) );
  INVX2TS U4886 ( .A(n6326), .Y(n2569) );
  INVX2TS U4887 ( .A(n6299), .Y(n3017) );
  INVX2TS U4888 ( .A(\fifo_to_fft/tok_xnor_put ), .Y(n4773) );
  INVX2TS U4889 ( .A(n7919), .Y(n7361) );
  INVX2TS U4890 ( .A(n7918), .Y(n7389) );
  INVX2TS U4891 ( .A(\router/fir_get_req_reg ), .Y(n6668) );
  INVXLTS U4892 ( .A(n6470), .Y(n6471) );
  INVXLTS U4893 ( .A(n6526), .Y(n6527) );
  INVXLTS U4894 ( .A(n6574), .Y(n6575) );
  INVXLTS U4895 ( .A(n6622), .Y(n6623) );
  INVXLTS U4896 ( .A(n6211), .Y(n6685) );
  INVXLTS U4897 ( .A(n6211), .Y(n6686) );
  INVXLTS U4898 ( .A(n6211), .Y(n6687) );
  INVXLTS U4899 ( .A(reset), .Y(n6688) );
  INVXLTS U4900 ( .A(n6688), .Y(n6689) );
  INVX2TS U4901 ( .A(n6735), .Y(n6736) );
  INVX2TS U4902 ( .A(n6735), .Y(n6739) );
  INVX2TS U4903 ( .A(n6735), .Y(n6738) );
  INVX2TS U4904 ( .A(n6735), .Y(n6737) );
  INVX2TS U4905 ( .A(n6740), .Y(n6741) );
  INVX2TS U4906 ( .A(n6740), .Y(n6744) );
  INVX2TS U4907 ( .A(n6740), .Y(n6743) );
  INVX2TS U4908 ( .A(n6740), .Y(n6742) );
  INVX2TS U4909 ( .A(n6745), .Y(n6748) );
  INVX2TS U4910 ( .A(n6750), .Y(n6751) );
  INVX2TS U4911 ( .A(n6750), .Y(n6753) );
  XOR2X1TS U4912 ( .A(\add_x_22_0/carry[31] ), .B(n6149), .Y(
        \router/addr_calc/fft_read_calc/counter/N77 ) );
  CLKBUFX2TS U4913 ( .A(\router/addr_calc/fft_read_calc/count[30] ), .Y(
        \router/addr_calc/fft_read_addr[30] ) );
  CLKBUFX2TS U4914 ( .A(\router/addr_calc/fft_read_calc/count[0] ), .Y(
        \router/addr_calc/fft_read_addr[0] ) );
  CLKBUFX2TS U4915 ( .A(\router/addr_calc/fft_read_calc/count[23] ), .Y(
        \router/addr_calc/fft_read_addr[23] ) );
  CLKBUFX2TS U4916 ( .A(\router/addr_calc/fft_read_calc/count[27] ), .Y(
        \router/addr_calc/fft_read_addr[27] ) );
  CLKBUFX2TS U4917 ( .A(\router/addr_calc/fft_read_calc/count[5] ), .Y(
        \router/addr_calc/fft_read_addr[5] ) );
  CLKBUFX2TS U4918 ( .A(\router/addr_calc/fft_read_calc/count[18] ), .Y(
        \router/addr_calc/fft_read_addr[18] ) );
  XOR2X1TS U4919 ( .A(\add_x_22_1/carry[31] ), .B(
        \router/addr_calc/fft_write_calc/count[31] ), .Y(
        \router/addr_calc/fft_write_calc/counter/N77 ) );
  CLKBUFX2TS U4920 ( .A(\router/addr_calc/fft_write_calc/count[0] ), .Y(
        \router/addr_calc/fft_write_addr[0] ) );
  CLKBUFX2TS U4921 ( .A(\router/addr_calc/fft_write_calc/count[31] ), .Y(
        \router/addr_calc/fft_write_addr[31] ) );
  CLKBUFX2TS U4922 ( .A(\router/addr_calc/fft_write_calc/count[19] ), .Y(
        \router/addr_calc/fft_write_addr[19] ) );
  CLKBUFX2TS U4923 ( .A(\router/addr_calc/fft_write_calc/count[27] ), .Y(
        \router/addr_calc/fft_write_addr[27] ) );
  CLKBUFX2TS U4924 ( .A(\router/addr_calc/fft_write_calc/count[23] ), .Y(
        \router/addr_calc/fft_write_addr[23] ) );
  CLKBUFX2TS U4925 ( .A(\router/addr_calc/fft_write_calc/count[28] ), .Y(
        \router/addr_calc/fft_write_addr[28] ) );
  XOR2X1TS U4926 ( .A(\add_x_22_2/carry[31] ), .B(n6150), .Y(
        \router/addr_calc/fir_read_calc/counter/N77 ) );
  CLKBUFX2TS U4927 ( .A(\router/addr_calc/fir_read_calc/count[30] ), .Y(
        \router/addr_calc/fir_read_addr[30] ) );
  CLKBUFX2TS U4928 ( .A(\router/addr_calc/fir_read_calc/count[0] ), .Y(
        \router/addr_calc/fir_read_addr[0] ) );
  CLKBUFX2TS U4929 ( .A(\router/addr_calc/fir_read_calc/count[23] ), .Y(
        \router/addr_calc/fir_read_addr[23] ) );
  CLKBUFX2TS U4930 ( .A(\router/addr_calc/fir_read_calc/count[27] ), .Y(
        \router/addr_calc/fir_read_addr[27] ) );
  CLKBUFX2TS U4931 ( .A(\router/addr_calc/fir_read_calc/count[5] ), .Y(
        \router/addr_calc/fir_read_addr[5] ) );
  CLKBUFX2TS U4932 ( .A(\router/addr_calc/fir_read_calc/count[18] ), .Y(
        \router/addr_calc/fir_read_addr[18] ) );
  XOR2X1TS U4933 ( .A(\add_x_22_3/carry[31] ), .B(n6151), .Y(
        \router/addr_calc/fir_write_calc/counter/N77 ) );
  CLKBUFX2TS U4934 ( .A(\router/addr_calc/fir_write_calc/count[30] ), .Y(
        \router/addr_calc/fir_write_addr[30] ) );
  CLKBUFX2TS U4935 ( .A(\router/addr_calc/fir_write_calc/count[0] ), .Y(
        \router/addr_calc/fir_write_addr[0] ) );
  CLKBUFX2TS U4936 ( .A(\router/addr_calc/fir_write_calc/count[15] ), .Y(
        \router/addr_calc/fir_write_addr[15] ) );
  CLKBUFX2TS U4937 ( .A(\router/addr_calc/fir_write_calc/count[19] ), .Y(
        \router/addr_calc/fir_write_addr[19] ) );
  CLKBUFX2TS U4938 ( .A(\router/addr_calc/fir_write_calc/count[27] ), .Y(
        \router/addr_calc/fir_write_addr[27] ) );
  CLKBUFX2TS U4939 ( .A(\router/addr_calc/fir_write_calc/count[23] ), .Y(
        \router/addr_calc/fir_write_addr[23] ) );
  CLKBUFX2TS U4940 ( .A(\router/addr_calc/fir_write_calc/count[5] ), .Y(
        \router/addr_calc/fir_write_addr[5] ) );
  CLKBUFX2TS U4941 ( .A(\router/addr_calc/iir_write_calc/count[5] ), .Y(
        \router/addr_calc/iir_write_addr[5] ) );
  CLKBUFX2TS U4942 ( .A(\router/addr_calc/iir_write_calc/count[0] ), .Y(
        \router/addr_calc/iir_write_addr[0] ) );
  CLKBUFX2TS U4943 ( .A(\router/addr_calc/iir_write_calc/count[9] ), .Y(
        \router/addr_calc/iir_write_addr[9] ) );
  CLKBUFX2TS U4944 ( .A(\router/addr_calc/iir_write_calc/count[27] ), .Y(
        \router/addr_calc/iir_write_addr[27] ) );
  CLKBUFX2TS U4945 ( .A(\router/addr_calc/iir_write_calc/count[23] ), .Y(
        \router/addr_calc/iir_write_addr[23] ) );
  AND2XLTS U4946 ( .A(n6132), .B(\router/addr_calc/fft_read_calc/count[18] ), 
        .Y(n6780) );
  AND2XLTS U4947 ( .A(\router/addr_calc/fft_read_calc/count[14] ), .B(n6136), 
        .Y(n6768) );
  AND2XLTS U4948 ( .A(\router/addr_calc/fft_read_calc/count[9] ), .B(n6077), 
        .Y(n6792) );
  AND2XLTS U4949 ( .A(n6108), .B(\router/addr_calc/fft_read_calc/count[5] ), 
        .Y(n6816) );
  AND2XLTS U4950 ( .A(n6107), .B(n6076), .Y(n6796) );
  AND2XLTS U4951 ( .A(n6062), .B(\router/addr_calc/fft_read_calc/count[0] ), 
        .Y(n6788) );
  AND2XLTS U4952 ( .A(\router/addr_calc/fft_write_calc/count[19] ), .B(n6135), 
        .Y(n6781) );
  AND2XLTS U4953 ( .A(\router/addr_calc/fft_write_calc/count[9] ), .B(n6114), 
        .Y(n6793) );
  AND2XLTS U4954 ( .A(n6106), .B(n6113), .Y(n6817) );
  AND2XLTS U4955 ( .A(n6105), .B(n6075), .Y(n6797) );
  AND2XLTS U4956 ( .A(n6052), .B(\router/addr_calc/fft_write_calc/count[0] ), 
        .Y(n6789) );
  AND2XLTS U4957 ( .A(n6131), .B(\router/addr_calc/fir_read_calc/count[18] ), 
        .Y(n6778) );
  AND2XLTS U4958 ( .A(\router/addr_calc/fir_read_calc/count[14] ), .B(n6134), 
        .Y(n6766) );
  AND2XLTS U4959 ( .A(\router/addr_calc/fir_read_calc/count[9] ), .B(n6112), 
        .Y(n6790) );
  AND2XLTS U4960 ( .A(n6104), .B(\router/addr_calc/fir_read_calc/count[5] ), 
        .Y(n6814) );
  AND2XLTS U4961 ( .A(n6103), .B(n6111), .Y(n6794) );
  AND2XLTS U4962 ( .A(n6061), .B(\router/addr_calc/fir_read_calc/count[0] ), 
        .Y(n6786) );
  AND2XLTS U4963 ( .A(\router/addr_calc/fir_write_calc/count[19] ), .B(n6133), 
        .Y(n6779) );
  AND2XLTS U4964 ( .A(\router/addr_calc/fir_write_calc/count[9] ), .B(n6110), 
        .Y(n6791) );
  AND2XLTS U4965 ( .A(n6102), .B(\router/addr_calc/fir_write_calc/count[5] ), 
        .Y(n6815) );
  AND2XLTS U4966 ( .A(n6101), .B(n6109), .Y(n6795) );
  AND2XLTS U4967 ( .A(n6051), .B(\router/addr_calc/fir_write_calc/count[0] ), 
        .Y(n6787) );
  NAND2X1TS U4968 ( .A(n6146), .B(n6724), .Y(n6834) );
  NAND2X1TS U4969 ( .A(n6836), .B(n6835), .Y(n6837) );
  NOR2XLTS U4970 ( .A(\router/addr_calc/iir_write_calc/count[5] ), .B(n6157), 
        .Y(n6838) );
  INVXLTS U4971 ( .A(n7621), .Y(n7665) );
  AOI211X1TS U4972 ( .A0(n7548), .A1(n7907), .B0(n7664), .C0(n7547), .Y(n7551)
         );
  NAND2X1TS U4973 ( .A(n7363), .B(n7546), .Y(n7621) );
  OAI21XLTS U4974 ( .A0(n5162), .A1(n7518), .B0(n5165), .Y(\mips/mips/a/N50 )
         );
  CLKBUFX2TS U4975 ( .A(n2633), .Y(n7136) );
  CLKBUFX2TS U4976 ( .A(n2633), .Y(n7135) );
  CLKBUFX2TS U4977 ( .A(n1609), .Y(n7183) );
  CLKBUFX2TS U4978 ( .A(n1609), .Y(n7182) );
  OAI33XLTS U4979 ( .A0(n7534), .A1(\router/fir_write_done ), .A2(n7449), .B0(
        n7533), .B1(n7532), .B2(n7531), .Y(n5813) );
  NOR2X1TS U4980 ( .A(n6683), .B(n6733), .Y(n7548) );
  CLKBUFX2TS U4981 ( .A(n7454), .Y(n7434) );
  AOI32X1TS U4982 ( .A0(n6900), .A1(n6678), .A2(n6680), .B0(n7611), .B1(n6749), 
        .Y(n7587) );
  OAI21X1TS U4983 ( .A0(n7611), .A1(n6680), .B0(n6901), .Y(n7612) );
  AOI22X1TS U4984 ( .A0(n6685), .A1(n7571), .B0(\fifo_to_fft/tok_xnor_put ), 
        .B1(n7047), .Y(n7586) );
  NOR4BX1TS U4985 ( .AN(\router/fft_put_req_reg ), .B(n7670), .C(n7460), .D(
        n6404), .Y(n6900) );
  CLKBUFX2TS U4986 ( .A(n7454), .Y(n7433) );
  CLKBUFX2TS U4987 ( .A(n7653), .Y(n6902) );
  CLKBUFX2TS U4988 ( .A(n7654), .Y(n6918) );
  CLKBUFX2TS U4989 ( .A(n7654), .Y(n6916) );
  CLKBUFX2TS U4990 ( .A(n6689), .Y(n7460) );
  CLKBUFX2TS U4991 ( .A(n7459), .Y(n7456) );
  CLKBUFX2TS U4992 ( .A(n4699), .Y(n7088) );
  NAND2X1TS U4993 ( .A(n7377), .B(n7393), .Y(n7537) );
  CLKBUFX2TS U4994 ( .A(n7459), .Y(n7455) );
  NAND2X1TS U4995 ( .A(n7546), .B(\router/data_cntl/N160 ), .Y(n7661) );
  OAI21XLTS U4996 ( .A0(n5162), .A1(n7528), .B0(n5165), .Y(n7527) );
  CLKBUFX2TS U4997 ( .A(\mips/mips/a/N46 ), .Y(n7293) );
  CLKBUFX2TS U4998 ( .A(\mips/mips/a/N46 ), .Y(n7292) );
  CLKBUFX2TS U4999 ( .A(n6689), .Y(n7457) );
  NOR2X1TS U5000 ( .A(n7442), .B(
        \fifo_from_fft/fifo_cell2/controller/valid_read ), .Y(n5649) );
  NOR2X1TS U5001 ( .A(n7445), .B(
        \fifo_from_fir/fifo_cell14/controller/valid_read ), .Y(n5778) );
  NOR2X1TS U5002 ( .A(n7442), .B(
        \fifo_from_fft/fifo_cell6/controller/valid_read ), .Y(n5645) );
  NOR2X1TS U5003 ( .A(n7447), .B(
        \fifo_from_fir/fifo_cell6/controller/valid_read ), .Y(n5786) );
  NOR2X1TS U5004 ( .A(n7441), .B(
        \fifo_from_fft/fifo_cell14/controller/valid_read ), .Y(n5637) );
  NOR2X1TS U5005 ( .A(n7442), .B(
        \fifo_from_fft/fifo_cell5/controller/valid_read ), .Y(n5646) );
  NOR2X1TS U5006 ( .A(n7447), .B(
        \fifo_from_fir/fifo_cell5/controller/valid_read ), .Y(n5787) );
  NOR2X1TS U5007 ( .A(n7444), .B(
        \fifo_from_fft/fifo_cell4/controller/valid_read ), .Y(n5647) );
  NOR2X1TS U5008 ( .A(n7443), .B(
        \fifo_from_fft/fifo_cell13/controller/valid_read ), .Y(n5638) );
  NOR2X1TS U5009 ( .A(n7444), .B(
        \fifo_from_fft/fifo_cell3/controller/valid_read ), .Y(n5648) );
  NOR2X1TS U5010 ( .A(n7445), .B(
        \fifo_from_fir/fifo_cell13/controller/valid_read ), .Y(n5779) );
  NOR2X1TS U5011 ( .A(n7444), .B(
        \fifo_from_fft/fifo_cell1/controller/valid_read ), .Y(n5650) );
  NOR2X1TS U5012 ( .A(n7442), .B(
        \fifo_from_fft/fifo_cell8/controller/valid_read ), .Y(n5643) );
  NOR2X1TS U5013 ( .A(n7445), .B(
        \fifo_from_fft/fifo_cell15/controller/valid_read ), .Y(n5636) );
  NOR2X1TS U5014 ( .A(n7441), .B(
        \fifo_from_fft/fifo_cell9/controller/valid_read ), .Y(n5642) );
  NOR2X1TS U5015 ( .A(n7445), .B(
        \fifo_from_fir/fifo_cell15/controller/valid_read ), .Y(n5777) );
  NOR2X1TS U5016 ( .A(n7447), .B(
        \fifo_from_fir/fifo_cell8/controller/valid_read ), .Y(n5784) );
  NOR2X1TS U5017 ( .A(n7446), .B(
        \fifo_from_fir/fifo_cell9/controller/valid_read ), .Y(n5783) );
  NOR2X1TS U5018 ( .A(n7449), .B(
        \fifo_from_fir/fifo_cell3/controller/valid_read ), .Y(n5789) );
  NOR2X1TS U5019 ( .A(n7450), .B(
        \fifo_from_fir/fifo_cell1/controller/valid_read ), .Y(n5791) );
  NOR2X1TS U5020 ( .A(n7450), .B(
        \fifo_from_fir/fifo_cell2/controller/valid_read ), .Y(n5790) );
  NOR2X1TS U5021 ( .A(n7446), .B(
        \fifo_from_fir/fifo_cell12/controller/valid_read ), .Y(n5780) );
  NOR2X1TS U5022 ( .A(n7441), .B(
        \fifo_from_fft/fifo_cell11/controller/valid_read ), .Y(n5640) );
  NOR2X1TS U5023 ( .A(n7448), .B(
        \fifo_from_fir/fifo_cell0/controller/valid_read ), .Y(n5792) );
  NOR2X1TS U5024 ( .A(n7446), .B(
        \fifo_from_fir/fifo_cell10/controller/valid_read ), .Y(n5782) );
  NOR2X1TS U5025 ( .A(n7443), .B(
        \fifo_from_fft/fifo_cell0/controller/valid_read ), .Y(n5651) );
  NOR2X1TS U5026 ( .A(n7441), .B(
        \fifo_from_fft/fifo_cell12/controller/valid_read ), .Y(n5639) );
  NOR2X1TS U5027 ( .A(n7443), .B(
        \fifo_from_fft/fifo_cell10/controller/valid_read ), .Y(n5641) );
  NOR2X1TS U5028 ( .A(n7447), .B(
        \fifo_from_fir/fifo_cell7/controller/valid_read ), .Y(n5785) );
  NOR2X1TS U5029 ( .A(n7444), .B(
        \fifo_from_fft/fifo_cell7/controller/valid_read ), .Y(n5644) );
  NOR2X1TS U5030 ( .A(n7446), .B(
        \fifo_from_fir/fifo_cell11/controller/valid_read ), .Y(n5781) );
  AND3X2TS U5031 ( .A(instruction[27]), .B(acc_bypass), .C(n7912), .Y(
        \router/pla_top/N60 ) );
  OR4X2TS U5032 ( .A(n7506), .B(n7505), .C(n7504), .D(n7503), .Y(n7507) );
  OR4X2TS U5033 ( .A(n7485), .B(n7484), .C(n7483), .D(n7482), .Y(n7486) );
  INVX2TS U5034 ( .A(n7333), .Y(n7325) );
  INVX2TS U5035 ( .A(n7333), .Y(n7327) );
  INVX2TS U5036 ( .A(n7333), .Y(n7326) );
  INVX2TS U5037 ( .A(n7336), .Y(n7323) );
  INVX2TS U5038 ( .A(n7336), .Y(n7324) );
  INVX2TS U5039 ( .A(n7336), .Y(n7322) );
  CLKBUFX2TS U5040 ( .A(\fifo_from_fir/fifo_cell14/control_signal ), .Y(n7296)
         );
  CLKBUFX2TS U5041 ( .A(\fifo_from_fir/fifo_cell14/control_signal ), .Y(n7297)
         );
  CLKBUFX2TS U5042 ( .A(\fifo_from_fft/fifo_cell14/control_signal ), .Y(n7307)
         );
  CLKBUFX2TS U5043 ( .A(\fifo_from_fft/fifo_cell14/control_signal ), .Y(n7306)
         );
  INVX2TS U5044 ( .A(n7332), .Y(n7329) );
  INVX2TS U5045 ( .A(n7427), .Y(n7395) );
  INVX2TS U5046 ( .A(n7436), .Y(n7421) );
  INVX2TS U5047 ( .A(n7436), .Y(n7422) );
  INVX2TS U5048 ( .A(n7427), .Y(n7394) );
  INVX2TS U5049 ( .A(n7437), .Y(n7423) );
  AOI21X1TS U5050 ( .A0(n7544), .A1(n7548), .B0(n7549), .Y(n7545) );
  OAI21X1TS U5051 ( .A0(\router/iir_read_done ), .A1(n7520), .B0(n7532), .Y(
        n7523) );
  INVX2TS U5052 ( .A(n7522), .Y(n7524) );
  OAI22X1TS U5053 ( .A0(n7440), .A1(
        \fifo_to_fft/fifo_cell14/controller/valid_read ), .B0(n6420), .B1(
        n7049), .Y(n5685) );
  OAI22X1TS U5054 ( .A0(n7440), .A1(
        \fifo_to_fft/fifo_cell15/controller/valid_read ), .B0(n7598), .B1(
        n7049), .Y(n5686) );
  OAI22X1TS U5055 ( .A0(n7458), .A1(
        \fifo_to_fft/fifo_cell13/controller/valid_read ), .B0(n6416), .B1(
        n7049), .Y(n5683) );
  OAI21X1TS U5056 ( .A0(n6673), .A1(n7609), .B0(n7608), .Y(n5672) );
  AOI211X1TS U5057 ( .A0(n7914), .A1(n7899), .B0(n7664), .C0(n7665), .Y(n7609)
         );
  OAI21X1TS U5058 ( .A0(n6734), .A1(n7551), .B0(n7550), .Y(n5769) );
  AOI22X1TS U5059 ( .A0(n7517), .A1(n7516), .B0(n7390), .B1(n7515), .Y(n7896)
         );
  NOR4BX1TS U5060 ( .AN(\fifo_from_fft/fifo_cell10/controller/f_i_get ), .B(
        n7510), .C(n7509), .D(n7508), .Y(n7517) );
  OAI22X1TS U5061 ( .A0(n7440), .A1(
        \fifo_to_fft/fifo_cell5/controller/valid_read ), .B0(n7593), .B1(n7046), .Y(n5692) );
  OAI22X1TS U5062 ( .A0(n7440), .A1(
        \fifo_to_fft/fifo_cell4/controller/valid_read ), .B0(n7595), .B1(n7046), .Y(n5690) );
  OAI22X1TS U5063 ( .A0(n7438), .A1(
        \fifo_to_fft/fifo_cell6/controller/valid_read ), .B0(n6428), .B1(n7046), .Y(n5694) );
  OAI22X1TS U5064 ( .A0(n7428), .A1(
        \fifo_to_fft/fifo_cell7/controller/valid_read ), .B0(n6432), .B1(n7046), .Y(n5696) );
  OAI32X1TS U5065 ( .A0(\fifo_to_fft/hang[12] ), .A1(n7048), .A2(n6416), .B0(
        n6749), .B1(n6421), .Y(n5706) );
  OAI32X1TS U5066 ( .A0(n6680), .A1(n7047), .A2(n7598), .B0(n6747), .B1(n6679), 
        .Y(n5704) );
  AOI211X1TS U5067 ( .A0(n7665), .A1(n6896), .B0(n7664), .C0(n7663), .Y(n7667)
         );
  OAI22X1TS U5068 ( .A0(n7439), .A1(
        \fifo_to_fft/fifo_cell8/controller/valid_read ), .B0(n6436), .B1(n7045), .Y(n5698) );
  OAI22X1TS U5069 ( .A0(n7438), .A1(
        \fifo_to_fft/fifo_cell9/controller/valid_read ), .B0(n6440), .B1(n7045), .Y(n5700) );
  OAI22X1TS U5070 ( .A0(n7439), .A1(
        \fifo_to_fft/fifo_cell10/controller/valid_read ), .B0(n6444), .B1(
        n7045), .Y(n5702) );
  OAI32X1TS U5071 ( .A0(\fifo_to_fft/hang[1] ), .A1(n7044), .A2(n6408), .B0(
        n6747), .B1(n6425), .Y(n5717) );
  OAI32X1TS U5072 ( .A0(\fifo_to_fft/hang[9] ), .A1(n7042), .A2(n6444), .B0(
        n6746), .B1(n7602), .Y(n5709) );
  OAI32X1TS U5073 ( .A0(\fifo_to_fft/hang[0] ), .A1(n7044), .A2(n4773), .B0(
        n6748), .B1(n6409), .Y(n5718) );
  OAI32X1TS U5074 ( .A0(\fifo_to_fft/hang[10] ), .A1(n7042), .A2(n7602), .B0(
        n6678), .B1(n6413), .Y(n5708) );
  OAI32X1TS U5075 ( .A0(\fifo_to_fft/hang[8] ), .A1(n7042), .A2(n6440), .B0(
        n6747), .B1(n6445), .Y(n5710) );
  OAI32X1TS U5076 ( .A0(\fifo_to_fft/hang[7] ), .A1(n7042), .A2(n6436), .B0(
        n6678), .B1(n6441), .Y(n5711) );
  OAI32X1TS U5077 ( .A0(\fifo_to_fft/hang[3] ), .A1(n7044), .A2(n7595), .B0(
        n6749), .B1(n7593), .Y(n5715) );
  OAI32X1TS U5078 ( .A0(\fifo_to_fft/hang[4] ), .A1(n7043), .A2(n7593), .B0(
        n6748), .B1(n6429), .Y(n5714) );
  OAI32X1TS U5079 ( .A0(\fifo_to_fft/hang[2] ), .A1(n7043), .A2(n6424), .B0(
        n6749), .B1(n7595), .Y(n5716) );
  OAI32X1TS U5080 ( .A0(\fifo_to_fft/hang[6] ), .A1(n7043), .A2(n6432), .B0(
        n6746), .B1(n6437), .Y(n5712) );
  OAI32X1TS U5081 ( .A0(\fifo_to_fft/hang[5] ), .A1(n7043), .A2(n6428), .B0(
        n6678), .B1(n6433), .Y(n5713) );
  OAI22X1TS U5082 ( .A0(n7437), .A1(
        \fifo_to_fir/fifo_cell1/controller/valid_read ), .B0(n4843), .B1(n7059), .Y(n5724) );
  OAI22X1TS U5083 ( .A0(n7430), .A1(
        \fifo_to_fir/fifo_cell11/controller/valid_read ), .B0(n7567), .B1(
        n7059), .Y(n5728) );
  OAI22X1TS U5084 ( .A0(n7439), .A1(
        \fifo_to_fir/fifo_cell2/controller/valid_read ), .B0(n6448), .B1(n7059), .Y(n5726) );
  OAI22X1TS U5085 ( .A0(n7434), .A1(
        \fifo_to_fir/fifo_cell12/controller/valid_read ), .B0(n6452), .B1(
        n7059), .Y(n5730) );
  NOR2X1TS U5086 ( .A(n7309), .B(n7616), .Y(\fifo_from_fft/fifo_cell14/N7 ) );
  OAI21X1TS U5087 ( .A0(n7044), .A1(n4773), .B0(n7391), .Y(n3808) );
  OAI21X1TS U5088 ( .A0(n7045), .A1(n7598), .B0(n7391), .Y(n4740) );
  NOR2X1TS U5089 ( .A(n7299), .B(n7539), .Y(\fifo_from_fir/fifo_cell14/N7 ) );
  OAI22X1TS U5090 ( .A0(n7431), .A1(
        \fifo_to_fir/fifo_cell15/controller/valid_read ), .B0(n7563), .B1(
        n7058), .Y(n5735) );
  OAI22X1TS U5091 ( .A0(n7438), .A1(
        \fifo_to_fir/fifo_cell3/controller/valid_read ), .B0(n6464), .B1(n7058), .Y(n5737) );
  OAI22X1TS U5092 ( .A0(n7427), .A1(
        \fifo_to_fir/fifo_cell13/controller/valid_read ), .B0(n6456), .B1(
        n7058), .Y(n5732) );
  OAI22X1TS U5093 ( .A0(n7438), .A1(
        \fifo_to_fir/fifo_cell14/controller/valid_read ), .B0(n6460), .B1(
        n7058), .Y(n5734) );
  OAI21X1TS U5094 ( .A0(n7448), .A1(
        \fifo_to_fft/fifo_cell0/controller/valid_read ), .B0(n7612), .Y(n5670)
         );
  OAI32X1TS U5095 ( .A0(n6676), .A1(n7052), .A2(n7563), .B0(n6671), .B1(n6675), 
        .Y(n5753) );
  OAI21X1TS U5096 ( .A0(n7586), .A1(n7585), .B0(n7392), .Y(n7584) );
  NOR4BX1TS U5097 ( .AN(\router/fft_put_req_reg ), .B(n7670), .C(n7425), .D(
        n6405), .Y(n6901) );
  NOR4BX1TS U5098 ( .AN(\router/fft_put_req_reg ), .B(n7670), .C(n7425), .D(
        n6405), .Y(n4714) );
  OAI32X1TS U5099 ( .A0(\fifo_to_fir/hang[9] ), .A1(n7053), .A2(n6484), .B0(
        n6751), .B1(n7567), .Y(n5758) );
  OAI32X1TS U5100 ( .A0(\fifo_to_fir/hang[10] ), .A1(n7053), .A2(n7567), .B0(
        n6753), .B1(n6453), .Y(n5757) );
  OAI32X1TS U5101 ( .A0(\fifo_to_fir/hang[12] ), .A1(n7052), .A2(n6456), .B0(
        n6751), .B1(n6461), .Y(n5755) );
  OAI32X1TS U5102 ( .A0(\fifo_to_fir/hang[8] ), .A1(n7053), .A2(n6480), .B0(
        n6672), .B1(n6485), .Y(n5759) );
  OAI32X1TS U5103 ( .A0(\fifo_to_fir/hang[11] ), .A1(n7052), .A2(n6452), .B0(
        n6751), .B1(n6457), .Y(n5756) );
  OAI32X1TS U5104 ( .A0(\fifo_to_fir/hang[7] ), .A1(n7053), .A2(n6476), .B0(
        n6672), .B1(n6481), .Y(n5760) );
  OAI32X1TS U5105 ( .A0(\fifo_to_fir/hang[13] ), .A1(n7052), .A2(n6460), .B0(
        n6752), .B1(n7563), .Y(n5754) );
  INVX2TS U5106 ( .A(n7436), .Y(n7420) );
  OAI22X1TS U5107 ( .A0(n7437), .A1(
        \fifo_to_fir/fifo_cell4/controller/valid_read ), .B0(n7560), .B1(n7057), .Y(n5739) );
  OAI22X1TS U5108 ( .A0(n7433), .A1(
        \fifo_to_fir/fifo_cell9/controller/valid_read ), .B0(n6480), .B1(n7056), .Y(n5749) );
  OAI22X1TS U5109 ( .A0(n7432), .A1(
        \fifo_to_fir/fifo_cell10/controller/valid_read ), .B0(n6484), .B1(
        n7056), .Y(n5751) );
  OAI22X1TS U5110 ( .A0(n7436), .A1(
        \fifo_to_fir/fifo_cell6/controller/valid_read ), .B0(n6468), .B1(n7057), .Y(n5743) );
  OAI32X1TS U5111 ( .A0(\fifo_to_fir/hang[5] ), .A1(n7054), .A2(n6468), .B0(
        n6752), .B1(n6473), .Y(n5762) );
  OAI32X1TS U5112 ( .A0(\fifo_to_fir/hang[0] ), .A1(n7055), .A2(n4843), .B0(
        n6671), .B1(n6449), .Y(n5767) );
  OAI32X1TS U5113 ( .A0(\fifo_to_fir/hang[6] ), .A1(n7054), .A2(n6472), .B0(
        n6753), .B1(n6477), .Y(n5761) );
  OAI32X1TS U5114 ( .A0(\fifo_to_fir/hang[4] ), .A1(n7054), .A2(n7558), .B0(
        n6672), .B1(n6469), .Y(n5763) );
  OAI32X1TS U5115 ( .A0(\fifo_to_fir/hang[3] ), .A1(n7055), .A2(n7560), .B0(
        n6671), .B1(n7558), .Y(n5764) );
  OAI32X1TS U5116 ( .A0(\fifo_to_fir/hang[1] ), .A1(n7055), .A2(n6448), .B0(
        n6752), .B1(n6465), .Y(n5766) );
  OAI32X1TS U5117 ( .A0(\fifo_to_fir/hang[2] ), .A1(n7054), .A2(n6464), .B0(
        n6753), .B1(n7560), .Y(n5765) );
  OAI21X1TS U5118 ( .A0(n7055), .A1(n4843), .B0(n7392), .Y(n3760) );
  OAI21X1TS U5119 ( .A0(n7056), .A1(n7563), .B0(n7391), .Y(n4810) );
  OAI21X1TS U5120 ( .A0(n7448), .A1(
        \fifo_to_fir/fifo_cell0/controller/valid_read ), .B0(n7615), .Y(n5668)
         );
  OAI21X1TS U5121 ( .A0(n7614), .A1(n6676), .B0(n7062), .Y(n7615) );
  AOI31X1TS U5122 ( .A0(n7062), .A1(n6676), .A2(n4843), .B0(n7614), .Y(n7613)
         );
  AND2X2TS U5123 ( .A(n7077), .B(\fifo_from_fir/fifo_cell11/reg_gtok/token ), 
        .Y(\fifo_from_fir/fifo_cell12/data_out/N35 ) );
  AND2X2TS U5124 ( .A(n7077), .B(\fifo_from_fir/fifo_cell12/reg_gtok/token ), 
        .Y(\fifo_from_fir/fifo_cell13/data_out/N35 ) );
  AND2X2TS U5125 ( .A(n7077), .B(\fifo_from_fir/fifo_cell10/reg_gtok/token ), 
        .Y(\fifo_from_fir/fifo_cell11/data_out/N35 ) );
  CLKBUFX2TS U5126 ( .A(n4915), .Y(n7079) );
  AND2X2TS U5127 ( .A(n7089), .B(\fifo_from_fft/fifo_cell11/reg_gtok/token ), 
        .Y(\fifo_from_fft/fifo_cell12/data_out/N35 ) );
  AND2X2TS U5128 ( .A(n7089), .B(\fifo_from_fft/fifo_cell12/reg_gtok/token ), 
        .Y(\fifo_from_fft/fifo_cell13/data_out/N35 ) );
  AND2X2TS U5129 ( .A(n7087), .B(\fifo_from_fft/fifo_cell10/reg_gtok/token ), 
        .Y(\fifo_from_fft/fifo_cell11/data_out/N35 ) );
  OAI21X1TS U5130 ( .A0(\fifo_to_fir/fifo_cell15/controller/f_i_put ), .A1(
        \fifo_to_fir/fifo_cell15/controller/f_i_get ), .B0(n7393), .Y(n7499)
         );
  OAI21X1TS U5131 ( .A0(\fifo_to_fft/fifo_cell15/controller/f_i_put ), .A1(
        \fifo_to_fft/fifo_cell15/controller/f_i_get ), .B0(n7392), .Y(n7478)
         );
  INVX2TS U5132 ( .A(n7357), .Y(fir_enable) );
  CLKBUFX2TS U5133 ( .A(\mips/mips/a/N46 ), .Y(n7290) );
  CLKBUFX2TS U5134 ( .A(\mips/mips/a/N46 ), .Y(n7291) );
  CLKBUFX2TS U5135 ( .A(n7459), .Y(n7440) );
  INVX2TS U5136 ( .A(n7355), .Y(n7341) );
  INVX2TS U5137 ( .A(n7358), .Y(n7351) );
  INVX2TS U5138 ( .A(n7358), .Y(n7352) );
  INVX2TS U5139 ( .A(n7355), .Y(n7342) );
  INVX2TS U5140 ( .A(n7355), .Y(n7343) );
  INVX2TS U5141 ( .A(n7387), .Y(n7371) );
  INVX2TS U5142 ( .A(n7330), .Y(n7314) );
  INVX2TS U5143 ( .A(n7356), .Y(n7346) );
  INVX2TS U5144 ( .A(n7387), .Y(n7370) );
  OAI21XLTS U5145 ( .A0(n4348), .A1(n7897), .B0(n7362), .Y(n7898) );
  OAI211XLTS U5146 ( .A0(from_fir_empty), .A1(to_fir_empty), .B0(n7901), .C0(
        n6726), .Y(n7903) );
  AOI211XLTS U5147 ( .A0(to_fft_empty), .A1(n7900), .B0(from_fft_empty), .C0(
        n7382), .Y(\router/data_cntl/N150 ) );
  AOI211XLTS U5148 ( .A0(to_fir_empty), .A1(n7909), .B0(from_fir_empty), .C0(
        n6684), .Y(\router/data_cntl/N156 ) );
  OAI211XLTS U5149 ( .A0(to_fft_empty), .A1(from_fft_empty), .B0(n7896), .C0(
        n7899), .Y(n7897) );
  AOI211XLTS U5150 ( .A0(\router/data_from_fft ), .A1(\router/addr_calc/N9 ), 
        .B0(n7379), .C0(n6896), .Y(n5634) );
  AOI211XLTS U5151 ( .A0(\router/data_to_fft ), .A1(\router/addr_calc/N63 ), 
        .B0(n6897), .C0(n7381), .Y(n5635) );
  AND2XLTS U5152 ( .A(\router/data_cntl/N168 ), .B(n7605), .Y(n5674) );
  AOI211XLTS U5153 ( .A0(\router/data_from_fir ), .A1(\router/addr_calc/N95 ), 
        .B0(n4794), .C0(n6683), .Y(n5722) );
  AOI211XLTS U5154 ( .A0(\router/addr_calc/N99 ), .A1(n6898), .B0(n6894), .C0(
        n6684), .Y(n5723) );
  OAI32XLTS U5155 ( .A0(\router/addr_calc/iir_write_calc/counter/hold ), .A1(
        \router/addr_calc/iir_write_calc/counter/N40 ), .A2(n7337), .B0(n7520), 
        .B1(n7239), .Y(n5946) );
  OAI22XLTS U5156 ( .A0(n4794), .A1(n7620), .B0(n6896), .B1(n7621), .Y(n5772)
         );
  INVXLTS U5157 ( .A(\router/data_cntl/fir_full_flag ), .Y(n7904) );
  OAI21XLTS U5158 ( .A0(n6732), .A1(n7540), .B0(n7529), .Y(n7530) );
  AOI21XLTS U5159 ( .A0(n6895), .A1(\router/fft_write_done ), .B0(n7538), .Y(
        n7535) );
  NOR3XLTS U5160 ( .A(\router/addr_calc/iir_write_calc/counter/hold ), .B(
        n7028), .C(n7334), .Y(n5947) );
  AOI21XLTS U5161 ( .A0(n7609), .A1(\router/fft_put_req_reg ), .B0(n7913), .Y(
        n7608) );
  AOI21XLTS U5162 ( .A0(n7551), .A1(\router/fir_put_req_reg ), .B0(n7549), .Y(
        n7550) );
  OAI32XLTS U5163 ( .A0(\fifo_to_fft/hang[13] ), .A1(n7916), .A2(n6420), .B0(
        n6746), .B1(n7598), .Y(n5705) );
  OAI31XLTS U5164 ( .A0(n7668), .A1(n7667), .A2(\router/ram_read_enable_reg ), 
        .B0(n7666), .Y(n5600) );
  AOI211XLTS U5165 ( .A0(n7362), .A1(\router/fft_get_req_reg ), .B0(n6674), 
        .C0(n7659), .Y(n7662) );
  OAI32XLTS U5166 ( .A0(\router/addr_calc/fft_write_calc/counter/hold ), .A1(
        \router/addr_calc/fft_write_calc/counter/N40 ), .A2(n7381), .B0(n6681), 
        .B1(n7269), .Y(n5809) );
  OAI32XLTS U5167 ( .A0(\router/addr_calc/fir_read_calc/counter/hold ), .A1(
        \router/addr_calc/fir_read_calc/counter/N40 ), .A2(n7356), .B0(n7570), 
        .B1(n7259), .Y(n5720) );
  INVXLTS U5168 ( .A(\router/fir_read_done ), .Y(n7570) );
  OAI32XLTS U5169 ( .A0(\router/addr_calc/fir_write_calc/counter/hold ), .A1(
        \router/addr_calc/fir_write_calc/counter/N40 ), .A2(n7361), .B0(n7540), 
        .B1(n7249), .Y(n5775) );
  OAI32XLTS U5170 ( .A0(\router/addr_calc/fft_read_calc/counter/hold ), .A1(
        \router/addr_calc/fft_read_calc/counter/N40 ), .A2(n7380), .B0(n6895), 
        .B1(n7279), .Y(n5812) );
  AOI22XLTS U5171 ( .A0(\fifo_to_fft/hang[11] ), .A1(\fifo_to_fft/hang[12] ), 
        .B0(n6420), .B1(n6416), .Y(n7577) );
  AOI22XLTS U5172 ( .A0(\fifo_to_fft/hang[5] ), .A1(\fifo_to_fft/hang[4] ), 
        .B0(n6428), .B1(n6432), .Y(n7572) );
  AOI22XLTS U5173 ( .A0(\fifo_to_fft/hang[8] ), .A1(\fifo_to_fft/hang[7] ), 
        .B0(n6440), .B1(n6444), .Y(n7574) );
  INVX2TS U5174 ( .A(n6686), .Y(n7916) );
  AOI22XLTS U5175 ( .A0(\fifo_to_fft/hang[1] ), .A1(\fifo_to_fft/hang[0] ), 
        .B0(n6408), .B1(n6424), .Y(n7571) );
  NOR3XLTS U5176 ( .A(\router/addr_calc/fir_read_calc/counter/hold ), .B(n6988), .C(n7358), .Y(n5721) );
  NOR3XLTS U5177 ( .A(\router/addr_calc/fft_write_calc/counter/hold ), .B(
        n6968), .C(n7383), .Y(n5810) );
  NOR3XLTS U5178 ( .A(\router/addr_calc/fft_read_calc/counter/hold ), .B(n6948), .C(n7383), .Y(n5601) );
  NOR3XLTS U5179 ( .A(\router/addr_calc/fir_write_calc/counter/hold ), .B(
        n7008), .C(n7359), .Y(n5776) );
  AOI21XLTS U5180 ( .A0(n7338), .A1(\router/fir_read_done ), .B0(n7673), .Y(
        n7675) );
  NOR2XLTS U5181 ( .A(\router/fft_read_done ), .B(n7385), .Y(n7676) );
  AOI22XLTS U5182 ( .A0(\router/addr_calc/iir_write_calc/count[18] ), .A1(
        n7024), .B0(n7894), .B1(\router/addr_calc/iir_write_calc/counter/N64 ), 
        .Y(n7881) );
  CLKBUFX2TS U5183 ( .A(n7895), .Y(n7027) );
  AOI22XLTS U5184 ( .A0(\router/addr_calc/iir_write_calc/count[14] ), .A1(
        n7025), .B0(n7015), .B1(\router/addr_calc/iir_write_calc/counter/N60 ), 
        .Y(n7877) );
  AOI22XLTS U5185 ( .A0(\router/addr_calc/iir_write_calc/count[9] ), .A1(n7026), .B0(n7014), .B1(\router/addr_calc/iir_write_calc/counter/N55 ), .Y(n7872) );
  CLKBUFX2TS U5186 ( .A(n7031), .Y(n7026) );
  INVX2TS U5187 ( .A(n7331), .Y(n7319) );
  CLKBUFX2TS U5188 ( .A(n6893), .Y(n7062) );
  AOI22XLTS U5189 ( .A0(n6545), .A1(n6984), .B0(n7806), .B1(
        \router/addr_calc/fir_read_calc/counter/N63 ), .Y(n7792) );
  AOI22XLTS U5190 ( .A0(n6591), .A1(n6964), .B0(n7762), .B1(
        \router/addr_calc/fft_write_calc/counter/N63 ), .Y(n7748) );
  AOI22XLTS U5191 ( .A0(n6641), .A1(n6944), .B0(n7718), .B1(
        \router/addr_calc/fft_read_calc/counter/N63 ), .Y(n7704) );
  AOI22XLTS U5192 ( .A0(n6497), .A1(n7004), .B0(n7850), .B1(
        \router/addr_calc/fir_write_calc/counter/N63 ), .Y(n7836) );
  AOI22XLTS U5193 ( .A0(\router/addr_calc/fir_read_calc/count[18] ), .A1(n6984), .B0(n6980), .B1(\router/addr_calc/fir_read_calc/counter/N64 ), .Y(n7793) );
  AOI22XLTS U5194 ( .A0(\router/addr_calc/fir_write_calc/count[19] ), .A1(
        n7003), .B0(n7000), .B1(\router/addr_calc/fir_write_calc/counter/N65 ), 
        .Y(n7838) );
  AOI22XLTS U5195 ( .A0(\router/addr_calc/fft_write_calc/count[19] ), .A1(
        n6963), .B0(n6960), .B1(\router/addr_calc/fft_write_calc/counter/N65 ), 
        .Y(n7750) );
  AOI22XLTS U5196 ( .A0(\router/addr_calc/fft_read_calc/count[18] ), .A1(n6944), .B0(n6940), .B1(\router/addr_calc/fft_read_calc/counter/N64 ), .Y(n7705) );
  INVX2TS U5197 ( .A(n7620), .Y(n7547) );
  CLKBUFX2TS U5198 ( .A(n7807), .Y(n6987) );
  AOI22XLTS U5199 ( .A0(\router/addr_calc/fir_write_calc/count[15] ), .A1(
        n7004), .B0(n6995), .B1(\router/addr_calc/fir_write_calc/counter/N61 ), 
        .Y(n7834) );
  CLKBUFX2TS U5200 ( .A(n7851), .Y(n7007) );
  AOI22XLTS U5201 ( .A0(\router/addr_calc/fft_write_calc/count[15] ), .A1(
        n6964), .B0(n6955), .B1(\router/addr_calc/fft_write_calc/counter/N61 ), 
        .Y(n7746) );
  CLKBUFX2TS U5202 ( .A(n7763), .Y(n6967) );
  CLKBUFX2TS U5203 ( .A(n7719), .Y(n6947) );
  INVX2TS U5204 ( .A(n7385), .Y(n7376) );
  CLKBUFX2TS U5205 ( .A(n4915), .Y(n7078) );
  CLKBUFX2TS U5206 ( .A(n4915), .Y(n7077) );
  NOR2BX1TS U5207 ( .AN(\mips/mips/accfullinstruction[22] ), .B(n7037), .Y(
        n5823) );
  NOR2BX1TS U5208 ( .AN(\mips/mips/accfullinstruction[21] ), .B(n7037), .Y(
        n5824) );
  NOR2BX1TS U5209 ( .AN(\mips/mips/accfullinstruction[19] ), .B(n7036), .Y(
        n5826) );
  NOR2BX1TS U5210 ( .AN(\mips/mips/accfullinstruction[18] ), .B(n7036), .Y(
        n5827) );
  NOR2BX1TS U5211 ( .AN(\mips/mips/accfullinstruction[17] ), .B(n7036), .Y(
        n5828) );
  NOR2BX1TS U5212 ( .AN(\mips/mips/accfullinstruction[16] ), .B(n7036), .Y(
        n5829) );
  NOR2BX1TS U5213 ( .AN(\mips/mips/accfullinstruction[15] ), .B(n7035), .Y(
        n5830) );
  NOR2BX1TS U5214 ( .AN(\mips/mips/accfullinstruction[14] ), .B(n7035), .Y(
        n5831) );
  NOR2BX1TS U5215 ( .AN(\mips/mips/accfullinstruction[13] ), .B(n7035), .Y(
        n5832) );
  NOR2BX1TS U5216 ( .AN(\mips/mips/accfullinstruction[12] ), .B(n7035), .Y(
        n5833) );
  NOR2BX1TS U5217 ( .AN(\mips/mips/accfullinstruction[11] ), .B(n7034), .Y(
        n5834) );
  NOR2BX1TS U5218 ( .AN(\mips/mips/accfullinstruction[10] ), .B(n7034), .Y(
        n5835) );
  NOR2BX1TS U5219 ( .AN(\mips/mips/accfullinstruction[9] ), .B(n7034), .Y(
        n5836) );
  NOR2BX1TS U5220 ( .AN(\mips/mips/accfullinstruction[8] ), .B(n7034), .Y(
        n5837) );
  NOR2BX1TS U5221 ( .AN(\mips/mips/accfullinstruction[7] ), .B(n7033), .Y(
        n5838) );
  NOR2BX1TS U5222 ( .AN(\mips/mips/accfullinstruction[6] ), .B(n7033), .Y(
        n5839) );
  NOR2BX1TS U5223 ( .AN(\mips/mips/accfullinstruction[5] ), .B(n7033), .Y(
        n5840) );
  NOR2BX1TS U5224 ( .AN(\mips/mips/accfullinstruction[4] ), .B(n7033), .Y(
        n5841) );
  NOR2BX1TS U5225 ( .AN(\mips/mips/accfullinstruction[3] ), .B(n7032), .Y(
        n5842) );
  NOR2BX1TS U5226 ( .AN(\mips/mips/accfullinstruction[2] ), .B(n7032), .Y(
        n5843) );
  NOR2BX1TS U5227 ( .AN(\mips/mips/accfullinstruction[1] ), .B(n7032), .Y(
        n5844) );
  NOR2BX1TS U5228 ( .AN(\mips/mips/accfullinstruction[0] ), .B(n7032), .Y(
        n5845) );
  NOR2BX1TS U5229 ( .AN(\mips/mips/accbypass ), .B(n7039), .Y(n5942) );
  NOR2BX1TS U5230 ( .AN(\mips/mips/accfullinstruction[26] ), .B(n7039), .Y(
        n5819) );
  NOR2BX1TS U5231 ( .AN(\mips/mips/accfullinstruction[27] ), .B(n7039), .Y(
        n5818) );
  NOR2BX1TS U5232 ( .AN(\mips/mips/accfullinstruction[29] ), .B(n7038), .Y(
        n5816) );
  NOR2BX1TS U5233 ( .AN(\mips/mips/accfullinstruction[31] ), .B(n7038), .Y(
        n5814) );
  NAND2X1TS U5236 ( .A(n7401), .B(n7486), .Y(\fifo_to_fft/empty_det/N4 ) );
  NAND2X1TS U5237 ( .A(n7401), .B(n7507), .Y(\fifo_to_fir/empty_det/N4 ) );
  NAND4X1TS U5238 ( .A(\fifo_from_fft/fifo_cell3/controller/f_i_get ), .B(
        \fifo_from_fft/fifo_cell14/controller/f_i_get ), .C(
        \fifo_from_fft/fifo_cell15/controller/f_i_get ), .D(
        \fifo_from_fft/fifo_cell12/controller/f_i_get ), .Y(n7510) );
  NAND4X1TS U5239 ( .A(\fifo_from_fft/fifo_cell13/controller/f_i_get ), .B(
        \fifo_from_fft/fifo_cell11/controller/f_i_get ), .C(
        \fifo_from_fft/fifo_cell1/controller/f_i_get ), .D(
        \fifo_from_fft/fifo_cell0/controller/f_i_get ), .Y(n7509) );
  NAND4X1TS U5240 ( .A(n7514), .B(n7513), .C(n7512), .D(n7511), .Y(n7515) );
  NAND3X1TS U5241 ( .A(n7314), .B(n7524), .C(n7523), .Y(n7521) );
  OAI33XLTS U5242 ( .A0(n7538), .A1(n6682), .A2(n7449), .B0(n7537), .B1(n7536), 
        .B2(n7535), .Y(n5811) );
  MXI2X1TS U5243 ( .A(n6733), .B(n7904), .S0(n7545), .Y(n5770) );
  NOR2BX1TS U5244 ( .AN(n7546), .B(\router/data_cntl/N159 ), .Y(n7664) );
  AOI2BB2X1TS U5245 ( .B0(n7613), .B1(n6672), .A0N(n6753), .A1N(
        \fifo_to_fir/tok_xnor_put ), .Y(n5768) );
  OAI2BB1X1TS U5246 ( .A0N(\fifo_to_fir/fifo_cell0/controller/f_i_put ), .A1N(
        n6688), .B0(n7552), .Y(n5752) );
  NAND2X1TS U5247 ( .A(n7399), .B(n6477), .Y(n7555) );
  NAND2X1TS U5248 ( .A(n7399), .B(n6469), .Y(n7557) );
  NAND2X1TS U5249 ( .A(n7398), .B(n7558), .Y(n7559) );
  NAND2X1TS U5250 ( .A(n7399), .B(n7560), .Y(n7561) );
  NAND2X1TS U5251 ( .A(n7399), .B(n6465), .Y(n7562) );
  NAND2X1TS U5252 ( .A(n7398), .B(n6461), .Y(n7564) );
  NAND2X1TS U5253 ( .A(n7398), .B(n6457), .Y(n7565) );
  NAND2X1TS U5254 ( .A(n7398), .B(n6453), .Y(n7566) );
  XOR2X1TS U5255 ( .A(n7574), .B(n7573), .Y(n7576) );
  OAI221XLTS U5256 ( .A0(\fifo_to_fft/hang[10] ), .A1(\fifo_to_fft/hang[6] ), 
        .B0(n6412), .B1(n6436), .C0(n4714), .Y(n7581) );
  XOR2X1TS U5257 ( .A(\fifo_to_fft/hang[13] ), .B(n7577), .Y(n7579) );
  XNOR2X1TS U5258 ( .A(n7581), .B(n7580), .Y(n7582) );
  XOR2X1TS U5259 ( .A(n7583), .B(n7582), .Y(n7585) );
  AOI2BB2X1TS U5260 ( .B0(n7610), .B1(n6748), .A0N(n6748), .A1N(
        \fifo_to_fft/tok_xnor_put ), .Y(n5719) );
  OAI2BB1X1TS U5261 ( .A0N(\fifo_to_fft/fifo_cell0/controller/f_i_put ), .A1N(
        n7424), .B0(n7587), .Y(n5703) );
  NAND2X1TS U5262 ( .A(n7396), .B(n6441), .Y(n7589) );
  NAND2X1TS U5263 ( .A(n7396), .B(n6437), .Y(n7590) );
  NAND2X1TS U5264 ( .A(n7396), .B(n6433), .Y(n7591) );
  NAND2X1TS U5265 ( .A(n7396), .B(n6429), .Y(n7592) );
  NAND2X1TS U5266 ( .A(n7395), .B(n7593), .Y(n7594) );
  NAND2X1TS U5267 ( .A(n7395), .B(n7595), .Y(n7596) );
  NAND2X1TS U5268 ( .A(n7394), .B(n6425), .Y(n7597) );
  NAND2X1TS U5269 ( .A(n7395), .B(n6421), .Y(n7599) );
  NAND2X1TS U5270 ( .A(n7395), .B(n6417), .Y(n7600) );
  NAND2X1TS U5271 ( .A(n7394), .B(n6413), .Y(n7601) );
  NAND2X1TS U5272 ( .A(n7394), .B(n7602), .Y(n7603) );
  NAND2X1TS U5273 ( .A(n7394), .B(n6409), .Y(n7604) );
  NOR2BX1TS U5274 ( .AN(n7607), .B(n7606), .Y(n7913) );
  AOI222XLTS U5275 ( .A0(n7655), .A1(\router/data_cntl/data_in[17] ), .B0(
        n6915), .B1(fir_data_in[17]), .C0(n6904), .C1(fft_data_in[17]), .Y(
        n7639) );
  AOI222XLTS U5276 ( .A0(n7655), .A1(\router/data_cntl/data_in[18] ), .B0(
        n6915), .B1(fir_data_in[18]), .C0(n6904), .C1(fft_data_in[18]), .Y(
        n7640) );
  AOI222XLTS U5277 ( .A0(n6922), .A1(\router/data_cntl/data_in[29] ), .B0(
        n6912), .B1(fir_data_in[29]), .C0(n7653), .C1(fft_data_in[29]), .Y(
        n7651) );
  NAND2X1TS U5278 ( .A(n7377), .B(n7688), .Y(
        \router/addr_calc/fft_read_calc/counter/N179 ) );
  NAND2X1TS U5279 ( .A(n7377), .B(n7689), .Y(
        \router/addr_calc/fft_read_calc/counter/N180 ) );
  NAND2X1TS U5280 ( .A(n7377), .B(n7690), .Y(
        \router/addr_calc/fft_read_calc/counter/N181 ) );
  NAND2X1TS U5281 ( .A(n7376), .B(n7691), .Y(
        \router/addr_calc/fft_read_calc/counter/N182 ) );
  NAND2X1TS U5282 ( .A(n7376), .B(n7692), .Y(
        \router/addr_calc/fft_read_calc/counter/N183 ) );
  NAND2X1TS U5283 ( .A(n7376), .B(n7693), .Y(
        \router/addr_calc/fft_read_calc/counter/N184 ) );
  NAND2X1TS U5284 ( .A(n7376), .B(n7694), .Y(
        \router/addr_calc/fft_read_calc/counter/N185 ) );
  NAND2X1TS U5285 ( .A(n7375), .B(n7695), .Y(
        \router/addr_calc/fft_read_calc/counter/N186 ) );
  NAND2X1TS U5286 ( .A(n7375), .B(n7696), .Y(
        \router/addr_calc/fft_read_calc/counter/N187 ) );
  NAND2X1TS U5287 ( .A(n7375), .B(n7697), .Y(
        \router/addr_calc/fft_read_calc/counter/N188 ) );
  NAND2X1TS U5288 ( .A(n7375), .B(n7698), .Y(
        \router/addr_calc/fft_read_calc/counter/N189 ) );
  NAND2X1TS U5289 ( .A(n7374), .B(n7699), .Y(
        \router/addr_calc/fft_read_calc/counter/N190 ) );
  NAND2X1TS U5290 ( .A(n7374), .B(n7700), .Y(
        \router/addr_calc/fft_read_calc/counter/N191 ) );
  NAND2X1TS U5291 ( .A(n7374), .B(n7701), .Y(
        \router/addr_calc/fft_read_calc/counter/N192 ) );
  NAND2X1TS U5292 ( .A(n7374), .B(n7702), .Y(
        \router/addr_calc/fft_read_calc/counter/N193 ) );
  NAND2X1TS U5293 ( .A(n7373), .B(n7703), .Y(
        \router/addr_calc/fft_read_calc/counter/N194 ) );
  NAND2X1TS U5294 ( .A(n7373), .B(n7706), .Y(
        \router/addr_calc/fft_read_calc/counter/N197 ) );
  NAND2X1TS U5295 ( .A(n7372), .B(n7707), .Y(
        \router/addr_calc/fft_read_calc/counter/N198 ) );
  NAND2X1TS U5296 ( .A(n7372), .B(n7708), .Y(
        \router/addr_calc/fft_read_calc/counter/N199 ) );
  NAND2X1TS U5297 ( .A(n7372), .B(n7709), .Y(
        \router/addr_calc/fft_read_calc/counter/N200 ) );
  NAND2X1TS U5298 ( .A(n7372), .B(n7710), .Y(
        \router/addr_calc/fft_read_calc/counter/N201 ) );
  NAND2X1TS U5299 ( .A(n7371), .B(n7711), .Y(
        \router/addr_calc/fft_read_calc/counter/N202 ) );
  NAND2X1TS U5300 ( .A(n7371), .B(n7712), .Y(
        \router/addr_calc/fft_read_calc/counter/N203 ) );
  NAND2X1TS U5301 ( .A(n7371), .B(n7713), .Y(
        \router/addr_calc/fft_read_calc/counter/N204 ) );
  NAND2X1TS U5302 ( .A(n7371), .B(n7714), .Y(
        \router/addr_calc/fft_read_calc/counter/N205 ) );
  NAND2X1TS U5303 ( .A(n7370), .B(n7715), .Y(
        \router/addr_calc/fft_read_calc/counter/N206 ) );
  NAND2X1TS U5304 ( .A(n7370), .B(n7716), .Y(
        \router/addr_calc/fft_read_calc/counter/N207 ) );
  NAND2X1TS U5305 ( .A(n7370), .B(n7717), .Y(
        \router/addr_calc/fft_read_calc/counter/N208 ) );
  NAND2X1TS U5306 ( .A(n7370), .B(n7720), .Y(
        \router/addr_calc/fft_read_calc/counter/N209 ) );
  NAND2X1TS U5307 ( .A(fft_enable), .B(n7732), .Y(
        \router/addr_calc/fft_write_calc/counter/N179 ) );
  NAND2X1TS U5308 ( .A(fft_enable), .B(n7733), .Y(
        \router/addr_calc/fft_write_calc/counter/N180 ) );
  NAND2X1TS U5309 ( .A(fft_enable), .B(n7734), .Y(
        \router/addr_calc/fft_write_calc/counter/N181 ) );
  NAND2X1TS U5310 ( .A(n7369), .B(n7735), .Y(
        \router/addr_calc/fft_write_calc/counter/N182 ) );
  NAND2X1TS U5311 ( .A(n7369), .B(n7736), .Y(
        \router/addr_calc/fft_write_calc/counter/N183 ) );
  NAND2X1TS U5312 ( .A(n7369), .B(n7737), .Y(
        \router/addr_calc/fft_write_calc/counter/N184 ) );
  NAND2X1TS U5313 ( .A(n7369), .B(n7738), .Y(
        \router/addr_calc/fft_write_calc/counter/N185 ) );
  NAND2X1TS U5314 ( .A(n7368), .B(n7739), .Y(
        \router/addr_calc/fft_write_calc/counter/N186 ) );
  NAND2X1TS U5315 ( .A(n7368), .B(n7740), .Y(
        \router/addr_calc/fft_write_calc/counter/N187 ) );
  NAND2X1TS U5316 ( .A(n7368), .B(n7741), .Y(
        \router/addr_calc/fft_write_calc/counter/N188 ) );
  NAND2X1TS U5317 ( .A(n7368), .B(n7742), .Y(
        \router/addr_calc/fft_write_calc/counter/N189 ) );
  NAND2X1TS U5318 ( .A(n7367), .B(n7743), .Y(
        \router/addr_calc/fft_write_calc/counter/N190 ) );
  NAND2X1TS U5319 ( .A(n7367), .B(n7744), .Y(
        \router/addr_calc/fft_write_calc/counter/N191 ) );
  NAND2X1TS U5320 ( .A(n7367), .B(n7745), .Y(
        \router/addr_calc/fft_write_calc/counter/N192 ) );
  NAND2X1TS U5321 ( .A(n7366), .B(n7747), .Y(
        \router/addr_calc/fft_write_calc/counter/N194 ) );
  NAND2X1TS U5322 ( .A(fft_enable), .B(n7748), .Y(
        \router/addr_calc/fft_write_calc/counter/N195 ) );
  NAND2X1TS U5323 ( .A(n7366), .B(n7749), .Y(
        \router/addr_calc/fft_write_calc/counter/N196 ) );
  NAND2X1TS U5324 ( .A(n7366), .B(n7751), .Y(
        \router/addr_calc/fft_write_calc/counter/N198 ) );
  NAND2X1TS U5325 ( .A(n7365), .B(n7752), .Y(
        \router/addr_calc/fft_write_calc/counter/N199 ) );
  NAND2X1TS U5326 ( .A(n7365), .B(n7753), .Y(
        \router/addr_calc/fft_write_calc/counter/N200 ) );
  NAND2X1TS U5327 ( .A(n7365), .B(n7754), .Y(
        \router/addr_calc/fft_write_calc/counter/N201 ) );
  NAND2X1TS U5328 ( .A(n7365), .B(n7755), .Y(
        \router/addr_calc/fft_write_calc/counter/N202 ) );
  NAND2X1TS U5329 ( .A(n7364), .B(n7756), .Y(
        \router/addr_calc/fft_write_calc/counter/N203 ) );
  NAND2X1TS U5330 ( .A(n7364), .B(n7757), .Y(
        \router/addr_calc/fft_write_calc/counter/N204 ) );
  NAND2X1TS U5331 ( .A(n7364), .B(n7758), .Y(
        \router/addr_calc/fft_write_calc/counter/N205 ) );
  NAND2X1TS U5332 ( .A(n7364), .B(n7759), .Y(
        \router/addr_calc/fft_write_calc/counter/N206 ) );
  NAND2X1TS U5333 ( .A(n7363), .B(n7760), .Y(
        \router/addr_calc/fft_write_calc/counter/N207 ) );
  NAND2X1TS U5334 ( .A(n7363), .B(n7761), .Y(
        \router/addr_calc/fft_write_calc/counter/N208 ) );
  NAND2X1TS U5335 ( .A(n7363), .B(n7764), .Y(
        \router/addr_calc/fft_write_calc/counter/N209 ) );
  NAND2X1TS U5336 ( .A(fir_enable), .B(n7776), .Y(
        \router/addr_calc/fir_read_calc/counter/N179 ) );
  NAND2X1TS U5337 ( .A(fir_enable), .B(n7777), .Y(
        \router/addr_calc/fir_read_calc/counter/N180 ) );
  NAND2X1TS U5338 ( .A(n7352), .B(n7778), .Y(
        \router/addr_calc/fir_read_calc/counter/N181 ) );
  NAND2X1TS U5339 ( .A(n7352), .B(n7779), .Y(
        \router/addr_calc/fir_read_calc/counter/N182 ) );
  NAND2X1TS U5340 ( .A(n7352), .B(n7780), .Y(
        \router/addr_calc/fir_read_calc/counter/N183 ) );
  NAND2X1TS U5341 ( .A(n7352), .B(n7781), .Y(
        \router/addr_calc/fir_read_calc/counter/N184 ) );
  NAND2X1TS U5342 ( .A(n7351), .B(n7782), .Y(
        \router/addr_calc/fir_read_calc/counter/N185 ) );
  NAND2X1TS U5343 ( .A(n7351), .B(n7783), .Y(
        \router/addr_calc/fir_read_calc/counter/N186 ) );
  NAND2X1TS U5344 ( .A(n7351), .B(n7784), .Y(
        \router/addr_calc/fir_read_calc/counter/N187 ) );
  NAND2X1TS U5345 ( .A(n7351), .B(n7785), .Y(
        \router/addr_calc/fir_read_calc/counter/N188 ) );
  NAND2X1TS U5346 ( .A(fir_enable), .B(n7786), .Y(
        \router/addr_calc/fir_read_calc/counter/N189 ) );
  NAND2X1TS U5347 ( .A(n7919), .B(n7787), .Y(
        \router/addr_calc/fir_read_calc/counter/N190 ) );
  NAND2X1TS U5348 ( .A(n7919), .B(n7788), .Y(
        \router/addr_calc/fir_read_calc/counter/N191 ) );
  NAND2X1TS U5349 ( .A(fir_enable), .B(n7789), .Y(
        \router/addr_calc/fir_read_calc/counter/N192 ) );
  NAND2X1TS U5350 ( .A(n7350), .B(n7790), .Y(
        \router/addr_calc/fir_read_calc/counter/N193 ) );
  NAND2X1TS U5351 ( .A(n7350), .B(n7791), .Y(
        \router/addr_calc/fir_read_calc/counter/N194 ) );
  NAND2X1TS U5352 ( .A(n7350), .B(n7792), .Y(
        \router/addr_calc/fir_read_calc/counter/N195 ) );
  NAND2X1TS U5353 ( .A(n7349), .B(n7794), .Y(
        \router/addr_calc/fir_read_calc/counter/N197 ) );
  NAND2X1TS U5354 ( .A(n7349), .B(n7795), .Y(
        \router/addr_calc/fir_read_calc/counter/N198 ) );
  NAND2X1TS U5355 ( .A(n7349), .B(n7796), .Y(
        \router/addr_calc/fir_read_calc/counter/N199 ) );
  NAND2X1TS U5356 ( .A(n7349), .B(n7797), .Y(
        \router/addr_calc/fir_read_calc/counter/N200 ) );
  NAND2X1TS U5357 ( .A(n7348), .B(n7798), .Y(
        \router/addr_calc/fir_read_calc/counter/N201 ) );
  NAND2X1TS U5358 ( .A(n7348), .B(n7799), .Y(
        \router/addr_calc/fir_read_calc/counter/N202 ) );
  NAND2X1TS U5359 ( .A(n7348), .B(n7800), .Y(
        \router/addr_calc/fir_read_calc/counter/N203 ) );
  NAND2X1TS U5360 ( .A(n7348), .B(n7801), .Y(
        \router/addr_calc/fir_read_calc/counter/N204 ) );
  NAND2X1TS U5361 ( .A(n7347), .B(n7802), .Y(
        \router/addr_calc/fir_read_calc/counter/N205 ) );
  NAND2X1TS U5362 ( .A(n7347), .B(n7803), .Y(
        \router/addr_calc/fir_read_calc/counter/N206 ) );
  NAND2X1TS U5363 ( .A(n7347), .B(n7804), .Y(
        \router/addr_calc/fir_read_calc/counter/N207 ) );
  NAND2X1TS U5364 ( .A(n7347), .B(n7805), .Y(
        \router/addr_calc/fir_read_calc/counter/N208 ) );
  NAND2X1TS U5365 ( .A(n7346), .B(n7808), .Y(
        \router/addr_calc/fir_read_calc/counter/N209 ) );
  NAND2X1TS U5366 ( .A(n7346), .B(n7820), .Y(
        \router/addr_calc/fir_write_calc/counter/N179 ) );
  NAND2X1TS U5367 ( .A(n7346), .B(n7821), .Y(
        \router/addr_calc/fir_write_calc/counter/N180 ) );
  NAND2X1TS U5368 ( .A(n7345), .B(n7822), .Y(
        \router/addr_calc/fir_write_calc/counter/N181 ) );
  NAND2X1TS U5369 ( .A(n7345), .B(n7823), .Y(
        \router/addr_calc/fir_write_calc/counter/N182 ) );
  NAND2X1TS U5370 ( .A(n7345), .B(n7824), .Y(
        \router/addr_calc/fir_write_calc/counter/N183 ) );
  NAND2X1TS U5371 ( .A(n7345), .B(n7825), .Y(
        \router/addr_calc/fir_write_calc/counter/N184 ) );
  NAND2X1TS U5372 ( .A(n7344), .B(n7826), .Y(
        \router/addr_calc/fir_write_calc/counter/N185 ) );
  NAND2X1TS U5373 ( .A(n7344), .B(n7827), .Y(
        \router/addr_calc/fir_write_calc/counter/N186 ) );
  NAND2X1TS U5374 ( .A(n7344), .B(n7828), .Y(
        \router/addr_calc/fir_write_calc/counter/N187 ) );
  NAND2X1TS U5375 ( .A(n7344), .B(n7829), .Y(
        \router/addr_calc/fir_write_calc/counter/N188 ) );
  NAND2X1TS U5376 ( .A(n7343), .B(n7830), .Y(
        \router/addr_calc/fir_write_calc/counter/N189 ) );
  NAND2X1TS U5377 ( .A(n7343), .B(n7831), .Y(
        \router/addr_calc/fir_write_calc/counter/N190 ) );
  NAND2X1TS U5378 ( .A(n7343), .B(n7832), .Y(
        \router/addr_calc/fir_write_calc/counter/N191 ) );
  NAND2X1TS U5379 ( .A(n7343), .B(n7833), .Y(
        \router/addr_calc/fir_write_calc/counter/N192 ) );
  NAND2X1TS U5380 ( .A(n7346), .B(n7835), .Y(
        \router/addr_calc/fir_write_calc/counter/N194 ) );
  NAND2X1TS U5381 ( .A(n7342), .B(n7836), .Y(
        \router/addr_calc/fir_write_calc/counter/N195 ) );
  NAND2X1TS U5382 ( .A(n7342), .B(n7837), .Y(
        \router/addr_calc/fir_write_calc/counter/N196 ) );
  NAND2X1TS U5383 ( .A(n7341), .B(n7839), .Y(
        \router/addr_calc/fir_write_calc/counter/N198 ) );
  NAND2X1TS U5384 ( .A(n7341), .B(n7840), .Y(
        \router/addr_calc/fir_write_calc/counter/N199 ) );
  NAND2X1TS U5385 ( .A(n7341), .B(n7841), .Y(
        \router/addr_calc/fir_write_calc/counter/N200 ) );
  NAND2X1TS U5386 ( .A(n7341), .B(n7842), .Y(
        \router/addr_calc/fir_write_calc/counter/N201 ) );
  NAND2X1TS U5387 ( .A(n7340), .B(n7843), .Y(
        \router/addr_calc/fir_write_calc/counter/N202 ) );
  NAND2X1TS U5388 ( .A(n7340), .B(n7844), .Y(
        \router/addr_calc/fir_write_calc/counter/N203 ) );
  NAND2X1TS U5389 ( .A(n7340), .B(n7845), .Y(
        \router/addr_calc/fir_write_calc/counter/N204 ) );
  NAND2X1TS U5390 ( .A(n7340), .B(n7846), .Y(
        \router/addr_calc/fir_write_calc/counter/N205 ) );
  NAND2X1TS U5391 ( .A(n7339), .B(n7847), .Y(
        \router/addr_calc/fir_write_calc/counter/N206 ) );
  NAND2X1TS U5392 ( .A(n7339), .B(n7848), .Y(
        \router/addr_calc/fir_write_calc/counter/N207 ) );
  NAND2X1TS U5393 ( .A(n7339), .B(n7849), .Y(
        \router/addr_calc/fir_write_calc/counter/N208 ) );
  NAND2X1TS U5394 ( .A(n7339), .B(n7852), .Y(
        \router/addr_calc/fir_write_calc/counter/N209 ) );
  NAND2BX1TS U5395 ( .AN(\router/addr_calc/iir_read_calc/count[0] ), .B(n7322), 
        .Y(\router/addr_calc/iir_read_calc/counter/N178 ) );
  NAND2BX1TS U5396 ( .AN(\router/addr_calc/iir_read_calc/count[1] ), .B(n7329), 
        .Y(\router/addr_calc/iir_read_calc/counter/N179 ) );
  NAND2BX1TS U5397 ( .AN(\router/addr_calc/iir_read_calc/count[2] ), .B(n7329), 
        .Y(\router/addr_calc/iir_read_calc/counter/N180 ) );
  NAND2BX1TS U5398 ( .AN(\router/addr_calc/iir_read_calc/count[3] ), .B(n7329), 
        .Y(\router/addr_calc/iir_read_calc/counter/N181 ) );
  NAND2BX1TS U5399 ( .AN(\router/addr_calc/iir_read_calc/count[4] ), .B(n7329), 
        .Y(\router/addr_calc/iir_read_calc/counter/N182 ) );
  NAND2BX1TS U5400 ( .AN(\router/addr_calc/iir_read_calc/count[5] ), .B(n7328), 
        .Y(\router/addr_calc/iir_read_calc/counter/N183 ) );
  NAND2BX1TS U5401 ( .AN(\router/addr_calc/iir_read_calc/count[6] ), .B(n7328), 
        .Y(\router/addr_calc/iir_read_calc/counter/N184 ) );
  NAND2BX1TS U5402 ( .AN(\router/addr_calc/iir_read_calc/count[7] ), .B(n7328), 
        .Y(\router/addr_calc/iir_read_calc/counter/N185 ) );
  NAND2BX1TS U5403 ( .AN(\router/addr_calc/iir_read_calc/count[8] ), .B(n7328), 
        .Y(\router/addr_calc/iir_read_calc/counter/N186 ) );
  NAND2BX1TS U5404 ( .AN(\router/addr_calc/iir_read_calc/count[9] ), .B(n7327), 
        .Y(\router/addr_calc/iir_read_calc/counter/N187 ) );
  NAND2BX1TS U5405 ( .AN(\router/addr_calc/iir_read_calc/count[10] ), .B(n7327), .Y(\router/addr_calc/iir_read_calc/counter/N188 ) );
  NAND2BX1TS U5406 ( .AN(\router/addr_calc/iir_read_calc/count[11] ), .B(n7327), .Y(\router/addr_calc/iir_read_calc/counter/N189 ) );
  NAND2BX1TS U5407 ( .AN(\router/addr_calc/iir_read_calc/count[12] ), .B(n7327), .Y(\router/addr_calc/iir_read_calc/counter/N190 ) );
  NAND2BX1TS U5408 ( .AN(\router/addr_calc/iir_read_calc/count[13] ), .B(n7326), .Y(\router/addr_calc/iir_read_calc/counter/N191 ) );
  NAND2BX1TS U5409 ( .AN(\router/addr_calc/iir_read_calc/count[14] ), .B(n7326), .Y(\router/addr_calc/iir_read_calc/counter/N192 ) );
  NAND2BX1TS U5410 ( .AN(\router/addr_calc/iir_read_calc/count[15] ), .B(n7322), .Y(\router/addr_calc/iir_read_calc/counter/N193 ) );
  NAND2BX1TS U5411 ( .AN(\router/addr_calc/iir_read_calc/count[16] ), .B(n7326), .Y(\router/addr_calc/iir_read_calc/counter/N194 ) );
  NAND2BX1TS U5412 ( .AN(\router/addr_calc/iir_read_calc/count[17] ), .B(n7326), .Y(\router/addr_calc/iir_read_calc/counter/N195 ) );
  NAND2BX1TS U5413 ( .AN(\router/addr_calc/iir_read_calc/count[18] ), .B(n7325), .Y(\router/addr_calc/iir_read_calc/counter/N196 ) );
  NAND2BX1TS U5414 ( .AN(\router/addr_calc/iir_read_calc/count[19] ), .B(n7325), .Y(\router/addr_calc/iir_read_calc/counter/N197 ) );
  NAND2BX1TS U5415 ( .AN(\router/addr_calc/iir_read_calc/count[20] ), .B(n7325), .Y(\router/addr_calc/iir_read_calc/counter/N198 ) );
  NAND2BX1TS U5416 ( .AN(\router/addr_calc/iir_read_calc/count[21] ), .B(n7325), .Y(\router/addr_calc/iir_read_calc/counter/N199 ) );
  NAND2BX1TS U5417 ( .AN(\router/addr_calc/iir_read_calc/count[22] ), .B(n7324), .Y(\router/addr_calc/iir_read_calc/counter/N200 ) );
  NAND2BX1TS U5418 ( .AN(\router/addr_calc/iir_read_calc/count[23] ), .B(n7324), .Y(\router/addr_calc/iir_read_calc/counter/N201 ) );
  NAND2BX1TS U5419 ( .AN(\router/addr_calc/iir_read_calc/count[24] ), .B(n7324), .Y(\router/addr_calc/iir_read_calc/counter/N202 ) );
  NAND2BX1TS U5420 ( .AN(\router/addr_calc/iir_read_calc/count[25] ), .B(n7324), .Y(\router/addr_calc/iir_read_calc/counter/N203 ) );
  NAND2BX1TS U5421 ( .AN(\router/addr_calc/iir_read_calc/count[26] ), .B(n7323), .Y(\router/addr_calc/iir_read_calc/counter/N204 ) );
  NAND2BX1TS U5422 ( .AN(\router/addr_calc/iir_read_calc/count[27] ), .B(n7323), .Y(\router/addr_calc/iir_read_calc/counter/N205 ) );
  NAND2BX1TS U5423 ( .AN(\router/addr_calc/iir_read_calc/count[28] ), .B(n7323), .Y(\router/addr_calc/iir_read_calc/counter/N206 ) );
  NAND2BX1TS U5424 ( .AN(\router/addr_calc/iir_read_calc/count[29] ), .B(n7323), .Y(\router/addr_calc/iir_read_calc/counter/N207 ) );
  NAND2BX1TS U5425 ( .AN(\router/addr_calc/iir_read_calc/count[30] ), .B(n7322), .Y(\router/addr_calc/iir_read_calc/counter/N208 ) );
  NAND2BX1TS U5426 ( .AN(\router/addr_calc/iir_read_calc/count[31] ), .B(n7322), .Y(\router/addr_calc/iir_read_calc/counter/N209 ) );
  NAND2X1TS U5427 ( .A(n7321), .B(n7864), .Y(
        \router/addr_calc/iir_write_calc/counter/N179 ) );
  NAND2X1TS U5428 ( .A(n7321), .B(n7865), .Y(
        \router/addr_calc/iir_write_calc/counter/N180 ) );
  NAND2X1TS U5429 ( .A(n7321), .B(n7866), .Y(
        \router/addr_calc/iir_write_calc/counter/N181 ) );
  NAND2X1TS U5430 ( .A(n7321), .B(n7867), .Y(
        \router/addr_calc/iir_write_calc/counter/N182 ) );
  NAND2X1TS U5431 ( .A(n7320), .B(n7868), .Y(
        \router/addr_calc/iir_write_calc/counter/N183 ) );
  NAND2X1TS U5432 ( .A(n7320), .B(n7869), .Y(
        \router/addr_calc/iir_write_calc/counter/N184 ) );
  NAND2X1TS U5433 ( .A(n7320), .B(n7870), .Y(
        \router/addr_calc/iir_write_calc/counter/N185 ) );
  NAND2X1TS U5434 ( .A(n7320), .B(n7871), .Y(
        \router/addr_calc/iir_write_calc/counter/N186 ) );
  NAND2X1TS U5435 ( .A(n7319), .B(n7873), .Y(
        \router/addr_calc/iir_write_calc/counter/N188 ) );
  NAND2X1TS U5436 ( .A(n7319), .B(n7874), .Y(
        \router/addr_calc/iir_write_calc/counter/N189 ) );
  NAND2X1TS U5437 ( .A(n7319), .B(n7875), .Y(
        \router/addr_calc/iir_write_calc/counter/N190 ) );
  NAND2X1TS U5438 ( .A(n7318), .B(n7876), .Y(
        \router/addr_calc/iir_write_calc/counter/N191 ) );
  NAND2X1TS U5439 ( .A(n7318), .B(n7878), .Y(
        \router/addr_calc/iir_write_calc/counter/N193 ) );
  NAND2X1TS U5440 ( .A(n7318), .B(n7879), .Y(
        \router/addr_calc/iir_write_calc/counter/N194 ) );
  NAND2X1TS U5441 ( .A(n7317), .B(n7880), .Y(
        \router/addr_calc/iir_write_calc/counter/N195 ) );
  NAND2X1TS U5442 ( .A(n7317), .B(n7881), .Y(
        \router/addr_calc/iir_write_calc/counter/N196 ) );
  NAND2X1TS U5443 ( .A(n7317), .B(n7882), .Y(
        \router/addr_calc/iir_write_calc/counter/N197 ) );
  NAND2X1TS U5444 ( .A(n7316), .B(n7883), .Y(
        \router/addr_calc/iir_write_calc/counter/N198 ) );
  NAND2X1TS U5445 ( .A(n7316), .B(n7884), .Y(
        \router/addr_calc/iir_write_calc/counter/N199 ) );
  NAND2X1TS U5446 ( .A(n7316), .B(n7885), .Y(
        \router/addr_calc/iir_write_calc/counter/N200 ) );
  NAND2X1TS U5447 ( .A(n7316), .B(n7886), .Y(
        \router/addr_calc/iir_write_calc/counter/N201 ) );
  NAND2X1TS U5448 ( .A(n7315), .B(n7887), .Y(
        \router/addr_calc/iir_write_calc/counter/N202 ) );
  NAND2X1TS U5449 ( .A(n7315), .B(n7888), .Y(
        \router/addr_calc/iir_write_calc/counter/N203 ) );
  NAND2X1TS U5450 ( .A(n7315), .B(n7889), .Y(
        \router/addr_calc/iir_write_calc/counter/N204 ) );
  NAND2X1TS U5451 ( .A(n7315), .B(n7890), .Y(
        \router/addr_calc/iir_write_calc/counter/N205 ) );
  NAND2X1TS U5452 ( .A(n7314), .B(n7891), .Y(
        \router/addr_calc/iir_write_calc/counter/N206 ) );
  NAND2X1TS U5453 ( .A(n7314), .B(n7892), .Y(
        \router/addr_calc/iir_write_calc/counter/N207 ) );
  NAND2X1TS U5454 ( .A(n7314), .B(n7893), .Y(
        \router/addr_calc/iir_write_calc/counter/N208 ) );
  AO21X1TS U5455 ( .A0(n6404), .A1(n7914), .B0(n7913), .Y(n3811) );
endmodule

