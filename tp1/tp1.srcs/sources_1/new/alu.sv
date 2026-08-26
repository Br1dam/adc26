module alu #(parameter N = 64) (
    input logic [N-1:0] a, b,
    input logic [3:0] ALUControl,
    output logic [N-1:0] result,
    output logic zero, Negative, Carry, oVerflow, write_flag
);
    logic [N-1:0] b_neg;
 
    always_comb begin
        b_neg = ~b + 1;
        // Valores por defecto para evitar latches
        oVerflow = '0;
		  Carry ='0;
        write_flag = ALUControl[3];
        casez(ALUControl)
            4'b0000: result = a & b;                   
            4'b0001: result = a | b;                   
            4'b0010, 4'b1010:                    
                {Carry, result} = a + b;
            4'b0110, 4'b1110:                   
                {Carry, result} = a + b_neg;
            4'b0111: result = b;                       
            default: result = '0;                      
        endcase

        // Cálculo de las banderas
		  oVerflow = (~(a[N-1] ^ b[N-1] ^ ALUControl[2])) 
									&& (result[N-1] ^ a[N-1] && ALUControl[1]);
        zero = (result == '0);
        Negative = result[N-1];
    end


endmodule