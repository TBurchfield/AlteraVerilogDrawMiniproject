module miniproject(
	input [3:0]KEY, // KEY[i] refers to ith key
	input [3:0]SW,
	input CLOCK_50,
	output			[2:0]LEDR,
	output			VGA_CLK,   				//	VGA Clock
	output			VGA_HS,					//	VGA H_SYNC
	output			VGA_VS,					//	VGA V_SYNC
	output			VGA_BLANK,				//	VGA BLANK
	output			VGA_SYNC,				//	VGA SYNC
	output [9:0]	VGA_R,   				//	VGA Red[9:0]
	output [9:0]	VGA_G,	 				//	VGA Green[9:0]
	output [9:0]	VGA_B	   				//	VGA Blue[9:0]
	);
	reg [7:0]x; //TODO: check what values each corner correspond to
	reg [7:0]y;
	wire timer;
	
	
	initial begin
		x = 0;
		y = 0;
	end
	
	
	timer timertenth( //tenth second timer
		.timer	(timer),
		.clk		(CLOCK_50)
	);
	
	ledassign ledassign1(
		.clk		(CLOCK_50),
		.leds		(LEDR[2:0]),
		.switches	(SW[2:0])
	);
	
	whereiam holdsxy(
		.directions	(KEY),
		.timer		(timer),
		.x				(x),
		.y				(y)
	);

	vga_adapter VGA(
		.resetn		(SW[3]),
		.clock		(CLOCK_50),
		.colour		(SW[2:0]),
		.x				(x),
		.y				(y),
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