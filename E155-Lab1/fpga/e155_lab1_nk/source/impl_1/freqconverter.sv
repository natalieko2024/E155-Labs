// Natalie Ko (nko@g.hmc.edu)
// Created on 2 Sept 2026
// The module freq_converter converts the 24MHz signal provided by the iCE40 High-Speed OSCilator (HSOSC) to a 2.4Hz signal using a counter. The output value (associated with LED on/off) oscillates according to this frequency.
module freqconverter #(parameter WIDTH = 23, MAX = 5000000)( input logic clk,
															  input logic reset,
															  input logic enable,
															  output logic led2);

	// Initialize a counter starting at 0
	// Using 23 bits because 0.5*10^7 can be stored in 24 bits
	logic [WIDTH-1:0] counter = 0;
	// Maximum value to count up to is 0.5*10^7, not 10^7 because one clock cycle is both the rise and fall
	logic [WIDTH-1:0] max_count;
	assign max_count = MAX;
	
	// Counter logic
	// Add 1 bit to counter at each 24MHz clock cycle 
	// Reset counter to 0 with the button press (reset = 0) and when counter reaches the max value
	// Reset the output led2 with the button press (reset = 0). Invert it when it reaches max count (so each blink lasts the whole time).
	// Only run the counter logic when enable is high, otherwise keep the current values
	always_ff @(posedge clk) begin
		if (~reset) begin
			counter <= 0;
			led2 <= 0;
		end
		else if ((counter > (max_count-1)) && enable) begin
			counter <= 0;
			led2 <= ~led2;
		end
		else if (enable) begin
			counter <= counter + 1'b1;
			led2 <= led2;
		end
		else begin
			counter <= counter;
			led2 <= led2;
		end
	end
	
endmodule