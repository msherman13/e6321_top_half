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


module data_bus_controller (clk, data_bus, fft_data_in, fir_data_in, iir_data_in, fft_data_out, fir_data_out, iir_data_out, to_fft_empty, to_fft_full, from_fft_empty, from_fft_full, to_fir_empty, to_fir_full, from_fir_empty, from_fir_full, to_iir_empty, to_iir_full, from_iir_empty, from_iir_full, data_to_fft, data_from_fft, data_to_fir, data_from_fir, data_to_iir, data_from_iir, fft_enable, fir_enable, iir_enable, fft_put_req, fft_get_req, fir_put_req, fir_get_req, iir_put_req, iir_get_req, ram_read_enable, ram_write_enable, reset);

inout [31:0] data_bus;

input [31:0] fft_data_in, fir_data_in, iir_data_in;
input clk, to_fft_empty, to_fft_full, from_fft_empty, from_fft_full, to_fir_empty, to_fir_full, from_fir_empty, from_fir_full, to_iir_empty, to_iir_full, from_iir_empty, from_iir_full, fft_enable, fir_enable, iir_enable, reset;

output [31:0] fft_data_out, fir_data_out, iir_data_out;
output data_to_fft, data_from_fft, data_to_fir, data_from_fir, data_to_iir, data_from_iir, fft_put_req, fft_get_req, fir_put_req, fir_get_req, iir_put_req, iir_get_req, ram_read_enable, ram_write_enable;

reg data_to_fft, data_from_fft, data_to_fir, data_from_fir, data_to_iir, data_from_iir, fft_put_req, fft_get_req, fir_put_req, fir_get_req, iir_put_req, iir_get_req, ram_read, ram_write, fft_full_flag, fir_full_flag, iir_full_flag, fft_empty_flag;

reg [31:0] data, data_in;
	
initial
begin
	ram_read = 0;
	ram_write = 0;
	fft_full_flag = 0;
	fir_full_flag = 0;
	iir_full_flag = 0;
	data = 32'bZ;
	data_in = 32'bZ;
end

always @(*) begin
	//if (ram_read && (data_to_fft || data_to_fir || data_to_iir)) begin
	//	data <= 32'bZ;
	//end
	if (fft_enable) begin
		case ({to_fft_empty, to_fft_full, from_fft_empty, from_fft_full})
		4'b0000: {data_to_fft, data_from_fft} <= 2'b01;
		4'b0001: {data_to_fft, data_from_fft} <= 2'b01;
		4'b0010: if (!fft_full_flag) begin {data_to_fft, data_from_fft} <= 2'b10; end
		4'b0100: {data_to_fft, data_from_fft} <= 2'b01;
		4'b0101: {data_to_fft, data_from_fft} <= 2'b01;
		4'b0110: {data_to_fft, data_from_fft} <= 2'b00;
		4'b1000: if (!fft_full_flag) begin {data_to_fft, data_from_fft} <= 2'b10; end
		4'b1001: {data_to_fft, data_from_fft} <= 2'b01;
		4'b1010: if (!fft_full_flag) begin {data_to_fft, data_from_fft} <= 2'b10; end
		default: {data_to_fft, data_from_fft} <= 2'b00;
		endcase
		data_to_fir <= 0;
		data_from_fir <= 0;
		data_to_iir <= 0;
		data_from_iir <=0;
	end
	else if (fir_enable) begin
		case ({to_fir_empty, to_fir_full, from_fir_empty, from_fir_full})
		4'b0000: {data_to_fir, data_from_fir} <= 2'b01;
		4'b0001: {data_to_fir, data_from_fir} <= 2'b01;
		4'b0010: if (!fir_full_flag) begin {data_to_fir, data_from_fir} <= 2'b10; end
		4'b0100: {data_to_fir, data_from_fir} <= 2'b01;
		4'b0101: {data_to_fir, data_from_fir} <= 2'b01;
		4'b0110: {data_to_fir, data_from_fir} <= 2'b00;
		4'b1000: if (!fir_full_flag) begin {data_to_fir, data_from_fir} <= 2'b10; end
		4'b1001: {data_to_fir, data_from_fir} <= 2'b01;
		4'b1010: if (!fir_full_flag) begin {data_to_fir, data_from_fir} <= 2'b10; end
		default: {data_to_fir, data_from_fir} <= 2'b00;
		endcase
		data_to_fft <= 0;
		data_from_fft <= 0;
		data_to_iir <= 0;
		data_from_iir <=0;
	end
	else if (iir_enable) begin
		case ({to_iir_empty, to_iir_full, from_iir_empty, from_iir_full})
		4'b0000: if (!ram_read) begin {data_to_iir, data_from_iir} <= 2'b01; end
		4'b0001: if (!ram_read) begin {data_to_iir, data_from_iir} <= 2'b01; end
		4'b0010: if (!ram_write) begin if (!iir_full_flag) begin {data_to_iir, data_from_iir} <= 2'b10; end end
		4'b0100: if (!ram_read) begin {data_to_iir, data_from_iir} <= 2'b01; end
		4'b0101: if (!ram_read) begin {data_to_iir, data_from_iir} <= 2'b01; end
		4'b0110: {data_to_iir, data_from_iir} <= 2'b00;
		4'b1000: if (!ram_write) begin if (!iir_full_flag) begin {data_to_iir, data_from_iir} <= 2'b10; end end
		4'b1001: if (!ram_read) begin {data_to_iir, data_from_iir} <= 2'b01; end
		4'b1010: if (!ram_write) begin if (!iir_full_flag) begin {data_to_iir, data_from_iir} <= 2'b10; end end
		default: {data_to_iir, data_from_iir} <= {data_to_iir, data_from_iir};
		endcase
		data_to_fir <= 0;
		data_from_fir <= 0;
		data_to_fft <= 0;
		data_from_fft <=0;
	end
