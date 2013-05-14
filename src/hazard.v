module hazard
(
	input [4:0] rsD, rtD, rsE, rtE,
	input memtoregE, memtoregM,
	input regwriteE, regwriteM, regwriteW,
	input [4:0] writeregE, writeregM, writeregW,
	input branchD,
	output stallF, stallD, 
	output reg forwardAD, forwardBD,
	output reg [1:0] forwardAE, forwardBE,
	output flushE
);

	wire lwstallD, branchstallD;

	// forwarding sources to E stage (ALU)
	always @(*)
		begin						
			if ((rsE != 0) & (rsE == writeregM) & regwriteM) forwardAE = 2'b10;
			else if ((rsE != 0) & (rsE == writeregW) & regwriteW) forwardAE = 2'b01;
			else forwardAE = 2'b00;

			if ((rtE != 0) & (rtE == writeregM) & regwriteM) forwardBE = 2'b10;
			else if ((rtE != 0) & (rtE == writeregW) & regwriteW) forwardBE = 2'b01;
			else forwardBE = 2'b00;
                        
                        if (rsD != 0 & rsD == writeregM & regwriteM) forwardAD = 1;
                        else forwardAD = 0;

                        if (rtD != 0 & rtD == writeregM & regwriteM) forwardBD = 1;
                        else forwardBD = 0;
		end

	//lw
	assign lwstallD = (rsD == rtE | rtD == rtE) & memtoregE;

	//predecide if beq's R[rs] equals R[rt]
	assign branchstallD = branchD & (((rsD == writeregE | rtD == writeregE) & regwriteE) | ((rsD == writeregM | rtD == writeregM) & memtoregM)); 

	assign flushE = lwstallD | branchstallD;  //flush current pipeline
	assign stallD = flushE; //pause previous pipeline

	assign stallF = flushE; //pause previous pipeline

endmodule
