module acc
(
	input clk, reset,
        input accbypass,
        input [31:0] fullinstruction,
        output reg accbypassA,
        output reg [31:0] fullinstructionA
);
	reg countflag;
 	reg [1:0] count;
 
	always @(posedge clk)
	begin
	  if (reset | ~accbypass) 
          begin
            count <= 0;
	  end
	  else
          begin
            if (countflag) count <= count + 1;
            else count <= count;
          end
	end

        always @(posedge clk)
        if (reset | ~accbypass)
        begin
          fullinstructionA <= 0;
          accbypassA <= 0;
        end
        else if (countflag == 0)
        begin
          fullinstructionA <= fullinstruction;
          accbypassA <= accbypass;
        end
        else
        begin
          fullinstructionA <= 0;
          accbypassA <= 0;
        end

        always @(*)
        begin
          if (reset | ~accbypass) countflag = 1;
          else if (count == 2'b11) countflag = 0;
          else countflag = countflag;
        end

endmodule
