module acc
(
	input clk, reset,
        input accdone, accbypass,
        input [5:0] startaddr,
        input [5:0] datasize,
        output accbypassA,
        output [5:0] startaddrA,
        output [5:0] datasizeA
);
	reg countflag;
 	reg [1:0] count;
        reg accbypassA_reg;
        reg [5:0] startaddrA_reg;
        reg [5:0] datasizeA_reg;

	assign accbypassA = accbypassA_reg;
	assign startaddrA = startaddrA_reg;
	assign datasizeA = datasizeA_reg;

	always@(posedge clk)
	begin
	  if (reset | accdone) begin
		                 countflag <= 1;
                                 count <= 0;
		                 accbypassA_reg <= 0;
		               end
          else begin
		 if (accbypass & countflag) count <= count + 1;
	         else begin
                        accbypassA_reg <= accbypass;
                        startaddrA_reg <= startaddr;
                        datasizeA_reg <= datasize;
                      end
	       end	
	end

	always@(count)
	begin
	  if (count == 2'b11) countflag <= 0;
          else countflag <= countflag;
        end

endmodule
