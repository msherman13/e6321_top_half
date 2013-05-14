
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:21:08 03/28/2013 
// Design Name: 
// Module Name:    toplevel 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module toplevel(
    input clk,
    input reset,
//    input [15:0] data_a,
//    input [15:0] data_b,
//	 input [15:0] sin_data_in,
	 input [31:0] w_c,
	 output [31:0] hd0,
	 output [31:0] hd1,
	 output [31:0] hd2,
	 output [31:0] hd3,
	 output [31:0] hd4,
	 output [31:0] hd5,
	 output [31:0] hd6
//	 output [31:0] hd7,
//	 output [31:0] hd8,
//	 output [31:0] hd9,
//	 output [31:0] hd10,
//	 output [31:0] hd11,
//	 output [31:0] hd12
 //   input [31:0] data_m1,
 //   input [31:0] data_m2,
//    output [15:0] add_data_out,
//    output [15:0] sin_data_out,
//    output [15:0] mult_data_out
    );
	 
	wire [4:0] control;
	assign control=0;
	wire [4:0] control_minus;
	assign control_minus=0;
//	wire [31:0] float_data_a;
//	wire [31:0] float_data_b;
//	wire [31:0] float_sin_data_in;
//	wire [31:0] float_add_data_out;
//	wire [31:0] float_mult_data_out;
//	wire [31:0] float_sin_data_out;
	wire [4:0] flags;
        wire [4:0] flags_mult;
        wire [4:0] flags_mult1;
        wire [4:0] flags_mult2;
        wire [4:0] flags_mult3;
        wire [4:0] flags_mult4;
        wire [4:0] flags_mult5;
        wire [4:0] flags_mult6;
        wire [4:0] flags_mult7;
        wire [4:0] flags_mult8;
        wire [4:0] flags_mult9;
        wire [4:0] flags_mult10;
        wire [4:0] flags_mult11;
        wire [4:0] flags_mult12;
        wire [4:0] flags_mult13;
        wire [4:0] flags_mult14;
        wire [4:0] flags_mult15;
        wire [4:0] flags_mult16;
        wire [4:0] flags_mult17;
        wire [4:0] flags_mult18;
        wire [4:0] flags_mult19;
        wire [4:0] flags_mult20;
        wire [4:0] flags_mult21;
        wire [4:0] flags_mult22;
        wire [4:0] flags_mult23;
        wire [4:0] flags_mult24;
        wire [4:0] flags_mult25;
        wire [4:0] flags_mult26;
        wire [4:0] flags_mult27;
        wire [4:0] flags_mult28;
        wire [4:0] flags_mult29;
        wire [4:0] flags_mult30;
        wire [4:0] flags_mult31;
        wire [4:0] flags_mult32;
        wire [4:0] flags_mult33;
        wire [4:0] flags_mult34;
        wire [4:0] flags_mult35;
        wire [4:0] flags_mult36;
        wire [4:0] flags_mult37;
        wire [4:0] flags_mult38;
        wire [4:0] flags_mult39;
        wire [4:0] flags_mult40;

	wire [31:0] arg0;
	wire [31:0] arg1;
	wire [31:0] arg2;
	wire [31:0] arg3;
	wire [31:0] arg4;
	wire [31:0] arg5;
	wire [31:0] arg6;
	wire [31:0] arg7;
	wire [31:0] arg8;
	wire [31:0] arg9;
	wire [31:0] arg10;
	wire [31:0] arg11;
	wire [31:0] arg12;

	wire [31:0] arg_a0;
	wire [31:0] arg_a1;
	wire [31:0] arg_a2;
	wire [31:0] arg_a3;
	wire [31:0] arg_a4;
	wire [31:0] arg_a5;
	wire [31:0] arg_a6;
	wire [31:0] arg_a7;
	wire [31:0] arg_a8;
	wire [31:0] arg_a9;
	wire [31:0] arg_a10;
	wire [31:0] arg_a11;
	wire [31:0] arg_a12;


	wire [31:0] sin_out0;
	wire [31:0] sin_out1;
	wire [31:0] sin_out2;
	wire [31:0] sin_out3;
	wire [31:0] sin_out4;
	wire [31:0] sin_out5;
	wire [31:0] sin_out6;
	wire [31:0] sin_out7;
	wire [31:0] sin_out8;
	wire [31:0] sin_out9;
	wire [31:0] sin_out10;
	wire [31:0] sin_out11;
	wire [31:0] sin_out12;
    wire enable;
	assign enable=1'b1;
	



