module top_level
(
	input clk, reset,
	input to_fft_full, to_fft_empty, from_fft_full, from_fft_empty, to_fir_full, to_fir_empty, from_fir_full, from_fir_empty, to_iir_full, to_iir_empty, from_iir_full, from_iir_empty,
	input [31:0] fft_data_in, fir_data_in, iir_data_in,
	output fft_enable, fir_enable, iir_enable, fft_put_req, fft_get_req, fir_put_req, fir_get_req, iir_put_req, iir_get_req, ram_read_enable, ram_write_enable,
	output [31:0] addr,
	output [31:0] fft_data_out, fir_data_out, iir_data_out,
	inout [31:0] data_bus 
);
	wire acc_done, acc_bypass;
	wire [31:0] instruction, offset, filesize;

	mipstop mips(
		.clk(clk), 
		.reset(reset),
		.accdone(acc_done),
		.accbypassA(acc_bypass),
		.fullinstructionA(instruction),
		.startaddrA(offset),
		.datasizeA(filesize));

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
