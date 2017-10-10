module boardState ( input [7:0] indexX,
						  input [7:0] indexY,
						  input data,
						  input wr_en,
						  input rd_en,
						  input clk,
						  output reg out );
		
		reg board [159:0][119:0];	
			
		integer i; integer j;
		initial begin
			for (i = 0; i <= 159; i = i + 1) begin
				for (j = 0; j <= 119; j = j + 1) begin
					board[i][j] = 0;
				end
			end
		end
						  
		always @(posedge clk) begin
			if (wr_en == 1) board[indexX][indexY] <= data;
			if (rd_en == 1) out <= board[indexX][indexY];
		end
						  
endmodule