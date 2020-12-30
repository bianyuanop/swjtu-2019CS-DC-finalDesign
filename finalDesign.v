module finalDesign(
	input clk,
	input start_in,
	input end_in,
	input clear_in,
	input en,
	input wire [2:0] check,
	output reg led,
	output wire [2:0] seg,
	output wire [6:0] digits,
	output reg [1:0] winner
);

wire clk_inner;
wire [15:0] counter_inside;
reg [15:0] counter_storage;

reg [15:0] max;
reg [15:0] min;
reg [15:0] average;

reg [15:0] rand_num;
reg clear_logic;
reg start_flag;
reg en_logic;

initial begin
	led = 0;
	clear_logic = 0;
	start_flag = 0;
	en_logic = 0;
	max=0;
	min=999;
	average=0;
end

splittor sp1(
	.clk_in (clk),
	.clk_out (clk_inner)
);

counter c1(
	.clk (clk_inner),
	.en (en_logic),
	.clear (clear_logic),
	.digits (counter_inside)
	
);

display dp1(
	.clk (clk),
	.count (counter_storage),
	.seg (seg),
	.codeout (digits)
);


always @(posedge clk_inner) begin
	counter_storage <= counter_inside;
	
	// 对生成的rand计数
	if( rand_num > 0 ) rand_num <= rand_num - 1;
	
	if( clear_in ) begin
		en_logic = 0;
		clear_logic = 1;
	end
	else clear_logic = 0;
	
	if( en ) begin
		if( start_in ) begin
			rand_num <= 2000;
			if( rand_num == 0 ) begin
				start_flag = 1;
				en_logic = 1;
			end
		end
		
		if( end_in ) begin
			if( start_flag ) begin
				start_flag = 0;
				
				en_logic = 0;
				if( counter_inside > max ) max <= counter_inside;
				if( counter_inside < min ) min <= counter_inside;
				average <= (max + min)/2;
				//获胜者显示
				if( max > counter_inside ) winner <= 2'b10;
				else winner <= 2'b01;
			end
			else begin
			//抢跑
				counter_storage <= 999;
			end
		end
	end
	// 显示最大最小值
	else begin
		if( check[0] )  counter_storage <= max;
		if( check[1] )  counter_storage <= min;
		if( check[2] )  counter_storage <= average;
	end
end

endmodule
