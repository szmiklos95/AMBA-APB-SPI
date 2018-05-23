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
	input [2:0] PPROT,
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
wire SPI_done, SPI_send;

TopMod_spi SPI_module(
	.clk(PCLK),
	.nrst(PRESETn),
	
	.MISO(MISO),
	.MOSI(MOSI),
	.SCLK(SCLK),
	.SS(SS),
	
	.data_out(SPI_data_out),
	.data_in(SPI_data_in),
	
	.done(SPI_done),
	.send(SPI_send)
);

APB_interface APB_if(
	.PCLK(PCLK),
	.PRESETn(PRESETn),
	
	.APB_data_in(SPI_data_out),
	.APB_data_out(SPI_data_in),
	.SPI_done(SPI_done),
	.SPI_send(SPI_send),
	
	.PWDATA(PWDATA),
	.PADDR(PADDR),
	.PPROT(PPROT),
	.PSEL0(PSEL0),
	.PENABLE(PENABLE),
	.PWRITE(PWRITE),
	.PSTRB(PSTRB),
	
	.PRDATA(PRDATA),
	.PREADY(PREADY),
	.PSLVERR(PSLVERR)
);

endmodule

