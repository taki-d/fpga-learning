module led (led1,led2,clk,btn);
	input clk;
	input btn;
	output led1;
	output led2;
	
	reg[24:0]count;
	assign led1 = count[24];
	assign led2 = ^btn;
	always @(posedge(clk)) begin
		if(btn == 0) count <= count + 1;
	end
endmodule	
