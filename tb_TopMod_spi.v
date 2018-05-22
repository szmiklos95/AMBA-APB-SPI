`timescale 1ns / 1ps

//USE tb_topmod.wcfg + 70us simulation time

module tb_TopMod_spi;

	// Inputs
	reg clk;
	reg nrst;
	reg send;
	reg [15:0] data_in;
	reg MISO;

	// Outputs
	wire [15:0] data_out;
	wire done;
	wire MOSI;
	wire SCLK;
	wire SS;

	// Instantiate the Unit Under Test (UUT)
	TopMod_spi uut (
		.clk(clk), 
		.nrst(nrst), 
		.send(send), 
		.data_in(data_in), 
		.data_out(data_out), 
		.done(done), 
		.MISO(MISO), 
		.MOSI(MOSI), 
		.SCLK(SCLK), 
		.SS(SS)
	);

	initial
	begin
		// Initialize Inputs
		clk = 0;
		nrst = 1;
		send = 0;
		data_in = 0;
		MISO = 0;
	end
	
	//First transaction
	initial
	begin
		// Wait 100 ns for global reset to finish
		#100;        
		// Add stimulus here
		#100 nrst <= 0;
		#100 nrst <= 1;
		#650 send <= 1;
		#100 send <= 0;
		#100 data_in <= 16'haa33;
		#100 data_in <= 0;
	end
	//received data 0xaaaa
	initial
	begin
		#1250 MISO <= 1;
		#1600 MISO <= 0;
		#1600 MISO <= 1;
		#1600 MISO <= 0;
		#1600 MISO <= 1;
		#1600 MISO <= 0;
		#1600 MISO <= 1;
		#1600 MISO <= 0;
		#1600 MISO <= 1;
		#1600 MISO <= 0;
		#1600 MISO <= 1;
		#1600 MISO <= 0;
		#1600 MISO <= 1;
		#1600 MISO <= 0;
		#1600 MISO <= 1;
		#1600 MISO <= 0;
	end
	
	//Second transaction
	initial
	begin
		#40100;
		// Add stimulus here      
		#100 nrst <= 0;
		#100 nrst <= 1;
		#650 send <= 1;
		#100 send <= 0;
		#100 data_in <= 16'h8888;
		#100 data_in <= 0;
	end
	//received data 0x0aa8
	initial
	begin
		#41250 MISO <= 0;
		#1600 MISO <= 0;
		#1600 MISO <= 0;
		#1600 MISO <= 0;
		#1600 MISO <= 1;
		#1600 MISO <= 0;
		#1600 MISO <= 1;
		#1600 MISO <= 0;
		#1600 MISO <= 1;
		#1600 MISO <= 0;
		#1600 MISO <= 1;
		#1600 MISO <= 0;
		#1600 MISO <= 1;
		#1600 MISO <= 0;
		#1600 MISO <= 0;
		#1600 MISO <= 0;
	end
	
	//10MHz frequency
	always #50
		clk <= ~clk;
      
endmodule

