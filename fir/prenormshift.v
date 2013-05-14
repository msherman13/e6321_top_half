


module prenormshift(a,b,shifta,shiftb);
input [31:0] a;
input [31:0] b;
output [4:0] shifta;
output [4:0] shiftb;


assign shifta = a[23 - 1] ? 1 :
                 a[23 - 2] ? 2 :
                 a[23 - 3] ? 3 :
                 a[23 - 4] ? 4 :
                 a[23 - 5] ? 5 :
                 a[23 - 6] ? 6 :
                 a[23 - 7] ? 7 :
                 a[23 - 8] ? 8 :
                 a[23 - 9] ? 9 :
                 a[23 - 10] ? 10 :
                 a[23 - 11] ? 11 :
                 a[23 - 12] ? 12 :
                 a[23 - 13] ? 13 :
                 a[23 - 14] ? 14 :
                 a[23 - 15] ? 15 :
                 a[23 - 16] ? 16 :
                 a[23 - 17] ? 17 :
                 a[23 - 18] ? 18 :
                 a[23 - 19] ? 19 :
                 a[23 - 20] ? 20 :
                 a[23 - 21] ? 21 :
                 a[23 - 22] ? 22 :
                 23; // dont need to check last bit
// if the second to last isn't 1, then the last one must be

assign shiftb = b[23 - 1] ? 1 :
                 b[23 - 2] ? 2 :
                 b[23 - 3] ? 3 :
                 b[23 - 4] ? 4 :
                 b[23 - 5] ? 5 :
                 b[23 - 6] ? 6 :
                 b[23 - 7] ? 7 :
                 b[23 - 8] ? 8 :
                 b[23 - 9] ? 9 :
                 b[23 - 10] ? 10 :
                 b[23 - 11] ? 11 :
                 b[23 - 12] ? 12 :
                 b[23 - 13] ? 13 :
                 b[23 - 14] ? 14 :
                 b[23 - 15] ? 15 :
                 b[23 - 16] ? 16 :
                 b[23 - 17] ? 17 :
                 b[23 - 18] ? 18 :
                 b[23 - 19] ? 19 :
                 b[23 - 20] ? 20 :
                 b[23 - 21] ? 21 :
                 b[23 - 22] ? 22 :
                 23; // dont need to check last bit
// if the second to last isn't 1, then the last one must be

endmodule
