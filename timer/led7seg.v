
`timescale 1ns / 1ps

module LED7Seg(clk, seg, segsel, data);
		// seg bits and led segment:
		//  00
		// 5  1
		//  66
		// 4  2
		//  33  7
		output [7:0] seg;
		output [3:0] segsel;
		input clk;
		input [15:0] data;
		
		reg [18:0] counter;

		wire [3:0] v0, v1, v2, v3;
		assign v0 = data[3:0];
		assign v1 = data[7:4];
		assign v2 = data[11:8];
		assign v3 = data[15:12];
		
		wire [1:0] dsel = counter[18:17];
		assign segsel = ~(4'b1 << dsel);
		assign seg = ~decodev(dsel, v0, v1, v2, v3);
		
		always @ (posedge clk) begin
			counter = counter + 1'b1;
		end
		
		function [7:0] decodev (
			input [1:0] vsel,
			input [4:0] v0,
			input [4:0] v1,
			input [4:0] v2,
			input [4:0] v3);
			case (vsel)
				2'b00: decodev = decode(v0);
				2'b01: decodev = decode(v1);
				2'b10: decodev = decode(v2);
				2'b11: decodev = decode(v3);
			endcase
		endfunction
		
		function [7:0] decode (input [3:0] n);
			case (n)
				4'h0: decode = 8'b00111111;
				4'h1: decode = 8'b00000110;
				4'h2: decode = 8'b01011011;
				4'h3: decode = 8'b01001111;
				4'h4: decode = 8'b01100110;
				4'h5: decode = 8'b01101101;
				4'h6: decode = 8'b01111101;
				4'h7: decode = 8'b00000111;
				4'h8: decode = 8'b01111111;
				4'h9: decode = 8'b01101111;
				4'hA: decode = 8'b01110111;
				4'hb: decode = 8'b01111100;
				4'hC: decode = 8'b00111001;
				4'hd: decode = 8'b01011110;
				4'hE: decode = 8'b01111001;
				4'hF: decode = 8'b01110001;
			endcase
		endfunction
		
endmodule