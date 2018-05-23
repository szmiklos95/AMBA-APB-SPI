`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:16:17 05/23/2018 
// Design Name: 
// Module Name:    PREADY_Setter 
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
module PREADY_Setter(
		input PREADY_R,
		input PREADY_W,
		output PREADY
    );

assign PREADY = PREADY_R | PREADY_W;

endmodule
