module whereiam(
	input [3:0] directions,
	input timer,
	output reg [7:0] x,
	output reg [7:0] y);
	
	initial begin
		x = 8'd80;
		y = 8'd80;
	end
		
	always @(posedge timer) begin
	
		if (~directions[0]) x <= x + 1; 
		if (~directions[3]) x <= x - 1; 
		if (~directions[2]) y <= y + 1; 
		if (~directions[1]) y <= y - 1; 
	
	end
		
endmodule