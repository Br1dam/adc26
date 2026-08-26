module alu_tb();
    logic clk, reset;
    logic [31:0] vectornum, errors; 
    logic [63:0] a, b;
    logic [3:0] ALUControl;
    logic [63:0] result, expected_result;
    logic zero, expected_zero, negative , expected_negative, Carry, expec_carry, oVerflow, expec_overflow, write_flag, expec_writeflag;
    logic[200:0] inputs_and_expected_outputs [6:0];

    initial begin									//a    ,   b     ,   aluctrl, res   ,  Z  ,  N   , C  , V,     write flags      
        inputs_and_expected_outputs[0] = {64'd0  , 64'd0   , 4'b1010, 64'd0   , 1'b1, 1'b0, 1'b0, 1'b0, 1'b1}; // esta no se testea (?)
        inputs_and_expected_outputs[1] = {64'd0  , 64'd0   , 4'b1110, 64'd0   , 1'b1, 1'b0, 1'b0, 1'b0, 1'b1};
        inputs_and_expected_outputs[2] = {64'd1  , 64'd3   , 4'b1010, 64'd4   , 1'b0, 1'b0, 1'b0, 1'b0, 1'b1};
inputs_and_expected_outputs[3]={64'hFFFF_FFFF_FFFF_FFFF, 64'd1,4'b1010,64'd0,   1'b1, 1'b0, 1'b1, 1'b0,1'b1}; //debe activar carry pero no overflow
																																		//z   n   c     v     w
inputs_and_expected_outputs[4]={64'h7FFF_FFFF_FFFF_FFFF, 64'd1,4'b0010,64'h0x8000_0000_0000_0000,   1'b0, 1'b1, 1'b0, 1'b1,1'b0};//debe activar overflow pero no carry
//da un negativo en lugar de un positivo

inputs_and_expected_outputs[5] = {64'h8000_0000_0000_0000, 64'd1, 4'b1110, 64'h7FFF_FFFF_FFFF_FFFF, 1'b0, 1'b0, 1'b1, 1'b1, 1'b1}; // Resta: -2^63 - 1

inputs_and_expected_outputs[6] = {64'h7FFF_FFFF_FFFF_FFFF, 64'd1, 4'b1010, 64'h8000_0000_0000_0000, 1'b0, 1'b1, 1'b0, 1'b1, 1'b1}; // casi igual a 4 pero setea flags

    end

    alu dut(a, b, ALUControl, result, zero, negative, Carry, oVerflow, write_flag);

    always begin
        clk = 1; #10ns;
        clk = 0; #10ns;
    end

    initial begin 
        vectornum = 0;
        errors = 0;
        reset = 1;
        #27ns;
        reset = 0;
    end

    always @(posedge clk) begin
        #1; {a, b, ALUControl, expected_result, expected_zero, expected_negative, expec_carry, expec_overflow, expec_writeflag} 
            = inputs_and_expected_outputs[vectornum];
    end
    always @(negedge clk) begin
        if (~reset) begin
				$display("Vectornum: %d",{vectornum});
            if (result !== expected_result) begin
                $display("Error result: inputs = %d", {result});
                $display("outputs = %d (%d expected)", result, expected_result);
                errors = errors + 1;
            end
            if (zero !== expected_zero) begin
                $display("Error zero: inputs = %b", {zero});
                $display("outputs = %b (%b expected)", zero, expected_zero);
                errors = errors + 1;
            end
            if (Carry !== expec_carry) begin
                $display("Error carry: inputs = %b", {Carry});
                $display("outputs = %b (%b expected)", Carry, expec_carry);
                errors = errors + 1;
            end
            if (negative !== expected_negative) begin
                $display("Error negative: inputs = %b", {negative});
                $display("outputs = %b (%b expected)", negative, expected_negative);
                errors = errors + 1;
            end
            if (oVerflow !== expec_overflow) begin
                $display("Error overflow: inputs = %b", {oVerflow});
                $display("outputs = %b (%b expected)", oVerflow, expec_overflow);
                errors = errors + 1;
            end
            if (write_flag !== expec_writeflag) begin
                $display("Error write_flag: inputs = %b", {write_flag});
                $display("outputs = %b (%b expected)", write_flag, expec_writeflag);
                errors = errors + 1;
            end
        end
    end

    always @(negedge clk) begin
		vectornum = vectornum + 1;
        if (inputs_and_expected_outputs[vectornum] === 201'bx) begin
            $display("%d tests completed with %d errors", vectornum, errors);
            $stop;
        end 
    end
endmodule