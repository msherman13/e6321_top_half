`timescale 1ns/1ns
`define half_clk_period #2
`define half_fft_clk_period #2
//`define SD #2000

module top_level_tb();

//Wire & reg desclarations.
reg gp_clk, fft_clk, reset;
wire to_fft_full, to_fft_empty;
reg from_fft_full, from_fft_empty, to_fir_full, to_fir_empty, from_fir_full, from_fir_empty, to_iir_full, to_iir_empty, from_iir_full, from_iir_empty;
reg [31:0] fft_data_in, fir_data_in, iir_data_in;

wire fft_enable, fir_enable, iir_enable, fft_put_req, fft_get_req, fir_put_req, fir_get_req, iir_put_req, iir_get_req, ram_read_enable, ram_write_enable;
wire [31:0] addr;
wire [31:0] fft_data_out, fir_data_out, iir_data_out;
wire [31:0] data_bus;
reg [31:0] i;

reg acc_fft_get;

//MUT instantiation.
top_level top_half (.clk(gp_clk), .fft_clk(fft_clk), .reset(reset), .fft_enable(fft_enable), .fir_enable(fir_enable), .iir_enable(iir_enable), .data_bus(data_bus), .fft_data_in(fft_data_in), .fir_data_in(fir_data_in), .iir_data_in(iir_data_in), .fft_data_out(fft_data_out), .fir_data_out(fir_data_out), .iir_data_out(iir_data_out), .to_fft_empty(to_fft_empty), .to_fft_full(to_fft_full), .from_fft_empty(from_fft_empty), .from_fft_full(from_fft_full), .to_fir_empty(to_fir_empty), .to_fir_full(to_fir_full), .from_fir_empty(from_fir_empty), .from_fir_full(from_fir_full), .to_iir_empty(to_iir_empty), .to_iir_full(to_iir_full), .from_iir_empty(from_iir_empty), .from_iir_full(from_iir_full), .fft_put_req(fft_put_req), .fft_get_req(fft_get_req), .fir_put_req(fir_put_req), .fir_get_req(fir_get_req), .iir_put_req(iir_put_req), .iir_get_req(iir_get_req), .ram_read_enable(ram_read_enable), .ram_write_enable(ram_write_enable), .addr(addr));

ram memory (
	.clk		(gp_clk),
	.address (addr),
	.data		(data_bus),
	.cs		(ram_read_enable || ram_write_enable),
	.we		(ram_write_enable),
	.oe		(ram_read_enable));

//Clock generation.
always
begin
	`half_clk_period;
	gp_clk = ~gp_clk;
end

always
begin
	`half_fft_clk_period;
	fft_clk = ~fft_clk;
end

//Begin test vector input.
initial forever
begin
	//Initialize inputs.
	gp_clk = 0;
	fft_clk = 0;
	reset = 1;
	{from_fft_empty, from_fft_full} <= 2'b10;
   {to_fir_empty, to_fir_full, from_fir_empty, from_fir_full} <= 4'b1010;
   {to_iir_empty, to_iir_full, from_iir_empty, from_iir_full} <= 4'b1010;
	fft_data_in = 32'bZ;
	fir_data_in = 32'bZ;
	iir_data_in = 32'bZ;
	@(posedge gp_clk);
	@(posedge gp_clk);
	reset = 0;
	@(posedge gp_clk);
	@(posedge gp_clk);
	for (i = 0; i < 20000; i = i + 1) begin
		@(posedge gp_clk);
	end
	$finish;
end

endmodule
