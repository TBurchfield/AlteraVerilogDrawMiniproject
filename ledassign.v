module ledassign (
	input clk,
	input [2:0]switches,
	output reg [2:0]leds);
	
	always @(posedge clk) begin
			leds = ~switches;
	end

endmodule