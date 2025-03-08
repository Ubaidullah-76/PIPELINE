module data_memory (
    input logic clk_i, write_enable, read_enable,
    input logic [31:0] address, write_data,
    output logic [31:0] read_data
);
    
    logic [31:0] memory[1023:0];
    
    always_ff @(negedge clk_i) begin
        if (write_enable)
            memory[address] <= write_data;
    end

    assign read_data = (read_enable) ? memory[address] : 32'b0;

endmodule
