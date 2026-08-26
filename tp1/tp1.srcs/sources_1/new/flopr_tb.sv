module flopr_tb();

	logic clk, reset;
	logic [63:0] d, qexpected;
	logic [63:0] q;
	
	logic [63:0] vectornum, errors;
	
	logic [127:0] test_vectors [0:9] = '{ {64'd1, 64'd0},
													{64'd2, 64'd0},
													{64'd3, 64'd0},
													{64'd4, 64'd0},
													{64'd5, 64'd0},
													{64'd6, 64'd6},
													{64'd7, 64'd7},
													{64'd8, 64'd8},
													{64'd9, 64'd9},
													{64'd10, 64'd10}};
	flopr #(64) dut(clk, reset, d, q);
	
	always 
		begin 
			clk = 1; #5; clk = 0; #5;
		end
	
	initial
		begin
			vectornum = 0; errors = 0; reset = 1; #3;
		end
	
	always @(negedge clk)
		begin
			d = test_vectors[vectornum][127:64];
			qexpected = test_vectors[vectornum][63:0]; #2;
			if(vectornum >= 5) reset = 0;
			else reset = 1;
		end
	
	always @(posedge clk)
		begin
			if(~$isunknown(qexpected))
				begin
					#2;
					if(q !== qexpected)
						begin
							$display("Error: input = %h", d);
							$display("outputs = %h (%h expected)", q, qexpected);
							errors = errors + 1;
						end
					vectornum = vectornum + 1;
					if (test_vectors[vectornum] === 128'bx)
						begin
							$display("%d tests completed with %d errors", vectornum, errors);
							$finish;
						end
				end
		end
endmodule 