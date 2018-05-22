`timescale 1ns / 1ps

module control(
	input clk, nrst, send, sampling,
	output reg shift_en, done, load, ss
   );
	 
localparam [2:0]
	Init 	= 3'b000,
	Load 	= 3'b001,
	Wait1 = 3'b010,
	Shift = 3'b011,
	Wait2	= 3'b100,
	Done 	= 3'b101;
	
reg [2:0] curr_state, next_state;
reg [4:0] cnt;

	always @ (posedge clk)
	begin
		if(!nrst)
			curr_state <= Init;
		else
			curr_state <= next_state;
	end
	
	always @ (posedge clk)
	begin
		if(!nrst)
			cnt <= 0;
		else if((curr_state == Shift) & (sampling))
			cnt <= cnt + 1;
		else if(load)
			cnt <= 0;
		else
			cnt <= cnt;
	end

	always @ (*)
	begin
		case(curr_state)
			Init:
			begin
				{shift_en, load, done, ss} <= 4'b0001;
				
				if(send)
					next_state <= Load;
				else
					next_state <= curr_state;
			end
			
			Load:
			begin
				{shift_en, load, done, ss} <= 4'b0101;
				
				next_state <= Wait1;
			end
			
			Wait1:
			begin
				{shift_en, load, done, ss} <= 4'b1000;
				
				next_state <= Shift;
			end
			
			Shift:
			begin
				{shift_en, load, done, ss} <= 4'b1000;
				
				if(cnt == 16)
					next_state <= Done;
				else
					next_state <= curr_state;
			end
			
			/*Wait2:
			begin
				{shift_en, load, done, ss} <= 4'b1000;
				
				next_state <= Done;
			end*/
			
			Done:
			begin
				{shift_en, load, done, ss} <= 4'b0011;
				
				if(send)
					next_state <= Load;
				else	
					next_state <= curr_state;
			end
			
			default:
			begin
				{shift_en, load, done, ss} <= 4'b0001;
				
				next_state <= Init;
			end
		endcase
	end


endmodule
