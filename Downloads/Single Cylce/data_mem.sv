module data_mem(
	input logic clk, wr_en, rd_en,
	input logic [31:0] addr, wdata,
	output logic [31:0] rdata
);
	
	logic [31:0] memory [0:1023];
	
	always_ff @(negedge clk) begin
		if (wr_en)
			memory[addr] <= wdata;
	end

	assign rdata = (rd_en) ? memory[addr] : 32'b0;

endmodule