//	reg [31:0] float_wc=32'b00111111010110101101010111110111;

	//integer order =	12;
	
	wire [31:0] hd_div0;
	assign hd_div0=	32'b10111101010110010100110010101111;
	wire [31:0] hd_div1;
	assign hd_div1=	32'b10111101100000100110000100110110;
	wire [31:0] hd_div2;
	assign hd_div2=	32'b10111101101000101111100110000011;
	wire [31:0] hd_div3;
	assign hd_div3=	32'b10111101110110010100110010101111;
	wire [31:0] hd_div4;
	assign hd_div4=	32'b10111110001000101111100110000011;
	wire [31:0] hd_div5;
	assign hd_div5=	32'b10111110101000101111100110000011;
	wire [31:0] hd_div6;
	assign hd_div6=	32'b00111110101000101111100110000011;
	wire [31:0] hd_div7;
	assign hd_div7=	32'b00111110101000101111100110000011;
	wire [31:0] hd_div8;
	assign hd_div8=	32'b00111110001000101111100110000011;
	wire [31:0] hd_div9;
	assign hd_div9=	32'b00111101110110010100110010101111;
	wire [31:0] hd_div10;
	assign hd_div10=	32'b00111101101000101111100110000011;
	wire [31:0] hd_div11;
	assign hd_div11=	32'b00111101100000100110000100110110;
	wire [31:0] hd_div12;
	assign hd_div12=	32'b00111101010110010100110010101111;
	wire [31:0] sin0; 
	assign sin0=		32'b11000000110000000000000000000000;
	wire [31:0] sin1;
	assign sin1=		32'b11000000101000000000000000000000;
	wire [31:0] sin2;
	assign sin2=		32'b11000000100000000000000000000000;
	wire [31:0] sin3;
	assign sin3=		32'b11000000010000000000000000000000;
	wire [31:0] sin4;
	assign sin4=		32'b11000000000000000000000000000000;
	wire [31:0] sin5;
	assign sin5=		32'b10111111100000000000000000000000;
	wire [31:0] sin6;
	assign sin6=		32'b00000000000000000000000000000000;
	wire [31:0] sin7;
	assign sin7=		32'b00111111100000000000000000000000;
	wire [31:0] sin8;
	assign sin8=		32'b01000000000000000000000000000000;
	wire [31:0] sin9;
	assign sin9=		32'b01000000010000000000000000000000;
	wire [31:0] sin10;
	assign sin10=		32'b01000000100000000000000000000000;
	wire [31:0] sin11;
	assign sin11=		32'b01000000101000000000000000000000;
	wire [31:0] sin12;
	assign sin12=		32'b01000000110000000000000000000000;
	wire [31:0] one_over_pi;
	assign one_over_pi=32'b00111110101000101111100110000011;
	//hp
	wire [31:0] one;
	assign one=32'b00111111100000000000000000000000;
	wire save_enable;
	assign save_enable=1'b1;
		
//		fpmul sin_arg0(w_c1, sin0, arg0, control, flags_mult1);
//		fpmul sin_arg1(w_c1, sin1, arg1, control, flags_mult2);
//		fpmul sin_arg2(w_c1, sin2, arg2, control, flags_mult3);
//		fpmul sin_arg3(w_c1, sin3, arg3, control, flags_mult4);
//		fpmul sin_arg4(w_c1, sin4, arg4, control, flags_mult5);
//		fpmul sin_arg5(w_c1, sin5, arg5, control, flags_mult6);
//		fpmul sin_arg6(w_c1, sin6, arg6, control, flags_mult7);
//		fpmul sin_arg7(w_c1, sin7, arg7, control, flags_mult8);
//		fpmul sin_arg8(w_c1, sin8, arg8, control, flags_mult9);
//		fpmul sin_arg9(w_c1, sin9, arg9, control, flags_mult10);
//		fpmul sin_arg10(w_c1, sin10, arg10, control, flags_mult11);
//		fpmul sin_arg11(w_c1, sin11, arg11, control, flags_mult12);
//		fpmul sin_arg12(w_c1, sin12, arg12, control, flags_mult13);
		
		fpmul sin_arg0(w_c, sin0, arg0, control, flags_mult14);
		fpmul sin_arg1(w_c, sin1, arg1, control, flags_mult15);
		fpmul sin_arg2(w_c, sin2, arg2, control, flags_mult16);
		fpmul sin_arg3(w_c, sin3, arg3, control, flags_mult17);
		fpmul sin_arg4(w_c, sin4, arg4, control, flags_mult18);
		fpmul sin_arg5(w_c, sin5, arg5, control, flags_mult19);
		fpmul sin_arg6(w_c, sin6, arg6, control, flags_mult20);
