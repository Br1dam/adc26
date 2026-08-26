module maindec_tb();

	logic [10:0] Op;
	logic Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch;
	logic [1:0] ALUOp;
	
	logic [8:0] bus;

	assign bus = { Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp};
	
	maindec dut(Op, Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite,
					Branch, ALUOp);

	initial
		begin
			#10;
			Op = 11'b111_1100_0010; #10;
			if(bus !== 9'b011110000) $display("LDUR failed.");
			else $display("LDUR passed.");
			
			Op = 11'b111_1100_0000; #10;
			if(bus !== 9'b110001000) $display("STUR failed.");
			else $display("STUR passed.");
			
			Op = 11'b101_1010_0101; #10;
			if(bus !== 9'b100000101) $display("CBZ failed.");
			else $display("CBZ passed.");
			
			Op = 11'b100_0101_1000; #10;
			if(bus !== 9'b000100010) $display("ADD failed.");
			else $display("ADD passed.");
			
			Op = 11'b110_0101_1000; #10;
			if(bus !== 9'b000100010) $display("SUB failed.");
			else $display("SUB passed.");
			
			Op = 11'b100_0101_0000; #10;
			if(bus !== 9'b000100010) $display("AND failed.");
			else $display("AND passed.");
			
			Op = 11'b101_0101_0000; #10;
			if(bus !== 9'b000100010) $display("ORR failed.");
			else $display("ORR passed.");
			
			Op = 11'b100_1000_1000;#10
			if(bus !== 9'b010100000) $display("ADDI failed.");
			else $display("ADDI passed.");
			
			Op = 11'b111_0101_1111; #10;
			if(bus !== 9'b000000000) $display("default failed.");
			else $display("default passed.");
			
		end
	
	
endmodule