// Natalie Ko (nko@g.hmc.edu)
// Created on 2 Sept 2026
// The module oscillator converts the 24MHz signal provided by the iCE40 High-Speed OSCilator (HSOSC) to a 2.4Hz signal using a counter. The output value (associated with LED on/off) oscillates according to this frequency.
module oscillator( input logic clk,
				   input logic reset,
				   output logic led2);

	// Using 23 bits because 0.5*10^7 can be stored in 24 bits
	logic [22:0] counter = 23'b0;
	// Maximum value is 0.5*10^7, not 10^7 because one clock cycle is both the rise and fall
	logic [22:0] max_count;
	assign max_count = 5000000;
	
	// Counter logic
	// Add 1 bit to counter at each 24MHz clock cycle 
	// Reset counter to 0 with the button press (reset = 0) and when counter reaches the max value
	// Reset led2 with the button press (reset = 0). Invert it when it reaches max count (so each blink lasts the whole time). Push current value in the else to avoid latch.
	always_ff @(posedge clk) begin
		if (~reset) begin
			counter <= 0;
			led2 <= 0;
		end
		else if (counter > max_count) begin
			counter <= 0;
			led2 <= ~led2;
		end
		else begin
			counter <= counter + 1'b1;
			led2 <= led2;
		end
	end
	
endmodule