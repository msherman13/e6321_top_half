/******************************************************************************
**
** Module:      dc_router_top
** Description: Top level of data & control router.
**
** Author:      Miles Sherman
** Contact:     ms4543@columbia.edu
** Affiliation: Columbia University
**
** Last Update: 03/18/2013
**
******************************************************************************/

//Module declaration.
module dc_router_top (clk, reset, instruction, offset, filesize, acc_done, fft_enable, fir_enable, data_bus, fft_data_in, fir_data_in, fft_data_out, fir_data_out, to_fft_empty, to_fft_full, from_fft_empty, from_fft_full, to_fir_empty, to_fir_full, from_fir_empty, from_fir_full, fft_put_req, fft_get_req, fir_put_req, fir_get_req, ram_read_enable, ram_write_enable, addr);

//Terminal declarations.
input clk, reset, to_fft_full, to_fft_empty, from_fft_full, from_fft_empty, to_fir_full, to_fir_empty, from_fir_full, from_fir_empty;
input [31:0] instruction, offset, filesize;
input [31:0] fft_data_in, fir_data_in;

output acc_done, fft_enable, fir_enable, fft_put_req, fft_get_req, fir_put_req, fir_get_req, ram_read_enable, ram_write_enable;
output [31:0] addr;
output [31:0] fft_data_out, fir_data_out;

inout [31:0] data_bus;

//Wire & reg declarations.
wire fft_read_pause, fft_write_pause, fir_read_pause, fir_write_pause, data_to_fft, data_from_fft, data_to_fir, data_from_fir, fft_read_done, fft_write_done, fir_read_done, fir_write_done;

reg ram_read_enable, ram_write_enable, fft_put_req, fft_get_req, fir_put_req, fir_get_req;

//Address pause signal generation.
assign fft_read_pause = !data_to_fft;
assign fft_write_pause = !data_from_fft;

assign fir_read_pause = !data_to_fir;
assign fir_write_pause = !data_from_fir;

//Sub-module instantiation.
pla_top pla_top (.instruction(instruction), .fft_read_done(fft_read_done), .fft_write_done(fft_write_done), .fir_read_done(fir_read_done), .fir_write_done(fir_write_done), .fft_enable(fft_enable), .fir_enable(fir_enable), .acc_done(acc_done), .clk(clk), .reset(reset));

addr_calc_top addr_calc (.offset(offset), .filesize(filesize), .fft_enable(fft_enable), .fir_enable(fir_enable), .fft_read_pause(fft_read_pause), .fir_read_pause(fir_read_pause), .fft_write_pause(fft_write_pause), .fir_write_pause(fir_write_pause), .clk(clk), .addr(addr), .fft_read_done(fft_read_done), .fft_write_done(fft_write_done), .fir_read_done(fir_read_done), .fir_write_done(fir_write_done));

data_bus_controller data_cntl (.data_bus(data_bus), .fft_data_in(fft_data_in), .fir_data_in(fir_data_in), .fft_data_out(fft_data_out), .fir_data_out(fir_data_out), .to_fft_empty(to_fft_empty), .to_fft_full(to_fft_full), .from_fft_empty(from_fft_empty), .from_fft_full(from_fft_full), .to_fir_empty(to_fir_empty), .to_fir_full(to_fir_full), .from_fir_empty(from_fir_empty), .from_fir_full(from_fir_full), .data_to_fft(data_to_fft), .data_from_fft(data_from_fft), .data_to_fir(data_to_fir), .data_from_fir(data_from_fir), .fft_enable(fft_enable), .fir_enable(fir_enable), .fft_put_req(fft_put_req_reg), .fft_get_req(fft_get_req_reg), .fir_put_req(fir_put_req_reg), .fir_get_req(fir_get_req_reg), .ram_read_enable(ram_read_enable_reg), .ram_write_enable(ram_write_enable_reg), .clk(clk), .reset(reset));

always @ (*)
begin
	if (fft_enable & fft_read_done)
	begin
		ram_read_enable = 0;
		ram_write_enable = ram_write_enable_reg;
		fft_put_req = 0;
		fft_get_req = fft_get_req_reg;
		fir_put_req = 0;
		fir_get_req = 0;
	end
	else if (fft_enable & fft_write_done)
	begin
		ram_read_enable = 0;
		ram_write_enable = 0;
		fft_put_req = 0;
		fft_get_req = 0;
		fir_put_req = 0;
		fir_get_req = 0;
	end
	else if (fft_enable & !fft_read_done & !fft_write_done)
	begin
		ram_read_enable = ram_read_enable_reg;
		ram_write_enable = ram_write_enable_reg;
		fft_put_req = fft_put_req_reg;
		fft_get_req = fft_get_req_reg;
		fir_put_req = 0;
		fir_get_req = 0;
	end

	else if (fir_enable & fir_read_done)
	begin
		ram_read_enable = 0;
		ram_write_enable = ram_write_enable_reg;
		fir_put_req = 0;
		fir_get_req = fir_get_req_reg;
		fft_put_req = 0;
		fft_get_req = 0;
	end
	else if (fir_enable & fir_write_done)
	begin
		ram_read_enable = 0;
		ram_write_enable = 0;
		fir_put_req = 0;
		fir_get_req = 0;
		fft_put_req = 0;
		fft_get_req = 0;
	end
	else if (fir_enable & !fir_read_done & !fft_write_done)
	begin
		ram_read_enable = ram_read_enable_reg;
		ram_write_enable = ram_write_enable_reg;
		fir_put_req = fir_put_req_reg;
		fir_get_req = fir_get_req_reg;
		fft_put_req = 0;
		fft_get_req = 0;
	end
	else
	begin
		ram_read_enable = 0;
		ram_write_enable = 0;
		fft_put_req = 0;
		fft_get_req = 0;
		fir_put_req = 0;
		fir_get_req = 0;
	end
end

endmodule
