
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:44:47 03/31/2013 
// Design Name: 
// Module Name:    coefficient_calculation 
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
module coefficient_calculation(
     clk,
     reset,
    f_c1,
    f_c2,
    choose_filter,
    coeff0,
    coeff1,
    coeff2,
    coeff3,
    coeff4,
    coeff5,
    coeff6,
    coeff7,
    coeff8,
    coeff9,
    coeff10,
    coeff11,
    coeff12
    );
	    input clk;
    input reset;
    input [15:0] f_c1;
    input [15:0] f_c2;
	 input [1:0] choose_filter;
    output [31:0] coeff0;
    output [31:0] coeff1;
    output [31:0] coeff2;
    output [31:0] coeff3;
    output [31:0] coeff4;
    output [31:0] coeff5;
    output [31:0] coeff6;
    output [31:0] coeff7;
    output [31:0] coeff8;
    output [31:0] coeff9;
    output [31:0] coeff10;
    output [31:0] coeff11;
    output [31:0] coeff12;

    reg [31:0] coeff0;
    reg [31:0] coeff1;
    reg [31:0] coeff2;
    reg [31:0] coeff3;
    reg [31:0] coeff4;
    reg [31:0] coeff5;
    reg [31:0] coeff6;
    reg [31:0] coeff7;
    reg [31:0] coeff8;
    reg [31:0] coeff9;
    reg [31:0] coeff10;
    reg [31:0] coeff11;
    reg [31:0] coeff12;
	//reg [31:0] w_c=32'b00111111010110101101010111110111;
	//wire [15:0] f_c1;
	//wire [15:0] f_c2;
	wire [31:0] f_c1_float;
	wire [31:0] f_c2_float;
	 
	//reg [31:0] w_c_factor=32'b00111001000010010100001000011110;		//f_sample=48000
	wire [31:0] w_c_factor;
	assign w_c_factor=32'b00111001000101010110010110010010;			//f_sample=44100
	wire [31:0] w_c1;
	wire [31:0] w_c2;
	wire [4:0] control;
	assign control=5'b00000;
	
	wire [31:0] hd_L10;
	wire [31:0] hd_L11;
	wire [31:0] hd_L12;
	wire [31:0] hd_L13;
	wire [31:0] hd_L14;
	wire [31:0] hd_L15;
	wire [31:0] hd_L16;
	wire [31:0] hd_L17;
	wire [31:0] hd_L18;
	wire [31:0] hd_L19;
	wire [31:0] hd_L110;
	wire [31:0] hd_L111;
	wire [31:0] hd_L112;

	wire [31:0] hd_L20;
	wire [31:0] hd_L21;
	wire [31:0] hd_L22;
	wire [31:0] hd_L23;
	wire [31:0] hd_L24;
	wire [31:0] hd_L25;
	wire [31:0] hd_L26;
	wire [31:0] hd_L27;
	wire [31:0] hd_L28;
	wire [31:0] hd_L29;
	wire [31:0] hd_L210;
	wire [31:0] hd_L211;
	wire [31:0] hd_L212;

	
	wire [31:0] hd_H1_wire;
	reg [31:0] hd_H10;
	reg [31:0] hd_H11;
	reg [31:0] hd_H12;
	reg [31:0] hd_H13;
	reg [31:0] hd_H14;
	reg [31:0] hd_H15;
	reg [31:0] hd_H16;
	reg [31:0] hd_H17;
	reg [31:0] hd_H18;
	reg [31:0] hd_H19;
	reg [31:0] hd_H110;
	reg [31:0] hd_H111;
	reg [31:0] hd_H112;



