

module counter(clk, seg, segsel);

	output [7:0] seg;
	output [3:0] segsel;

	input clk;
	reg [15:0] counter;
	
	reg [24:0] count;
	
	wire [15:0] next_counter;
	
	assign next_counter = counter + 1;
	
	always @(posedge clk) begin
		count <= count + 1;
		
		if(count == 25'b1)
			counter = next_counter;
	end
	
	LED7Seg led7(clk, seg, segsel, counter);
	
endmodule
	