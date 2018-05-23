`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:30:18 05/22/2018 
// Design Name: 
// Module Name:    APB_interface 
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
module APB_interface(
		//System signals
		input PCLK,
		input PRESETn,
		
		//SPI signals
		input [15:0] APB_data_in,
		output [15:0] APB_data_out,
		input SPI_done,
		output SPI_send,
		
		//APB signals
		input [15:0] PWDATA,
		input PADDR, 
		input PSEL0, PENABLE, PWRITE,
		input [2:0] PPROT,
		input [1:0] PSTRB,
		
		output [15:0] PRDATA,
		output PREADY, PSLVERR
    );

wire IO_reg;
wire PREADY_W, PREADY_R;

Protection APB_Prot(
	.PPROT(PPROT)
);

ErrorHandler APB_ErrHandler(
	.PSLVERR(PSLVERR)
);

RegisterSelect APB_RegSelect(
	.PADDR(PADDR),
	.IO_reg(IO_reg)
);

WriteHandler APB_Write(
		.PCLK(PCLK), 
		.PRESETn(PRESETn),
		.IO_reg(IO_reg),
		.PWRITE(PWRITE),
		.PSEL(PSEL0), 
		.PENABLE(PENABLE),
		.PWDATA(PWDATA),
		.PREADY_W(PREADY_W),
		.APB_data_out(APB_data_out),
		.SPI_send(SPI_send)
);

ReadHandler APB_Read(
		.PCLK(PCLK), 
		.PRESETn(PRESETn),
		.IO_reg(IO_reg),
		.PWRITE(PWRITE),
		.PSEL(PSEL0), 
		.PENABLE(PENABLE),
		.PRDATA(PRDATA),
		.PREADY_R(PREADY_R),
		.APB_data_in(APB_data_in),
		.SPI_done(SPI_done)
);

PREADY_Setter PREADY_Set(
	.PREADY_R(PREADY_R),
	.PREADY_W(PREADY_W),
	.PREADY(PREADY)
);

endmodule
