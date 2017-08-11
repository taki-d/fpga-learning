
module Speaker(input clk, input enable, output speaker);

	reg[31:0] cnt;
	
	assign speaker = enable & (cnt > 32'd56818);
	
	always @(posedge clk) begin	
		if(cnt == 32'd113636)
			cnt <= 32'd0;
		else
			cnt <= cnt + 1;
	end

endmodule