end

always @(posedge clk)
begin
	if (ram_read) begin //RAM READ
		data <= data_bus;
		//data <= (!(ram_read && (data_to_fft || data_to_fir || data_to_iir)) ? data_bus : {32'bZ});
		if (fft_enable) begin
			if (to_fft_full) begin
				fft_full_flag <= 1;
			end
			else begin
				fft_put_req <= 1;
			end
		end
		else if (fir_enable) begin
			if (to_fir_full) begin
				fir_full_flag <= 1;
			end
			else begin
				fir_put_req <= 1;
			end
		end
		else if (iir_enable) begin
			if (to_iir_full) begin
				iir_full_flag <= 1;
			end
			else begin
				iir_put_req <= 1;
			end
		end
		{ram_read, ram_write} <= 2'b00;
	end
	
	else if (fft_get_req) begin //RAM WRITE
		if (fft_enable) begin
			ram_write <= 1;
		end
		{ram_read, fft_get_req} <= 2'b00;
	end
	
	else if (fir_get_req) begin //RAM WRITE
		if (fir_enable) begin
			ram_write <= 1;
		end
		{ram_read, fir_get_req} <= 2'b00;
	end
	
	else if (iir_get_req) begin //RAM WRITE
		if (iir_enable) begin
			ram_write <= 1;
		end
		{ram_read, iir_get_req} <= 2'b00;
	end
	
	else if (!to_fft_full && fft_full_flag) begin
		fft_put_req <= 1;
		fft_full_flag <= 0;
	end
	
	else if (!to_fir_full && fir_full_flag) begin
		fir_put_req <= 1;
		fir_full_flag <= 0;
	end
	
	else if (!to_iir_full && iir_full_flag) begin
		iir_put_req <= 1;
		iir_full_flag <= 0;
	end
	
	else begin
	
	//FSM for FFT enable.
	if (fft_enable)
	begin
		
		if (data_to_fft == 1)
		begin
			{fft_put_req, fft_get_req} <= 2'b00;
			{ram_read, fft_get_req, ram_write} <= 3'b100;
		end
		else if (data_from_fft)
		begin
			{fft_put_req, fft_get_req} <= 2'b00;
			data_in = fft_data_in;
			{ram_read, fft_get_req, ram_write} <= 3'b010;
		end
		else
		begin
			{fft_put_req, fft_get_req} <= 2'b00;
			{ram_read, fft_get_req, ram_write} <= 3'b000;
		end
	end

	//FSM for FIR enable.
	else if (fir_enable)
	begin
		
		if (data_to_fir == 1)
		begin
			{fir_put_req, fir_get_req} <= 2'b00;
			{ram_read, fir_get_req, ram_write} <= 3'b100;
		end
		else if (data_from_fir)
		begin
			{fir_put_req, fir_get_req} <= 2'b00;
			data_in = fir_data_in;
			{ram_read, fir_get_req, ram_write} <= 3'b010;
		end
		else
		begin
			{fir_put_req, fir_get_req} <= 2'b00;
			{ram_read, fir_get_req, ram_write} <= 3'b000;
		end
	end

	//FSM for IIR enable.
	else if (iir_enable)
	begin
		
		if (data_to_iir == 1)
		begin
			{iir_put_req, iir_get_req} <= 2'b00;
			{ram_read, iir_get_req} <= 2'b10;
		end
		else if (data_from_iir)
		begin
			{iir_put_req, iir_get_req} <= 2'b00;
			data_in = iir_data_in;
			{ram_read, iir_get_req, ram_write} <= 3'b010;
		end
		else
		begin
			{iir_put_req, iir_get_req} <= 2'b00;
			{ram_read, iir_get_req, ram_write} <= 3'b000;
		end
	end
	
	else
	begin
		//{data_to_fft, data_from_fft, data_to_fir, data_from_fir, data_to_iir, data_from_iir} <= 6'b000000;
		{fft_put_req, fft_get_req, fir_put_req, fir_get_req, iir_put_req, iir_get_req} <= 6'b000000;
		{ram_read, ram_write} <= 2'b00;
	end
	end
end

	assign data_bus = ((data_from_fft || data_from_fir || data_from_iir || ram_write) ? data_in : {32'bZ});
	
	assign fft_data_out = data;
	assign fir_data_out = data;
	assign iir_data_out = data;
	
	assign ram_read_enable = ram_read;
	assign ram_write_enable = ram_write;

endmodule
