`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:21:54 05/22/2018 
// Design Name: 
// Module Name:    TopModule 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module TopModule(
	input PCLK,
	input PRESETn,
	input PADDR,
	input PROT,
	input PSEL0,
	input PENABLE,
	input PWRITE,
	input [15:0] PWDATA,
	input [1:0] PSTRB,
	
	output PREADY,
	output [15:0] PRDATA,
	output PSLVERR,
	
	input  MISO,
	output MOSI, SCLK, SS
    );
	 
wire [15:0] SPI_data_out;
wire [15:0] SPI_data_in;

TopMod_spi SPI_module(
	.clk(PCLK),
	.nrst(PRESETn),
	.MISO(MISO),
	.MOSI(MOSI),
	.SCLK(SCLK),
	.SS(SS),
	.data_out(SPI_data_out),
	.data_in(SPI_data_in)
);

APB_interface APB_if(
	.PCLK(PCLK),
	.PRESETn(PRESETn),
	.data_in(SPI_data_out),
	.data_out(SPI_data_in),
	.PRDATA(PRDATA),
	.PWDATA(PWDATA)
);

endmodule

