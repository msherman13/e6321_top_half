/******************************************************************************
**
** Module:      data_bus_controller
** Description: Tri-state logic to control data i/o between accelerators & RAM.
**              data_in means data coming into router.
**              data_out means data going out of router.
**              to_accelerator means data going from router to acc. FIFO.
**              from_accelerator means data coming from acc. FIFO to router.
**
** Author:      Miles Sherman
** Contact:     ms4543@columbia.edu
** Affiliation: Columbia University
**
** Last Update: 03/07/2013
**
******************************************************************************/


module data_bus_controller (data_bus, fft_data_in, fir_data_in, fft_data_out, fir_data_out, to_fft_empty, to_fft_full, from_fft_empty, from_fft_full, to_fir_empty, to_fir_full, from_fir_empty, from_fir_full, data_to_fft, data_from_fft, data_to_fir, data_from_fir, fft_enable, fir_enable, fft_put_req, fft_get_req, fir_put_req, fir_get_req, ram_read_enable, ram_write_enable, clk, reset);

inout [31:0] data_bus;

input [31:0] fft_data_in, fir_data_in;
input to_fft_empty, to_fft_full, from_fft_empty, from_fft_full, to_fir_empty, to_fir_full, from_fir_empty, from_fir_full, fft_enable, fir_enable, clk, reset;

output [31:0] fft_data_out, fir_data_out;
output data_to_fft, data_from_fft, data_to_fir, data_from_fir, fft_put_req, fft_get_req, fir_put_req, fir_get_req, ram_read_enable, ram_write_enable;

reg data_to_fft, data_from_fft, data_to_fir, data_from_fir, fft_put_req, fft_get_req, fir_put_req, fir_get_req, ram_read_enable, ram_write_enable;
	


always @(*)
begin

	//FSM for FFT enable.
	if (fft_enable)
	begin
		case ({to_fft_empty, to_fft_full, from_fft_empty, from_fft_full})
		4'b0000: {data_to_fft, data_from_fft} <= 2'b01;
		4'b0001: {data_to_fft, data_from_fft} <= 2'b01;
		4'b0010: {data_to_fft, data_from_fft} <= 2'b10;
		4'b0100: {data_to_fft, data_from_fft} <= 2'b01;
		4'b0101: {data_to_fft, data_from_fft} <= 2'b01;
		4'b0110: {data_to_fft, data_from_fft} <= 2'b00;
		4'b1000: {data_to_fft, data_from_fft} <= 2'b10;
		4'b1001: {data_to_fft, data_from_fft} <= 2'b01;
		4'b1010: {data_to_fft, data_from_fft} <= 2'b10;
		endcase
		data_to_fir <= 0;
		data_from_fir <= 0;
		
		if (data_to_fft == 1)
		begin
			{fft_put_req, fft_get_req} <= 2'b10;
			{ram_read_enable, ram_write_enable} <= 2'b10;
		end
		else if (data_from_fft == 1)
		begin
			{fft_put_req, fft_get_req} <= 2'b01;
			{ram_read_enable, ram_write_enable} <= 2'b01;
		end
		else
		begin
			{fft_put_req, fft_get_req} <= 2'b00;
			{ram_read_enable, ram_write_enable} <= 2'b00;
		end
	end

	//FSM for FIR enable.
	else if (fir_enable)
	begin
		case ({to_fir_empty, to_fir_full, from_fir_empty, from_fir_full})
		4'b0000: {data_to_fir, data_from_fir} <= 2'b01;
		4'b0001: {data_to_fir, data_from_fir} <= 2'b01;
		4'b0010: {data_to_fir, data_from_fir} <= 2'b10;
		4'b0100: {data_to_fir, data_from_fir} <= 2'b01;
		4'b0101: {data_to_fir, data_from_fir} <= 2'b01;
		4'b0110: {data_to_fir, data_from_fir} <= 2'b00;
		4'b1000: {data_to_fir, data_from_fir} <= 2'b10;
		4'b1001: {data_to_fir, data_from_fir} <= 2'b01;
		4'b1010: {data_to_fir, data_from_fir} <= 2'b10;
		endcase
		data_to_fft <= 0;
		data_from_fft <= 0;

		if (data_to_fir == 1)
		begin
			{fir_put_req, fir_get_req} <= 2'b10;
			{ram_read_enable, ram_write_enable} <= 2'b10;
		end
		else if (data_from_fir == 1)
		begin
			{fir_put_req, fir_get_req} <= 2'b01;
			{ram_read_enable, ram_write_enable} <= 2'b01;
		end
		else
		begin
			{fir_put_req, fir_get_req} <= 2'b00;
			{ram_read_enable, ram_write_enable} <= 2'b00;
		end
	end
	else
	begin
		{data_to_fft, data_from_fft, data_to_fir, data_from_fir} <= 4'b0000;
		{fft_put_req, fft_get_req, fir_put_req, fir_get_req} <= 4'b0000;
		{ram_read_enable, ram_write_enable} <= 2'b00;
	end
end

	assign data_bus = (data_from_fft ? fft_data_in : {32'bZ});
	assign fft_data_out = (data_to_fft ? data_bus : {32'bZ});

	assign data_bus = (data_from_fir ? fir_data_in : {32'bZ});
	assign fir_data_out = (data_to_fir ? data_bus : {32'bZ});

endmodule
