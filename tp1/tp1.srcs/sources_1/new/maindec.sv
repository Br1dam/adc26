module maindec (input logic[10:0] Op,
					output logic Reg2Loc,
										ALUSrc,
										MemtoReg,
										RegWrite,
										MemRead,
										MemWrite,
										Branch,
										CondBr,
					output logic[1:0] ALUOp
);
	always_comb
			casez(Op)
				11'b111_1100_0010: //LDUR
					{Reg2Loc, ALUSrc, MemtoReg, RegWrite, 
						MemRead, MemWrite, Branch, ALUOp, CondBr} = 10'b_0_1_1_1_1_0_0_00_0;
				11'b111_1100_0000: //STUR
					{Reg2Loc, ALUSrc, MemtoReg, RegWrite, 
						MemRead, MemWrite, Branch, ALUOp, CondBr} = 10'b_1_1_0_0_0_1_0_00_0;
				11'b101_1010_0???: //CBZ
					{Reg2Loc, ALUSrc, MemtoReg, RegWrite, 
						MemRead, MemWrite, Branch, ALUOp, CondBr} = 10'b_1_0_0_0_0_0_1_01_0;
				11'b010_1010_0???: //B.cond
				{Reg2Loc, ALUSrc, MemtoReg, RegWrite, 
						MemRead, MemWrite, Branch, ALUOp, CondBr} = 10'b_1_0_0_0_0_0_0_01_1;
				11'b100_0101_1000: //ADD
					{Reg2Loc, ALUSrc, MemtoReg, RegWrite, 
						MemRead, MemWrite, Branch, ALUOp, CondBr} = 10'b_0_0_0_1_0_0_0_10_0;
				11'b110_0101_1000: //SUB
					{Reg2Loc, ALUSrc, MemtoReg, RegWrite, 
						MemRead, MemWrite, Branch, ALUOp, CondBr} = 10'b_0_0_0_1_0_0_0_10_0;	
				11'b101_0101_1000: //ADDS
					{Reg2Loc, ALUSrc, MemtoReg, RegWrite, 
						MemRead, MemWrite, Branch, ALUOp, CondBr} = 10'b_0_0_0_1_0_0_0_10_0;
				11'b111_0101_1000: //SUBS
					{Reg2Loc, ALUSrc, MemtoReg, RegWrite, 
						MemRead, MemWrite, Branch, ALUOp, CondBr} = 10'b_0_0_0_1_0_0_0_10_0;			
				11'b100_0101_0000: //AND
					{Reg2Loc, ALUSrc, MemtoReg, RegWrite, 
						MemRead, MemWrite, Branch, ALUOp, CondBr} = 10'b_0_0_0_1_0_0_0_10_0;
				11'b101_0101_0000: //ORR
					{Reg2Loc, ALUSrc, MemtoReg, RegWrite, 
						MemRead, MemWrite, Branch, ALUOp, CondBr} = 10'b_0_0_0_1_0_0_0_10_0;
				11'b100_1000_100?: //ADDI
				{Reg2Loc, ALUSrc, MemtoReg, RegWrite, 
						MemRead, MemWrite, Branch, ALUOp, CondBr} = 10'b_0_1_0_1_0_0_0_11_0;
				11'b110_1000_100?: //SUBI
				{Reg2Loc, ALUSrc, MemtoReg, RegWrite, 
						MemRead, MemWrite, Branch, ALUOp, CondBr} = 10'b_0_1_0_1_0_0_0_11_0;
				11'b101_1000_100?: //ADDIS
				{Reg2Loc, ALUSrc, MemtoReg, RegWrite, 
						MemRead, MemWrite, Branch, ALUOp, CondBr} = 10'b_0_1_0_1_0_0_0_11_0;
				11'b111_1000_100?: //SUBIS
				{Reg2Loc, ALUSrc, MemtoReg, RegWrite, 
						MemRead, MemWrite, Branch, ALUOp, CondBr} = 10'b_0_1_0_1_0_0_0_11_0;
						
				default: 
					{Reg2Loc, ALUSrc, MemtoReg, RegWrite, 
						MemRead, MemWrite, Branch, ALUOp, CondBr} = 10'b0;
			endcase		

endmodule