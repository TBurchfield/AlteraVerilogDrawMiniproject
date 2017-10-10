module timer (
	input clk,
	output reg timer );
	
	reg [26:0] count;
	
	initial begin
		count = 0;
		timer = 0;
	end
	
	always @(posedge clk) begin
	
		count <= count + 1;
		
		if (count == 250000) begin
			count <= 0;
			timer <= ~timer;
		end
			
	end

endmodule