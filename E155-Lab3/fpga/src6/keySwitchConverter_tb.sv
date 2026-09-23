// Defining the delays in terms of ns with a precision of 1ns
`timescale 1 ns/1 ns

// Natalie Ko (nko@g.hmc.edu)
// Created on 18 Sept 2026
// Test all combinational logic of keySwitchConverter
module keySwitchConverter_tb();

    logic [15:0] map;
    logic [3:0] switches;

    keySwitchConverter dut(map, switches);

    initial begin
        map = 16'b1000000000000000;
		#1
        assert (switches == 4'b0001)
			$display("PASS switches are correct for corresponding map");
		else
			$display("FAIL switches are incorrect for corresponding map");
		#1
        map = 16'b0100000000000000;
		#1
        assert (switches == 4'b0010)
			$display("PASS switches are correct for corresponding map");
		else
			$display("FAIL switches are incorrect for corresponding map");
		#1
        map = 16'b0010000000000000;
		#1
        assert (switches == 4'b0011)
			$display("PASS switches are correct for corresponding map");
		else
			$display("FAIL switches are incorrect for corresponding map");
		#1
        map = 16'b0001000000000000;
		#1
        assert (switches == 4'b1010)
			$display("PASS switches are correct for corresponding map");
		else
			$display("FAIL switches are incorrect for corresponding map");
		#1
        map = 16'b0000100000000000;
		#1
        assert (switches == 4'b0100)
			$display("PASS switches are correct for corresponding map");
		else
			$display("FAIL switches are incorrect for corresponding map");
		#1
        map = 16'b0000010000000000;
		#1
        assert (switches == 4'b0101)
			$display("PASS switches are correct for corresponding map");
		else
			$display("FAIL switches are incorrect for corresponding map");
		#1
        map = 16'b0000001000000000;
		#1
        assert (switches == 4'b0110)
			$display("PASS switches are correct for corresponding map");
		else
			$display("FAIL switches are incorrect for corresponding map");
		#1
        map = 16'b0000000100000000;
		#1
        assert (switches == 4'b1011)
			$display("PASS switches are correct for corresponding map");
		else
			$display("FAIL switches are incorrect for corresponding map");
		#1
        map = 16'b0000000010000000;
		#1
        assert (switches == 4'b0111)
			$display("PASS switches are correct for corresponding map");
		else
			$display("FAIL switches are incorrect for corresponding map");
		#1
        map = 16'b0000000001000000;
		#1
        assert (switches == 4'b1000)
			$display("PASS switches are correct for corresponding map");
		else
			$display("FAIL switches are incorrect for corresponding map");
		#1
        map = 16'b0000000000100000;
		#1
        assert (switches == 4'b1001)
			$display("PASS switches are correct for corresponding map");
		else
			$display("FAIL switches are incorrect for corresponding map");
		#1
        map = 16'b0000000000010000;
		#1
        assert (switches == 4'b1100)
			$display("PASS switches are correct for corresponding map");
		else
			$display("FAIL switches are incorrect for corresponding map");
		#1
        map = 16'b0000000000001000;
		#1
        assert (switches == 4'b1110)
			$display("PASS switches are correct for corresponding map");
		else
			$display("FAIL switches are incorrect for corresponding map");
		#1
        map = 16'b0000000000000100;
		#1
        assert (switches == 4'b0000)
			$display("PASS switches are correct for corresponding map");
		else
			$display("FAIL switches are incorrect for corresponding map");
		#1
        map = 16'b0000000000000010;
		#1
        assert (switches == 4'b1111)
			$display("PASS switches are correct for corresponding map");
		else
			$display("FAIL switches are incorrect for corresponding map");
		#1
        map = 16'b0000000000000001;
		#1
        assert (switches == 4'b1101)
			$display("PASS switches are correct for corresponding map");
		else
			$display("FAIL switches are incorrect for corresponding map");
		#1 $stop;
		map = 16'b0100100100000001;
		#1
        assert (switches == 4'b0000)
			$display("PASS switches are correct for corresponding map");
		else
			$display("FAIL switches are incorrect for corresponding map");
		#1 $stop;
    end

endmodule