//	reg [31:0] temp_hd_H10;
//	reg [31:0] temp_hd_H11;
//	reg [31:0] temp_hd_H12;
//	reg [31:0] temp_hd_H13;
//	reg [31:0] temp_hd_H14;
//	reg [31:0] temp_hd_H15;
//	reg [31:0] temp_hd_H16;
//	reg [31:0] temp_hd_H17;
//	reg [31:0] temp_hd_H18;
//	reg [31:0] temp_hd_H19;
//	reg [31:0] temp_hd_H110;
//	reg [31:0] temp_hd_H111;
//	reg [31:0] temp_hd_H112;


	reg [31:0] hd0;
	reg [31:0] hd1;
	reg [31:0] hd2;
	reg [31:0] hd3;
	reg [31:0] hd4;
	reg [31:0] hd5;
	reg [31:0] hd6;
	reg [31:0] hd7;
	reg [31:0] hd8;
	reg [31:0] hd9;
	reg [31:0] hd10;
	reg [31:0] hd11;
	reg [31:0] hd12;
	
    // wire [31:0] hd0w;
	// wire [31:0] hd1w;
	// wire [31:0] hd2w;
	// wire [31:0] hd3w;
	// wire [31:0] hd4w;
	// wire [31:0] hd5w;
	// wire [31:0] hd6w;
	// wire [31:0] hd7w;
	// wire [31:0] hd8w;
	// wire [31:0] hd9w;
	// wire [31:0] hd10w;
	// wire [31:0] hd11w;
	// wire [31:0] hd12w;
	// assign hd0w=
	wire [31:0] one_over_pi;
	assign one_over_pi=32'b00111110101000101111100110000011;
	wire [31:0] one;
	assign one=32'b00111111100000000000000000000000;
	
	wire [31:0] w0;
	assign w0=32'b00111101101000111101011100001010;
	wire [31:0] w1;
	assign w1=32'b00111110000100010000011100000011;
	wire [31:0] w2;
	assign w2=32'b00111110100111101011100001010010;
	wire [31:0] w3;
	assign w3=32'b00111111000010100011110101110001;
	wire [31:0] w4;
	assign w4=32'b00111111010001010001111010111000;
	wire [31:0] w5;
	assign w5=32'b00111111011100000011100100100000;
	wire [31:0] w6;
	assign w6=32'b00111111100000000000000000000000;
	
	wire [4:0] control_minus;
	assign control_minus=5'b10000;
	wire [31:0] hd_bp0;
	wire [31:0] hd_bp1;
	wire [31:0] hd_bp2;
	wire [31:0] hd_bp3;
	wire [31:0] hd_bp4;
	wire [31:0] hd_bp5;
	wire [31:0] hd_bp6;
	wire [31:0] hd_bp7;
	wire [31:0] hd_bp8;
	wire [31:0] hd_bp9;
	wire [31:0] hd_bp10;
	wire [31:0] hd_bp11;
	wire [31:0] hd_bp12;	
	wire [31:0] hd_bs0;
	wire [31:0] hd_bs1;
	wire [31:0] hd_bs2;
	wire [31:0] hd_bs3;
	wire [31:0] hd_bs4;
	wire [31:0] hd_bs5;
	wire [31:0] hd_bs6;
	wire [31:0] hd_bs7;
	wire [31:0] hd_bs8;
	wire [31:0] hd_bs9;
	wire [31:0] hd_bs10;
	wire [31:0] hd_bs11;
	wire [31:0] hd_bs12;	
	wire [31:0] delta_w_c;
	
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
    wire [4:0] flags;
    wire [4:0] flags2;
    wire [4:0] flags3;
    wire [4:0] flags1;
    wire [4:0] flags4;
    wire [4:0] flags5;
    wire [4:0] flags6;
    wire [4:0] flags7;
    wire [4:0] flags8;
    wire [4:0] flags9;
    wire [4:0] flags10;
    wire [4:0] flags11;
    wire [4:0] flags12;
	    wire [4:0] flags13;
		    wire [4:0] flags14;
	
	wire enable;
assign enable=1'b1;
	//reg [31:0] norm_temp=32'b00000000001100110100100111001111; //*1000 ->3361231
	//reg [31:0] norm_temp=16'b1000001101001100;
	wire [15:0] norm1;
	assign norm1=16'b1000001101001100/f_c1;
	wire [15:0] norm2;
	assign norm2=16'b1000001101001100/f_c2;
	wire [31:0] norm1_float;
	wire [31:0] norm2_float;
	wire [31:0] norm_final1;
