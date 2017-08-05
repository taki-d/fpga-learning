

module counter(clk, seg, segsel, nbtn);

	output [7:0] seg;
	output [3:0] segsel;
	
	input [3:0] nbtn;
	wire [3:0] btn = ~nbtn;
	
	input clk;
	reg [15:0] counter;
	
	reg [24:0] count;
	
	always @(posedge clk) begin
		count = count + 1;
		
		if(count == 25'b1) begin
			if(btn[0]) begin
				counter = counter + 1;
			end
			else begin
				counter = counter - 1;
			end
		end
	end
	
	LED7Seg led7(clk, seg, segsel, counter);
	
endmodule
	