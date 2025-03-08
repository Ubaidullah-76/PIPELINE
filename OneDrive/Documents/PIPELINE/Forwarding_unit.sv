module Forwarding_unit(
    input logic [31:0] instruction_execute, instruction_wback,
    input logic reg_wr_wback,
    output logic fwd_A, fwd_B
);
    logic [4:0] rs1_execute, rs2_execute, rd_wback;
    logic [6:0] opcode_execute, opcode_wback;
    
    assign rs1_execute = instruction_execute[19:15];
    assign rs2_execute = instruction_execute[24:20];
    assign rd_wback = instruction_wback[11:7];
    assign opcode_execute = instruction_execute[6:0];
    assign opcode_wback = instruction_wback[6:0];
	always_comb begin
        if (reg_wr_wback && (opcode_wback != 7'b0100011) && (opcode_wback != 7'b1100011)) begin
            if (rs1_execute == rd_wback && (opcode_execute != 7'b0110111) && (opcode_execute != 7'b1101111))
                fwd_A = 1'b1;
            else
                fwd_A = 1'b0;
			if (rs2_execute == rd_wback && (opcode_execute != 7'b0110111) && (opcode_execute != 7'b1101111) && (opcode_execute != 7'b0010011) && (opcode_execute != 7'b0000011))
                fwd_B = 1'b1;
            else
                fwd_B = 1'b0;
        end else begin
            fwd_A = 1'b0;
            fwd_B = 1'b0;
        end
    end
endmodule
