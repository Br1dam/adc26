module fetch #(parameter N = 64) (input logic PCSrc_F,
									clk,
									reset,
	input logic[N-1:0] PCBranch_F,
	output logic[N-1:0] imem_addr_F,
	//--
	input logic dataHazard
);
	logic[N-1:0] mux_out,add_out;

	mux2 mplex(add_out,PCBranch_F,PCSrc_F,mux_out);
	
	                      //Evitar que el PC avance a la siguiente instrucción 
	flopr_e pc(clk,reset,~dataHazard,mux_out,imem_addr_F);
	
	adder add(64'd4,imem_addr_F,add_out);

endmodule