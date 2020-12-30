module display(
	input clk,
	input wire [15:0] count,
	output reg [2:0] seg,
	output reg [6:0] codeout
);

initial begin
	codeout = 0;
	seg = 3'b1;
end

wire [6:0] codeout1;
wire [6:0] codeout2;
wire [6:0] codeout3;


mapping m1(
	.clk (clk),
	.num (count % 10),
	.codeout (codeout1) 
);

mapping m2(
	.clk (clk),
	.num (count/10 % 10),
	.codeout (codeout2) 
);

mapping m3(
	.clk (clk),
	.num (count/100 % 10),
	.codeout (codeout3) 
);

always @(posedge clk) begin
		seg[0] = 1;
		codeout = codeout1;
		seg[0] = 0;
		seg[1] = 1;
		codeout = codeout2;
		seg[1] = 0;
		seg[2] = 1;
		codeout = codeout3;
		seg[2] = 0;
end
	

endmodule
 