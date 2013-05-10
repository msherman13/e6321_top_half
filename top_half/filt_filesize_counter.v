/******************************************************************************
**
** Module:      filt_filesize_counter
** Description: Counter for address calculation for 1x1 word accelerators.
**
** Author:      Miles Sherman
** Affiliation: Columbia University
**
** Last Update: 03/08/2013
**
******************************************************************************/

module counter1 (filesize,enable,pause,clk,count,done);
        input [31:0] filesize;
        input enable, clk, pause;
        output [31:0] count;
        output done;

reg[31:0] count;
reg done, hold;

always @(posedge clk)
begin
	if (hold == 1) begin
		hold = 0;
		count <= count;
	end
	else begin
        if (enable)
        begin
                if (count != filesize-1)
                begin
                        if (!pause)
                        begin
                                if (count == -1)
                                begin
                                        count <= 0;
                                        done <= 0;
                                        hold <= 1;
                                end else
                                begin
                                        done <= 0;
                                        count <= count + 1;
                                        hold <= 1;
                                end
                        end else
                        begin
                                count <= count;
                                done <= 0;
                        end
                end else
                begin
                        count <= count;
                        done <= 1;
                end
        end else
        begin
                count <= -1;
                done <= 0;
        end
       end
end
endmodule
