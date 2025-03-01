module datapath(
    input logic clk, reset
);
//PC
    logic [31:0] pc, next_pc ;
//immediate   
    logic [31:0] extended_imm;
//instruction memory    
    logic [31:0]  instruction;
//register file
    logic [31:0]  rdata1, rdata2,  wdata;
    logic [4:0] rs1, rs2, rd;
    logic [6:0] opcode;
//ALU
    logic [31:0]  alu_result;
    logic [3:0] alu_ctrl;
//data mem
    logic [31:0]  rdata;
//branch
    logic [2:0] br_type;
//control unit 
    logic [1:0] wb_sel;
    logic reg_wr, rd_en, wr_en, br_taken, sel_A, sel_B;

    // Instantiate modules
    pc pc_0 (clk, reset, br_taken ? alu_result : next_pc, pc);
    inst_mem inst_mem_0 (pc, instruction);
    register_file reg_file_0 (clk, reg_wr, rs1, rs2, rd, wdata, rdata1, rdata2);
    alu alu_0 (alu_ctrl, sel_A ? rdata1 : pc, sel_B ? extended_imm : rdata2, alu_result);
    data_mem data_mem_0 (clk, wr_en, rd_en, alu_result, rdata2, rdata);
    branch_cond branch_cond_0 (br_type, rdata1, rdata2, br_taken);
    control_unit control_unit_0 (instruction, reg_wr, rd_en, wr_en, sel_A, sel_B, wb_sel, alu_ctrl, br_type);
    imd_generator imd_generator_0 (instruction, extended_imm);

    // Assignments
    assign opcode = instruction[6:0];
    assign rs1 = instruction[19:15];
    assign rs2 = instruction[24:20];
    assign rd = instruction[11:7];
    assign next_pc = br_taken ? alu_result : pc + 4;

    always_comb begin
         case (wb_sel)
            2'b00: wdata = pc + 4;
            2'b01: wdata = alu_result;
            2'b10: wdata = rdata;
        endcase
    end

endmodule
