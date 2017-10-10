module miniproject(
	input [3:0]KEY, // KEY[i] refers to ith key
	input [3:0]SW,
	input CLOCK_50,
	output			[7:0]LEDR,
	output			VGA_CLK,   				//	VGA Clock
	output			VGA_HS,					//	VGA H_SYNC
	output			VGA_VS,					//	VGA V_SYNC
	output			VGA_BLANK,				//	VGA BLANK
	output			VGA_SYNC,				//	VGA SYNC
	output [9:0]	VGA_R,   				//	VGA Red[9:0]
	output [9:0]	VGA_G,	 				//	VGA Green[9:0]
	output [9:0]	VGA_B	   				//	VGA Blue[9:0]
	);
	
	wire timer;
	
	timer timertenth( //tenth second timer
		.timer	(timer),
		.clk		(CLOCK_50)
	);
	
	wire [7:0] sX;
	wire [7:0] sY;
	wire sDraw_en;
	wire [2:0] sColour;
	
	
	
	stateMachine state(.clk (timer),
							.colour (sColour),
							.draw_en (sDraw_en),
							.x (sX),
							.y (sY),
							.led (LEDR[7:0]),
							.key (KEY)
							);

	vga_adapter VGA(
		.resetn		(SW[3]),
		.clock		(CLOCK_50),
		.colour		(sColour),
		.x				(sX),
		.y				(sY),
		.plot			(1'b1),
		/* Signals for the DAC to drive the monitor. */
		.VGA_R		(VGA_R),
		.VGA_G		(VGA_G),
		.VGA_B		(VGA_B),
		.VGA_HS		(VGA_HS),
		.VGA_VS		(VGA_VS),
		.VGA_BLANK	(VGA_BLANK),
		.VGA_SYNC	(VGA_SYNC),
		.VGA_CLK		(VGA_CLK)
	);
	
	defparam VGA.RESOLUTION = "160x120";
	defparam VGA.MONOCHROME = "FALSE";
	defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
	// defparam VGA.BACKGROUND_IMAGE = "background_image.mif";

endmodule