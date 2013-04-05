/******************************************************************************
**
** Module:      pla_top_tb
** Description: Testbench for pla_top module.
**
** Author:      Miles Sherman
** Contact:	ms4543@columbia.edu
** Affiliation: Columbia University
**
** Last Update: 03/18/2013
**
******************************************************************************/

`define half_clk_period #25000
`define SD #1000

module pla_top_tb();

reg clk, reset, fft_read_done, fft_write_done, fir_read_done, fir_write_done, iir_read_done, iir_write_done;

reg [31:0] instruction;

wire fft_enable, fir_enable, iir_enable, acc_done;

pla_top pla_top (.instruction(instruction), .fft_read_done(fft_read_done), .fft_write_done(fft_write_done), .fir_read_done(fir_read_done), .fir_write_done(fir_write_done), .iir_read_done(iir_read_done), .iir_write_done(iir_write_done), .fft_enable(fft_enable), .fir_enable(fir_enable), .iir_enable(iir_enable), .acc_done(acc_done), .clk(clk), .reset(reset));

always
begin
	`half_clk_period;
	clk = ~clk;
end

initial begin
	//Initialize inputs.
	clk = 0;
	reset = 0;
	fft_read_done = 0;
	fft_write_done = 0;
	fir_read_done = 0;
	fir_write_done = 0;
	iir_read_done = 0;
	iir_write_done = 0;
	instruction = 0;
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);

	//Begin FFT Testing.
	instruction = 2'b01;
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	fft_read_done = 1;
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	fft_write_done = 1;
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);

	//Begin FIR Testing.
	instruction = 2'b10;
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	fir_read_done = 1;
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	fir_write_done = 1;
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);

	//Begin IIR Testing.
	instruction = 2'b11;
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	iir_read_done = 1;
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	iir_write_done = 1;
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);
	@(posedge clk);

	$finish;
end 
endmodule