//	wire [31:0] norm_final2;
	wire [31:0] zero_point_one;
	assign zero_point_one=32'b00111101110011001100110011001101;
	bin_to_float norm_1(clk, reset, enable, norm1, norm1_float);
	bin_to_float norm_2(clk, reset, enable, norm2, norm2_float);
	fpmul norm_factor1(norm1_float, zero_point_one, norm_final1, control, flags_mult);
//	fpmul norm_factor2(norm2_float, zero_point_one, norm_final2, control, flags_mult1);
	wire [31:0] temp_coeff_lp0;
	wire [31:0] temp_coeff_lp1;
	wire [31:0] temp_coeff_lp2;
	wire [31:0] temp_coeff_lp3;
	wire [31:0] temp_coeff_lp4;
	wire [31:0] temp_coeff_lp5;
	wire [31:0] temp_coeff_lp6;
	wire [31:0] temp_coeff_lp7;
	wire [31:0] temp_coeff_lp8;
	wire [31:0] temp_coeff_lp9;
	wire [31:0] temp_coeff_lp10;
	wire [31:0] temp_coeff_lp11;
	wire [31:0] temp_coeff_lp12;

	wire [31:0] coeff_lp0;
	wire [31:0] coeff_lp1;
	wire [31:0] coeff_lp2;
	wire [31:0] coeff_lp3;
	wire [31:0] coeff_lp4;
	wire [31:0] coeff_lp5;
	wire [31:0] coeff_lp6;
	wire [31:0] coeff_lp7;
	wire [31:0] coeff_lp8;
	wire [31:0] coeff_lp9;
	wire [31:0] coeff_lp10;
	wire [31:0] coeff_lp11;
	wire [31:0] coeff_lp12;

	wire [31:0] coeff_rest0;
	wire [31:0] coeff_rest1;
	wire [31:0] coeff_rest2;
	wire [31:0] coeff_rest3;
	wire [31:0] coeff_rest4;
	wire [31:0] coeff_rest5;
	wire [31:0] coeff_rest6;
	wire [31:0] coeff_rest7;
	wire [31:0] coeff_rest8;
	wire [31:0] coeff_rest9;
	wire [31:0] coeff_rest10;
	wire [31:0] coeff_rest11;
	wire [31:0] coeff_rest12;


	
	
	bin_to_float f_c1_btf(clk, reset, enable, f_c1, f_c1_float);
	fpmul f_c_fir_lp(w_c_factor, f_c1_float, w_c1, control, flags_mult2);
	
	bin_to_float f_c2_btf(clk, reset, enable, f_c2, f_c2_float);
	fpmul f_c_fir_hp(w_c_factor, f_c2_float, w_c2, control, flags_mult3);
	
	toplevel f_c1_coeff(clk,reset,w_c1,hd_L10,hd_L11,hd_L12,hd_L13,hd_L14,hd_L15,hd_L16);
