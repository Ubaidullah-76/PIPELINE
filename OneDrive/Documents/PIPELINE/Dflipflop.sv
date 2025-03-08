module Dflipflop(
	input logic clk, reset, [31:0] in,
	output logic [31:0] out
);

always_ff @ (posedge clk)
begin
	if (reset)
		out <= 32'b0;
	else
		out <= in;
end
endmodule