module register_file(
    input logic clk, reg_write,
    input logic [4:0] rs1, rs2, rd, 
    input logic [31:0] wdata,
    output logic [31:0] rdata1, rdata2
);

    logic [31:0] registers [0:31];

    always_ff @(posedge clk) begin
        if (reg_write && rd != 5'd0)
            registers[rd] <= wdata;
    end

    assign rdata1 = registers[rs1];
    assign rdata2 = registers[rs2];

endmodule
