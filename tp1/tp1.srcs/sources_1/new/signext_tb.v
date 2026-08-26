module signext_tb();
	
	logic [31:0] a;
	logic [63:0] y;
	
	signext dut(a, y);
	
	initial 
		begin
			a = 32'b111_1100_0010_000101111_00_00001_00010; #10;
			if (y !== 64'h2f) $display("LDUR failed.");
			else $display("LDUR passed.");
			a = 32'b111_1100_0000_100101101_00_00001_00010; #10;
			if (y !== 64'hffff_ffff_ffff_ff2d) $display("SDUR failed.");
			else $display("STUR passed.");
			a = 32'b101_1010_0000_1001_0110_1000_0001_00001; #10;
			if (y !== 64'h9681) $display("CBZ failed.");
			else $display("CBZ passed.");
			a = 32'b1001_0001_0000_0000_0011_1000_0010_0001; #10
			if(y != 64'he) $display("ADDI failed");
			else $display("ADDI passed");
			
			a = 32'h54000121; #10
			if(y != 64'h9) $display("Bcond failed");
			else $display("Bcond passed");
			
			a = 32'b001_1010_0001_0111_1111_1111_1111_11111; #10;
			if (y !== 64'b0) $display("Other case failed.");
			else $display("Other case passed.");
		end


endmodule