//		fpmul sin_arg7(w_c, sin7, arg7, control, flags_mult21);
//		fpmul sin_arg8(w_c, sin8, arg8, control, flags_mult22);
//		fpmul sin_arg9(w_c, sin9, arg9, control, flags_mult23);
//		fpmul sin_arg10(w_c, sin10, arg10, control, flags_mult24);
//		fpmul sin_arg11(w_c, sin11, arg11, control, flags_mult25);
//		fpmul sin_arg12(w_c, sin12, arg12, control, flags_mult26);
		
		
		sin_arg_adjust saa0(clk, reset, enable, arg0, arg_a0);
		sin_arg_adjust saa1(clk, reset, enable, arg1, arg_a1);
		sin_arg_adjust saa2(clk, reset, enable, arg2, arg_a2);
		sin_arg_adjust saa3(clk, reset, enable, arg3, arg_a3);
		sin_arg_adjust saa4(clk, reset, enable, arg4, arg_a4);
		sin_arg_adjust saa5(clk, reset, enable, arg5, arg_a5);
		sin_arg_adjust saa6(clk, reset, enable, arg6, arg_a6);
//		sin_arg_adjust saa7(clk, reset, enable, arg7, arg_a7);
//		sin_arg_adjust saa8(clk, reset, enable, arg8, arg_a8);
//		sin_arg_adjust saa9(clk, reset, enable, arg9, arg_a9);
//		sin_arg_adjust saa10(clk, reset, enable, arg10, arg_a10);
//		sin_arg_adjust saa11(clk, reset, enable, arg11, arg_a11);
//		sin_arg_adjust saa12(clk, reset, enable, arg12, arg_a12);
		
		sinecalculator sine0(clk, clk_enable, reset, arg_a0, save_enable, sin_out0);
		sinecalculator sine1(clk, clk_enable, reset, arg_a1, save_enable, sin_out1);
		sinecalculator sine2(clk, clk_enable, reset, arg_a2, save_enable, sin_out2);
		sinecalculator sine3(clk, clk_enable, reset, arg_a3, save_enable, sin_out3);
		sinecalculator sine4(clk, clk_enable, reset, arg_a4, save_enable, sin_out4);
		sinecalculator sine5(clk, clk_enable, reset, arg_a5, save_enable, sin_out5);
		sinecalculator sine6(clk, clk_enable, reset, arg_a6, save_enable, sin_out6);
//		sinecalculator sine7(clk, clk_enable, reset, arg_a7, save_enable, sin_out7);
//		sinecalculator sine8(clk, clk_enable, reset, arg_a8, save_enable, sin_out8);
//		sinecalculator sine9(clk, clk_enable, reset, arg_a9, save_enable, sin_out9);
//		sinecalculator sine10(clk, clk_enable, reset, arg_a10, save_enable, sin_out10);
//		sinecalculator sine11(clk, clk_enable, reset, arg_a11, save_enable, sin_out11);
//		sinecalculator sine12(clk, clk_enable, reset, arg_a12, save_enable, sin_out12);
	
	
		fpmul hd_mul0(sin_out0, hd_div0, hd0, control, flags_mult27);
		fpmul hd_mul1(sin_out1, hd_div1, hd1, control, flags_mult28);
		fpmul hd_mul2(sin_out2, hd_div2, hd2, control, flags_mult29);
		fpmul hd_mul3(sin_out3, hd_div3, hd3, control, flags_mult30);
		fpmul hd_mul4(sin_out4, hd_div4, hd4, control, flags_mult31);
		fpmul hd_mul5(sin_out5, hd_div5, hd5, control, flags_mult32);
		fpmul hd_mul6(w_c, one_over_pi, hd6, control, flags_mult33);
//		fpmul hd_mul7(sin_out7, hd_div7, hd7, control, flags_mult34);
//		fpmul hd_mul8(sin_out8, hd_div8, hd8, control, flags_mult35);
//		fpmul hd_mul9(sin_out9, hd_div9, hd9, control, flags_mult36);
//		fpmul hd_mul10(sin_out10, hd_div10, hd10, control, flags_mult37);
//		fpmul hd_mul11(sin_out11, hd_div11, hd11, control, flags_mult38);
//		fpmul hd_mul12(sin_out12, hd_div12, hd12, control, flags_mult39);

		
//		bin_to_float btf_data_a(clk, reset, enable, data_a, float_data_a);
//		bin_to_float btf_data_b(clk, reset, enable, data_b, float_data_b);
//		bin_to_float btf_data_in(clk, reset, enable, sin_data_in, float_sin_data_in);
//
//		fpadd adder(float_data_a,float_data_b,float_add_data_out,control,flags);
//		fpmul multiplier(float_data_a, float_data_b, float_mult_data_out, control, flags_mult40);
//		sinecalculator sine(clk, clk_enable, reset, float_sin_data_in, save_enable, float_sin_data_out);
//	
//		float_to_bin ftb_data_add(clk, reset, ftb_enable, float_add_data_out, add_data_out);
//		float_to_bin ftb_data_mult(clk, reset, ftb_enable, float_mult_data_out, mult_data_out);
//		float_to_bin ftb_data_sin(clk, reset, ftb_enable, float_sin_data_out, sin_data_out);
	


endmodule
