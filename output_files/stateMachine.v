module stateMachine (input clk,
							output reg [2:0] colour,
							output reg draw_en,
							output reg [7:0] x,
							output reg [7:0] y,
							output [7:0] led,
							input [3:0] key
							);
							
	reg [3:0] state;
	reg [3:0] returnState;
	
	reg [1:0] redDirection;
	reg [1:0] blueDirection;
	reg [7:0] redPosX;
	reg [7:0] redPosY;
	reg [7:0] bluePosX;
	reg [7:0] bluePosY;
	
	reg board [159:0][119:0];	
		
	integer i; integer j;
	initial begin
//		for (i = 0; i <= 159; i = i + 1) begin
//			for (j = 0; j <= 119; j = j + 1) begin
//				board[i][j] = 0;
//			end
//		end

		state = 0;
		redDirection = 3;
		redPosX = 10;
		redPosY = 50;
		
		blueDirection = 3;
		bluePosX = 70;
		bluePosY = 50;
	end
	
	assign led = state;
	
	always @(posedge clk) begin
		blueDirection <= key[3:2];
		redDirection <= key[1:0];
	end
	
	always @(posedge clk) begin
		case (state)
			0: begin
				board[bluePosX][bluePosY] <= 1;
				state <= 10;
				end
			10: begin
				bluePosX <= bluePosX + 1;//blueDirection[0];
				bluePosY <= bluePosY + 1;//blueDirection[1];
				x <= bluePosX;
				y <= bluePosY;
				colour <= 3'b001;
				state <= 5;
				returnState <= 1;
				end
			1: begin
					if (board[bluePosX][bluePosY] == 1)
						state <= 4;
					else 
						state <= 2;
				end
			2: begin
				board[redPosX][redPosY] = 1;
				state <= 12;
				end
			12: begin
				redPosX <= redPosX + redDirection[0];
				redPosY <= redPosY + redDirection[1];
				x = redPosX;
				y = redPosY;
				colour <= 3'b100;
				state <= 5;
				returnState <= 3;
			end
			3: begin
					if (board[redPosX][redPosY] == 1)
						state <= 7;
					else 
						state <= 0;
				end
			4: state <= 4;
			5: begin
				draw_en <= 1;
				state <= 6;
			end
			6: begin
				draw_en <= 0;
				state <= returnState;
			end
			7: state <= 7;
			default:
				state <= 7;
		endcase
	end
//		
//		always @(posedge clk) begin 
//			case (state)
//				0: begin
//					x <= x + 1;
//					y <= y + 1;
//					returnState <= 0;
//					state <= 5;
//					colour <= 3'b111;
//				end 
//				5: begin
//					draw_en <= 1;
//					state <= 6;
//				end
//				6: begin
//					draw_en <= 0;
//					state <= returnState;
//				end
//			endcase
//		end
//		

							
endmodule