//	toplevel f_c2_coeff(clk,reset,w_c2,hd_L20,hd_L21,hd_L22,hd_L23,hd_L24,hd_L25,hd_L26);

		fpmul coeff_mul0(hd0, w0, coeff_rest0, control, flags_mult4);
		fpmul coeff_mul1(hd1, w1, coeff_rest1, control, flags_mult5);
		fpmul coeff_mul2(hd2, w2, coeff_rest2, control, flags_mult6);
		fpmul coeff_mul3(hd3, w3, coeff_rest3, control, flags_mult7);
		fpmul coeff_mul4(hd4, w4, coeff_rest4, control, flags_mult8);
		fpmul coeff_mul5(hd5, w5, coeff_rest5, control, flags_mult9);
		fpmul coeff_mul6(hd6, w6, coeff_rest6, control, flags_mult10);
	//	fpmul coeff_mul7(hd[7], w5, coeff_rest7, control, flags_mult);
	//	fpmul coeff_mul8(hd[8], w4, coeff_rest8, control, flags_mult);
	//	fpmul coeff_mul9(hd[9], w3, coeff_rest9, control, flags_mult);
	//	fpmul coeff_mul10(hd[10], w2, coeff_rest10, control, flags_mult);
	//	fpmul coeff_mul11(hd[11], w1, coeff_rest11, control, flags_mult);
	//	fpmul coeff_mul12(hd[12], w0, coeff_rest12, control, flags_mult);
		
		fpmul coeff_mul00(hd0, w0, temp_coeff_lp0, control, flags_mult11);
		fpmul coeff_mul01(hd1, w1, temp_coeff_lp1, control, flags_mult12);
		fpmul coeff_mul02(hd2, w2, temp_coeff_lp2, control, flags_mult13);
		fpmul coeff_mul03(hd3, w3, temp_coeff_lp3, control, flags_mult14);
		fpmul coeff_mul04(hd4, w4, temp_coeff_lp4, control, flags_mult15);
		fpmul coeff_mul05(hd5, w5, temp_coeff_lp5, control, flags_mult16);
		fpmul coeff_mul06(hd6, w6, temp_coeff_lp6, control, flags_mult17);
	//	fpmul coeff_mul07(hd[7], w5, temp_coeff_lp7, control, flags_mult);
	//	fpmul coeff_mul08(hd[8], w4, temp_coeff_lp8, control, flags_mult);
	//	fpmul coeff_mul09(hd[9], w3, temp_coeff_lp9, control, flags_mult);
	//	fpmul coeff_mul010(hd[10], w2, temp_coeff_lp10, control, flags_mult);
	//	fpmul coeff_mul011(hd[11], w1, temp_coeff_lp11, control, flags_mult);
	//	fpmul coeff_mul012(hd[12], w0, temp_coeff_lp12, control, flags_mult);
		
		
		fpmul coeff_mul000(temp_coeff_lp0, norm_final1, coeff_lp0, control, flags_mult18);
		fpmul coeff_mul001(temp_coeff_lp1, norm_final1, coeff_lp1, control, flags_mult19);
		fpmul coeff_mul002(temp_coeff_lp2, norm_final1, coeff_lp2, control, flags_mult20);
		fpmul coeff_mul003(temp_coeff_lp3, norm_final1, coeff_lp3, control, flags_mult21);
		fpmul coeff_mul004(temp_coeff_lp4, norm_final1, coeff_lp4, control, flags_mult22);
		fpmul coeff_mul005(temp_coeff_lp5, norm_final1, coeff_lp5, control, flags_mult23);
		fpmul coeff_mul006(temp_coeff_lp6, norm_final1, coeff_lp6, control, flags_mult24);
	//	fpmul coeff_mul007(temp_coeff_lp7, norm_final1, coeff_lp[7], control, flags_mult);
	//	fpmul coeff_mul008(temp_coeff_lp8, norm_final1, coeff_lp[8], control, flags_mult);
	//	fpmul coeff_mul009(temp_coeff_lp9, norm_final1, coeff_lp[9], control, flags_mult);
	//	fpmul coeff_mul0010(temp_coeff_lp10, norm_final1, coeff_lp[10], control, flags_mult);
	//	fpmul coeff_mul0011(temp_coeff_lp11, norm_final1, coeff_lp[11], control, flags_mult);
	//	fpmul coeff_mul0012(temp_coeff_lp12, norm_final1, coeff_lp[12], control, flags_mult);
		
	//always @(choose_filter,clk, f_c1, f_c2) begin
	always @(posedge clk) begin
		if (choose_filter==2'b00) begin
			coeff0<=coeff_lp0;
			coeff1<=coeff_lp1;
			coeff2<=coeff_lp2;
			coeff3<=coeff_lp3;
			coeff4<=coeff_lp4;
			coeff5<=coeff_lp5;
			coeff6<=coeff_lp6;
			coeff7<=coeff_lp5;
			coeff8<=coeff_lp4;
			coeff9<=coeff_lp3;
			coeff10<=coeff_lp2;
			coeff11<=coeff_lp1;
			coeff12<=coeff_lp0;
		end else begin
			coeff0<=coeff_rest0;
			coeff1<=coeff_rest1;
			coeff2<=coeff_rest2;
			coeff3<=coeff_rest3;
			coeff4<=coeff_rest4;
			coeff5<=coeff_rest5;
			coeff6<=coeff_rest6;
			coeff7<=coeff_rest5;
			coeff8<=coeff_rest4;
			coeff9<=coeff_rest3;
			coeff10<=coeff_rest2;
			coeff11<=coeff_rest1;
			coeff12<=coeff_rest0;
		end
	end
			
		
		//HIGH PASS
		always @ (posedge clk) begin
			hd_H10[30:0]<=hd_L10[30:0];
			hd_H11[30:0]<=hd_L11[30:0];
			hd_H12[30:0]<=hd_L12[30:0];
			hd_H13[30:0]<=hd_L13[30:0];
			hd_H14[30:0]<=hd_L14[30:0];
			hd_H15[30:0]<=hd_L15[30:0];
			hd_H17[30:0]<=hd_L17[30:0];
	//		hd_H18[30:0]<=hd_L18[30:0];
	//		hd_H19[30:0]<=hd_L19[30:0];
	//		hd_H110[30:0]<=hd_L110[30:0];
	//		hd_H111[30:0]<=hd_L111[30:0];
	//		hd_H112[30:0]<=hd_L112[30:0];
			hd_H10[31]<=~hd_L10[31];
			hd_H11[31]<=~hd_L11[31];
			hd_H12[31]<=~hd_L12[31];
			hd_H13[31]<=~hd_L13[31];
			hd_H14[31]<=~hd_L14[31];
			hd_H15[31]<=~hd_L15[31];
	//		hd_H1[7][31]<=~hd_L17[31];
	//		hd_H1[8][31]<=~hd_L18[31];
	//		hd_H1[9][31]<=~hd_L19[31];
	//		hd_H1[10][31]<=~hd_L110[31];
	//		hd_H1[11][31]<=~hd_L111[31];
	//		hd_H1[12][31]<=~hd_L112[31];
			hd_H16<=hd_H1_wire;
		end
		fpadd hd_H1_middle(one,hd_L16,hd_H1_wire,control_minus,flags);
		fpadd delta_w(w_c2,w_c1,delta_w_c,control_minus,flags1);
		fpmul hd_pb_middle(delta_w_c, one_over_pi, hd_bp6, control, flags_mult25);
		fpadd hd_bs_middle(one,hd_bp6,hd_bs6,control_minus,flags2);
		

	//always @(choose_filter,clk, f_c1, f_c2) begin
	always @(posedge clk) begin
		if (choose_filter==2'b00) begin
			hd0<=hd_L10;
			hd1<=hd_L11;
			hd2<=hd_L12;
			hd3<=hd_L13;
			hd4<=hd_L14;
			hd5<=hd_L15;
			hd6<=hd_L16;
	//		hd[7]<=hd_L1[7];
	//		hd[8]<=hd_L1[8];
	//		hd[9]<=hd_L1[9];
	//		hd[10]<=hd_L1[10];
	//		hd[11]<=hd_L1[11];
	//		hd[12]<=hd_L1[12];
		end else if (choose_filter==2'b01) begin
			hd0<=hd_H10;
			hd1<=hd_H11;
			hd2<=hd_H12;
			hd3<=hd_H13;
			hd4<=hd_H14;
			hd5<=hd_H15;
			hd6<=hd_H16;
	//		hd[7]<=hd_H17;
	//		hd[8]<=hd_H18;
	//		hd[9]<=hd_H19;
	//		hd[10]<=hd_H110;
	//		hd[11]<=hd_H111;
	//		hd[12]<=hd_H112;
		end else if (choose_filter==2'b10) begin
			hd0<=hd_bp0;
			hd1<=hd_bp1;
			hd2<=hd_bp2;
			hd3<=hd_bp3;
			hd4<=hd_bp4;
			hd5<=hd_bp5;
			hd6<=hd_bp6;
	//		hd[7]<=hd_bp[7];
	//		hd[8]<=hd_bp[8];
	//		hd[9]<=hd_bp[9];
	//		hd[10]<=hd_bp[10];
	//		hd[11]<=hd_bp[11];
	//		hd[12]<=hd_bp[12];
		end else if (choose_filter==2'b11) begin
			hd0<=hd_bs0;
			hd1<=hd_bs1;
			hd2<=hd_bs2;
			hd3<=hd_bs3;
			hd4<=hd_bs4;
			hd5<=hd_bs5;
			hd6<=hd_bs6;
	//		hd[7]<=hd_bs[7];
	//		hd[8]<=hd_bs[8];
	//		hd[9]<=hd_bs[9];
	//		hd[10]<=hd_bs[10];
	//		hd[11]<=hd_bs[11];
	//		hd[12]<=hd_bs[12];
		end
			
			
	end
			
	
	fpadd band_pass_hd0(hd_L20,hd_L10,hd_bp0,control_minus,flags3);
	fpadd band_pass_hd1(hd_L21,hd_L11,hd_bp1,control_minus,flags4);
	fpadd band_pass_hd2(hd_L22,hd_L12,hd_bp2,control_minus,flags5);
	fpadd band_pass_hd3(hd_L23,hd_L13,hd_bp3,control_minus,flags6);
	fpadd band_pass_hd4(hd_L24,hd_L14,hd_bp4,control_minus,flags7);
	fpadd band_pass_hd5(hd_L25,hd_L15,hd_bp5,control_minus,flags8);
//	fpadd band_pass_hd7(hd_L27,hd_L17,hd_bp[7],control_minus,flags);
//	fpadd band_pass_hd8(hd_L28,hd_L18,hd_bp[8],control_minus,flags);
//	fpadd band_pass_hd9(hd_L29,hd_L19,hd_bp[9],control_minus,flags);
//	fpadd band_pass_hd10(hd_L210,hd_L110,hd_bp[10],control_minus,flags);
//	fpadd band_pass_hd11(hd_L211,hd_L111,hd_bp[11],control_minus,flags);
//	fpadd band_pass_hd12(hd_L212,hd_L112,hd_bp[12],control_minus,flags);
	
	fpadd band_stop_hd0(hd_L10,hd_L20,hd_bs0,control_minus,flags9);
	fpadd band_stop_hd1(hd_L11,hd_L21,hd_bs1,control_minus,flags10);
	fpadd band_stop_hd2(hd_L12,hd_L22,hd_bs2,control_minus,flags11);
	fpadd band_stop_hd3(hd_L13,hd_L23,hd_bs3,control_minus,flags12);
	fpadd band_stop_hd4(hd_L14,hd_L24,hd_bs4,control_minus,flags13);
	fpadd band_stop_hd5(hd_L15,hd_L25,hd_bs5,control_minus,flags14);
//	fpadd band_stop_hd7(hd_L17,hd_L27,hd_bs[7],control_minus,flags);
//	fpadd band_stop_hd8(hd_L18,hd_L28,hd_bs[8],control_minus,flags);
//	fpadd band_stop_hd9(hd_L19,hd_L29,hd_bs[9],control_minus,flags);
//	fpadd band_stop_hd10(hd_L110,hd_L210,hd_bs[10],control_minus,flags);
//	fpadd band_stop_hd11(hd_L111,hd_L211,hd_bs[11],control_minus,flags);
//	fpadd band_stop_hd12(hd_L112,hd_L212,hd_bs[12],control_minus,flags);

endmodule
