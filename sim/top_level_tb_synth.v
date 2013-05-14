`timescale 1ns/1ns
`define half_clk_period #50
`define half_fft_clk_period #50
//`define SD #2000

module top_level_tb();

//Wire & reg desclarations.
reg gp_clk, fft_clk, reset;
wire to_fft_full, to_fft_empty;
wire from_fft_full, from_fft_empty, to_fir_full, to_fir_empty, from_fir_full, from_fir_empty, to_iir_full, to_iir_empty, from_iir_full, from_iir_empty;
reg [31:0] fft_data_in, fir_data_in, iir_data_in;

wire fft_enable, fir_enable, iir_enable, fft_put_req, fft_get_req, fir_put_req, fir_get_req, iir_put_req, iir_get_req, ram_read_enable, ram_write_enable;
wire [31:0] addr, acc_fft_data_in, acc_fft_data_out, acc_fir_data_in, acc_fir_data_out;
wire [31:0] fft_data_out, fir_data_out, iir_data_out;
wire [31:0] data_bus;
reg [31:0] i, data_bus_reg;

wire acc_fft_get;
reg acc_fft_get_reg, acc_fft_put_reg, acc_fft_data_in_reg, ram_read;

reg [31:0] mem_in [0:44099];

//MUT instantiation.
top_level top_half (.clk(gp_clk), .reset(reset), .acc_fft_get(acc_fft_get), .acc_fft_put(acc_fft_put), .acc_fir_get(acc_fir_get), .acc_fir_put(acc_fir_put), .acc_fft_data_out(acc_fft_data_out), .acc_fft_data_in(acc_fft_data_in), .acc_fir_data_out(acc_fir_data_out), .acc_fir_data_in(acc_fir_data_in), .fft_enable(fft_enable), .fir_enable(fir_enable), .data_bus(data_bus), .to_fft_empty(to_fft_empty), .from_fft_full(from_fft_full), .to_fir_empty(to_fir_empty), .from_fir_full(from_fir_full), .ram_read_enable(ram_read_enable), .ram_write_enable(ram_write_enable), .addr(addr));
	
	assign acc_fft_get = acc_fft_get_reg;
	assign acc_fft_put = acc_fft_put_reg;
	assign acc_fft_data_in = acc_fft_data_in_reg;
	assign data_bus = data_bus_reg;

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
initial
begin
		$readmemb("data_in.txt", mem_in);
//SDF Annotation
$sdf_annotate ("../synth/top_level.temp.sdf", top_level_tb.top_half);
		
	//Initialize inputs.
	gp_clk = 0;
	fft_clk = 0;
	reset = 1;
	acc_fft_get_reg <= 0;
	acc_fft_put_reg <= 0;
	acc_fft_data_in_reg <= 1;
	@(posedge gp_clk);
	@(posedge gp_clk);
	reset = 0;
	@(posedge gp_clk);
	@(posedge gp_clk);
	acc_fft_get_reg <= 1;
	@(posedge gp_clk);
	acc_fft_put_reg <= 1;
	for (i = 0; i < 10000; i = i + 1) begin
		acc_fft_data_in_reg <= acc_fft_data_in_reg + 1;
		if (ram_read_enable) begin
			data_bus_reg = mem_in[addr];
		end
		@(posedge gp_clk);
	end
	for (i = 0; i < 100; i = i + 1) begin
		@(posedge gp_clk);
	end
	$finish;
end

endmodule
