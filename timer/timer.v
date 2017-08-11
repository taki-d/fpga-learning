
module timer(clk, speaker, seg, segsel, nbtn);
	input clk;
	output speaker;
	output [7:0] seg;
	output [3:0] segsel;
	
	input [3:0] nbtn;
	wire [3:0] btn = ~nbtn;
	
	reg [0:0] speaker_enable = 0;	
	reg [1:0] state = 0;
	
	reg [15:0] led_data = 0;
	reg [24:0] count;
	reg [22:0] button_counter = 0;
	reg [0:0] button_flag = 0;
	
	Speaker sp(clk,speaker_enable,speaker);
	LED7Seg led7seg(clk,seg,segsel,led_data);

	reg [1:0] next_state;
	
	always begin
		case(state)
			2'd0 : next_state = (btn[2] & (led_data != 0) ? 2'd1 : 2'd0);
			2'd1 : next_state = (led_data == 16'd0 ? 2'd2 : 2'd1);
			default: next_state = (btn[2] ? 2'd0 : 2'd2);
		endcase
	end
	
	always @(posedge clk) begin
		case(next_state)
			2'd0 : begin
				speaker_enable = 0;
				
				if(button_flag[0]) begin
					if(btn[1]) begin
						led_data = led_data + 1;
					end
					if(btn[0]) begin
						led_data = led_data - 1;
					end
					button_flag = 0;
				end
				else begin
					button_counter = button_counter + 1;
					if(button_counter == 22'd0) begin
						button_flag = 1;
					end
				end
				
			end
			
			2'd1 : begin
				count = count + 1;
				
				if(count == 25'd1) begin
					led_data = led_data - 1;
				end
			end
			
			2'd2 : begin
				speaker_enable = 1;
			end
		endcase
		
		state = next_state;
		
	end


	
endmodule
