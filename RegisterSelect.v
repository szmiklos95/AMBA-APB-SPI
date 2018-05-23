`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:24:03 05/23/2018 
// Design Name: 
// Module Name:    RegisterSelect 
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
module RegisterSelect(
		input PADDR,
		output IO_reg
    );

// PADDR == 1 --> address the SPI input register (WRITE operation)
// PADDR == 0 --> address the SPI output register (READ operation)
assign IO_reg = PADDR;

endmodule
