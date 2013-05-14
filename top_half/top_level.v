module top_level
(
	input 
		clk, 
		reset,
	input [31:0] 
		acc_fft_data_out,
		acc_fft_data_in,
		acc_fir_data_out,
		acc_fir_data_in,
	output 
		fft_enable, 
		fir_enable, 
		to_fft_empty, 
		from_fft_full,
		to_fir_empty, 
		from_fir_full,
		acc_fft_get,
		acc_fft_put,
		acc_fir_get,
		acc_fir_put,  
		ram_read_enable, 
		ram_write_enable,
	output [31:0]
		addr,
	inout [31:0] 
		data_bus 
);
	wire 
		acc_done, 
		acc_bypass;
	wire [31:0] 
		instruction, 
		offset, 
		filesize
		;

	mipstop mips(
		.clk(clk), 
		.reset(reset),
		.accdone(acc_done),
		.accbypassA(acc_bypass),
		.fullinstructionA(instruction),
		.startaddrA(offset),
		.datasizeA(filesize));
		
   FIFO_module fifo_to_fft (
        .reset          (reset),
        .clk_put        (clk),
        .clk_get        (clk),
        .req_put        (fft_put_req),
        .req_get        (acc_fft_get),
        .data_put       (fft_data_out),
        .data_get       (acc_fft_data_out),
        .full_out       (to_fft_full),
        .empty_out      (to_fft_empty));
        
   FIFO_module fifo_from_fft (
        .reset          (reset),
        .clk_put        (clk),
        .clk_get        (clk),
        .req_put        (acc_fft_put),
        .req_get        (fft_get_req),
        .data_put       (acc_fft_data_in),
        .data_get       (fft_data_in),
        .full_out       (from_fft_full),
        .empty_out      (from_fft_empty));
        
   FIFO_module fifo_to_fir (
        .reset          (reset),
        .clk_put        (clk),
        .clk_get        (clk),
        .req_put        (fir_put_req),
        .req_get        (acc_fir_get),
        .data_put       (fir_data_out),
        .data_get       (acc_fir_data_out),
        .full_out       (to_fir_full),
        .empty_out      (to_fir_empty));
        
   FIFO_module fifo_from_fir (
        .reset          (reset),
        .clk_put        (clk),
        .clk_get        (clk),
        .req_put        (acc_fir_put),
        .req_get        (fir_get_req),
        .data_put       (acc_fir_data_in),
        .data_get       (fir_data_in),
        .full_out       (from_fir_full),
        .empty_out      (from_fir_empty));

	dc_router_top router(
		.chipselect(1'b1),
		.acc_bypass(acc_bypass),
		.clk(clk),
		.reset(reset),
		.instruction(instruction),
		.offset(offset),
		.filesize(filesize),
		.acc_done(acc_done),
		.fft_enable(fft_enable),
		.fir_enable(fir_enable),
		.iir_enable(iir_enable),
		.data_bus(data_bus),
		.fft_data_in(fft_data_in),
		.fir_data_in(fir_data_in),
		.iir_data_in(iir_data_in),
		.fft_data_out(fft_data_out),
		.fir_data_out(fir_data_out),
		.iir_data_out(iir_data_out),
		.to_fft_empty(to_fft_empty),
		.to_fft_full(to_fft_full),
		.from_fft_empty(from_fft_empty),
		.from_fft_full(from_fft_full),
		.to_fir_empty(to_fir_empty),
		.to_fir_full(to_fir_full),
		.from_fir_empty(from_fir_empty),
		.from_fir_full(from_fir_full),
		.to_iir_empty(to_iir_empty),
		.to_iir_full(to_iir_full),
		.from_iir_empty(from_iir_empty),
		.from_iir_full(from_iir_full),
		.fft_put_req(fft_put_req),
		.fft_get_req(fft_get_req),
		.fir_put_req(fir_put_req),
		.fir_get_req(fir_get_req),
		.iir_put_req(iir_put_req),
		.iir_get_req(iir_get_req),
		.ram_read_enable(ram_read_enable),
		.ram_write_enable(ram_write_enable),
		.addr(addr));


endmodule
