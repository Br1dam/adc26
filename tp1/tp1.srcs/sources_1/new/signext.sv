module signext(input logic[31:0] a, output logic[63:0] y);
		always_comb begin
					casez(a[31:21])
						11'b111_1100_0010, //LDUR
						11'b111_1100_0000: // STUR  formato D: dt_addr 12 al 20 (9 bits)
								y = {{55{a[20]}},{a[20:12]}};
				
						11'b101_1010_0???,// CBZ  //formato CB: cond_br_addr 23 al 5 (19 bits)
						11'b010_1010_0???: //B.cond
								y = {{45{a[23]}}, a[23:5]};
						
						11'b100_1000_100?, //ADDI //formato I: ALU_imm 21 al 10 (12 bits)
						11'b110_1000_100?, //SUBI //formato I: ALU_imm 21 al 10 (12 bits)
						11'b101_1000_100?, //ADDIS //formato I: ALU_imm 21 al 10 (12 bits)
						11'b111_1000_100?: //SUBIS //formato I: ALU_imm 21 al 10 (12 bits)
						
								y = {52'b0, a[21:10]};								
							
						default: y = 64'b0;
			endcase
		end
endmodule