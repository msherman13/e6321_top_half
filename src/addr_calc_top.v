/******************************************************************************
**
** Module:      addr_calc_top
** Description: Top level routing & buffers for address calculation line.
**		Read means data from RAM -> Accelerator.
**		Write means data from Accelerator -> RAM.
**
** Author:      Miles Sherman
** Contact:     ms4543@columbia.edu
** Affiliation: Columbia University
**
** Last Update: 03/08/2013
**
******************************************************************************/

module addr_calc_top (offset, filesize, fft_enable, fir_enable, iir_enable, fft_read_pause, fir_read_pause, iir_read_pause, fft_write_pause, fir_write_pause, iir_write_pause, clk, addr, fft_read_done, fft_write_done, fir_read_done, fir_write_done, iir_read_done, iir_write_done);

    input [31:0] offset, filesize;
	input fir_enable, iir_enable, fft_enable, fft_read_pause, fir_read_pause, iir_read_pause, fft_write_pause, fir_write_pause, iir_write_pause, clk;
	output [31:0] addr;
	output fft_read_done, fft_write_done, fir_read_done, fir_write_done, iir_read_done, iir_write_done;
	
	wire [31:0] fft_read_addr, fft_write_addr, fir_read_addr, fir_write_addr, iir_read_addr, iir_write_addr;
	wire [31:0] filesize_plus;
	reg to_fft_go, from_fft_go, to_fir_go, from_fir_go, to_iir_go, from_iir_go;

assign filesize_plus = filesize + 15;

//FFT address calculator
filt_address_calc fft_read_calc (.offset(offset), .filesize(filesize), .enable(fft_enable), .pause(fft_read_pause), .clk(clk), .addr(fft_read_addr), .done(fft_read_done));
filt_address_calc fft_write_calc (.offset(offset), .filesize(filesize), .enable(fft_enable), .pause(fft_write_pause), .clk(clk), .addr(fft_write_addr), .done(fft_write_done));

//FIR address calculator
filt_address_calc fir_read_calc (.offset(offset), .filesize(filesize), .enable(fir_enable), .pause(fir_read_pause), .clk(clk), .addr(fir_read_addr), .done(fir_read_done));
filt_address_calc fir_write_calc (.offset(offset), .filesize(filesize), .enable(fir_enable), .pause(fir_write_pause), .clk(clk), .addr(fir_write_addr), .done(fir_write_done));

//IIR address calculator
filt_address_calc iir_read_calc (.offset(offset), .filesize(filesize_plus), .enable(iir_enable), .pause(iir_read_pause), .clk(clk), .addr(iir_read_addr), .done(iir_read_done));
filt_address_calc iir_write_calc (.offset(offset), .filesize(filesize_plus), .enable(iir_enable), .pause(iir_write_pause), .clk(clk), .addr(iir_write_addr), .done(iir_write_done));

always @(posedge clk)
begin
	// FFT tri-state enable logic.
	if (fft_enable)
	begin
		case ({fft_read_pause, fft_write_pause})
		2'b01: {to_fft_go, from_fft_go} <= 2'b10;
		2'b10: {to_fft_go, from_fft_go} <= 2'b01;
		2'b11: {to_fft_go, from_fft_go} <= 2'b00;
		endcase
		to_fir_go <= 0;
		from_fir_go <= 0;
		to_iir_go <= 0;
		from_iir_go <= 0;
	end

	//FIR tri-state enable lofic.
	else if (fir_enable)
	begin
		case ({fir_read_pause, fir_write_pause})
		2'b01: {to_fir_go, from_fir_go} <= 2'b10;
		2'b10: {to_fir_go, from_fir_go} <= 2'b01;
		2'b11: {to_fir_go, from_fir_go} <= 2'b00;
		endcase
		to_fft_go <= 0;
		from_fft_go <= 0;
		to_iir_go <= 0;
		from_iir_go <= 0;
	end

	//IIR tri-state enable lofic.
	else if (iir_enable)
	begin
		case ({iir_read_pause, iir_write_pause})
		2'b01: {to_iir_go, from_iir_go} <= 2'b10;
		2'b10: {to_iir_go, from_iir_go} <= 2'b01;
		2'b11: {to_iir_go, from_iir_go} <= 2'b00;
		endcase
		to_fft_go <= 0;
		from_fft_go <= 0;
		to_fir_go <= 0;
		from_fir_go <= 0;
	end
	else
	begin
		{to_fft_go, from_fft_go, to_fir_go, from_fir_go, to_iir_go, from_iir_go} <= 6'b000000;
	end
end

//Tri-states.
assign addr = (to_fft_go? fft_read_addr : {32'bZ});
assign addr = (from_fft_go? fft_write_addr : {32'bZ});

assign addr = (to_fir_go? fir_read_addr : {32'bZ});
assign addr = (from_fir_go? fir_write_addr : {32'bZ});

assign addr = (to_iir_go? iir_read_addr : {32'bZ});
assign addr = (from_iir_go? iir_write_addr : {32'bZ});
	
endmodule
