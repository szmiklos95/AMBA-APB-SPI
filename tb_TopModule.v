`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:34:51 05/23/2018
// Design Name:   TopModule
// Module Name:   D:/Xilinx/Projects/AMBA-APB-SPI/tb_TopModule.v
// Project Name:  AMBA-APB-SPI
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: TopModule
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_TopModule;

	// Inputs
	reg PCLK;
	reg PRESETn;
	reg PADDR;
	reg [2:0] PPROT;
	reg PSEL0;
	reg PENABLE;
	reg PWRITE;
	reg [15:0] PWDATA;
	reg [1:0] PSTRB;
	reg MISO;

	// Outputs
	wire PREADY;
	wire [15:0] PRDATA;
	wire PSLVERR;
	wire MOSI;
	wire SCLK;
	wire SS;
	
	//Clock perioud [ns]
	localparam CLK = 100; //10MHz frequency

	// Instantiate the Unit Under Test (UUT)
	TopModule uut (
		.PCLK(PCLK), 
		.PRESETn(PRESETn), 
		.PADDR(PADDR), 
		.PPROT(PPROT), 
		.PSEL0(PSEL0), 
		.PENABLE(PENABLE), 
		.PWRITE(PWRITE), 
		.PWDATA(PWDATA), 
		.PSTRB(PSTRB), 
		.PREADY(PREADY), 
		.PRDATA(PRDATA), 
		.PSLVERR(PSLVERR), 
		.MISO(MISO), 
		.MOSI(MOSI), 
		.SCLK(SCLK), 
		.SS(SS)
	);


always #(CLK/2)
	PCLK <= ~PCLK;

// Makes a write operation with the given data
task BusWrite(input [15:0] data);
	begin
		wait(PCLK); // Wait for positive clock edge
		PADDR <= 1; // Select register (1 = input FIFO)
		PWRITE <= 1; // Set write
		PSEL0 <= 1; // Select the SPI peripheral
		PWDATA <= data; // Put data to the bus
		
		#CLK // Wait for 1 clock period
		PENABLE <= 1; // Signal that the data is valid
		
		wait(PREADY); // Wait until ready
		#CLK
		PENABLE <= 0;
		PSEL0 <= 0;
	end
endtask

// Reads data from the SPI FIFO_out register
task BusRead;
	begin
		wait(PCLK);
		PADDR <= 0; // 0 = output FIFO register
		PWRITE <= 0; // Read operation
		PSEL0 <= 1; // Select this APB SPI peripheral
		#100;
		PENABLE <= 1;
		
		wait(PREADY);
		PENABLE <= 0;
		PSEL0 <= 0;
	end
endtask

task ReceiveMISO(input [15:0] miso);
	begin
		#200 MISO <= miso[15];
		#1600 MISO <= miso[14];
		#1600 MISO <= miso[13];
		#1600 MISO <= miso[12];
		#1600 MISO <= miso[11];
		#1600 MISO <= miso[10];
		#1600 MISO <= miso[9];
		#1600 MISO <= miso[8];
		#1600 MISO <= miso[7];
		#1600 MISO <= miso[6];
		#1600 MISO <= miso[5];
		#1600 MISO <= miso[4];
		#1600 MISO <= miso[3];
		#1600 MISO <= miso[2];
		#1600 MISO <= miso[1];
		#1600 MISO <= miso[0];
	end
endtask

// Pulls reset low then high	
task ToggleReset;
	begin
		#100 PRESETn = 0;
		#100 PRESETn = 1;
	end
endtask


	//Initial values & test tasks
	initial begin
		PCLK = 0;
		PRESETn = 1;
		PADDR = 0; //SPI output fifo register
		PPROT = 0; //Normal, nonsecure, data access
		PSEL0 = 0; //Select low
		PENABLE = 0;
		PWRITE = 0; //Read
		PWDATA = 0;
		PSTRB = 0;
		MISO = 0;
		
		#100
		ToggleReset(); //Pull reset low then back to high
		#520
		BusWrite(16'hFAA2); //APB Write cycle
		ReceiveMISO(16'hAAAB); //Receive data on MISO
		#500
		BusRead(); //Read the received data that is stored in FIFO
		
	end
	
	

      
endmodule

