`timescale 1ns/1ns
`define half_clk_period #0.5
//`define SD #2000

module top_level_tb();

//Wire & reg desclarations.
reg clk, reset;
reg to_fft_full, to_fft_empty, from_fft_full, from_fft_empty, to_fir_full, to_fir_empty, from_fir_full, from_fir_empty, to_iir_full, to_iir_empty, from_iir_full, from_iir_empty;
reg [31:0] fft_data_in, fir_data_in, iir_data_in;

wire fft_enable, fir_enable, iir_enable, fft_put_req, fft_get_req, fir_put_req, fir_get_req, iir_put_req, iir_get_req, ram_read_enable, ram_write_enable;
wire [31:0] addr;
wire [31:0] fft_data_out, fir_data_out, iir_data_out;
wire [31:0] data_bus;
reg [31:0] data_bus_reg, i, j;

//MUT instantiation.
top_level dut (.clk(clk), .reset(reset), .fft_enable(fft_enable), .fir_enable(fir_enable), .iir_enable(iir_enable), .data_bus(data_bus), .fft_data_in(fft_data_in), .fir_data_in(fir_data_in), .iir_data_in(iir_data_in), .fft_data_out(fft_data_out), .fir_data_out(fir_data_out), .iir_data_out(iir_data_out), .to_fft_empty(to_fft_empty), .to_fft_full(to_fft_full), .from_fft_empty(from_fft_empty), .from_fft_full(from_fft_full), .to_fir_empty(to_fir_empty), .to_fir_full(to_fir_full), .from_fir_empty(from_fir_empty), .from_fir_full(from_fir_full), .to_iir_empty(to_iir_empty), .to_iir_full(to_iir_full), .from_iir_empty(from_iir_empty), .from_iir_full(from_iir_full), .fft_put_req(fft_put_req), .fft_get_req(fft_get_req), .fir_put_req(fir_put_req), .fir_get_req(fir_get_req), .iir_put_req(iir_put_req), .iir_get_req(iir_get_req), .ram_read_enable(ram_read_enable), .ram_write_enable(ram_write_enable), .addr(addr));

ram memory (
	.clk		(clk),
	.address (addr),
	.data		(data_bus),
	.cs		(ram_read_enable || ram_write_enable),
	.we		(ram_write_enable),
	.oe		(ram_read_enable));

//Data-bus bi-directional handling.


//Clock generation.
always
begin
	`half_clk_period;
	clk = ~clk;
end

//Begin test vector input.
initial forever
begin
	//Initialize inputs.
	clk = 0;
	reset = 1;
  	{to_fft_empty, to_fft_full, from_fft_empty, from_fft_full} <= 4'b1010;
  	{to_fir_empty, to_fir_full, from_fir_empty, from_fir_full} <= 4'b1010;
  	{to_iir_empty, to_iir_full, from_iir_empty, from_iir_full} <= 4'b1010;
  	fft_data_in = 32'b1;
  	fir_data_in = 32'b1;
 	iir_data_in = 32'b1;
	i = 0;
	j = 0;
	@(posedge clk);
	@(posedge clk);
	reset = 0;
	@(posedge clk);
	@(posedge clk);
	
	//Begin FFT Testing.
	repeat (50)
	begin
		#2 if (fft_enable == 1)
		begin
			for (i = 0; i < 2; i = i + 1) // to empty, from empty, 1 cycle - data to fft.
			begin
				#2 {to_fft_empty, to_fft_full, from_fft_empty, from_fft_full} <= 4'b1010;
				
			end
			for (i = 0; i < 6; i = i + 1) // to half full, from empty, 3 cycles - data to fft
			begin
				#2 {to_fft_empty, to_fft_full, from_fft_empty, from_fft_full} <= 4'b0010;
				
			end
			for (i = 0; i < 2; i = i + 1) // to full, from empty, 1 cycles - data pauses
			begin
				#2 {to_fft_empty, to_fft_full, from_fft_empty, from_fft_full} <= 4'b0110;
				
			end
			for (i = 0; i < 4; i = i + 1) // to full, from half full, 3 cycles - data from fft
			begin
				#2 {to_fft_empty, to_fft_full, from_fft_empty, from_fft_full} <= 4'b0100;

			end
			for (i = 0; i < 2; i = i + 1) // to full, from full, 1 cycle - data from fft
			begin
				#2 {to_fft_empty, to_fft_full, from_fft_empty, from_fft_full} <= 4'b0101;

			end
			for (i = 0; i < 4; i = i + 1) // to full, from half, 3 cycle - data from fft
			begin
				#2 {to_fft_empty, to_fft_full, from_fft_empty, from_fft_full} <= 4'b0100;

			end
			for (i = 0; i < 2; i = i + 1) // to full, from empty, 1 cycle - data pauses
			begin
				#2 {to_fft_empty, to_fft_full, from_fft_empty, from_fft_full} <= 4'b0110;
				
			end
			for (i = 0; i < 6; i = i + 1) // to half full, from empty, 3 cycle - data to fft
			begin
				#2 {to_fft_empty, to_fft_full, from_fft_empty, from_fft_full} <= 4'b0010;
			end
		end
		else
		begin
			#2 {to_fft_empty, to_fft_full, from_fft_empty, from_fft_full} <= 4'b1010;
		end
	end

	$finish;
end 

endmodule
