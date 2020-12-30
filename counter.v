module counter(
	input clk,
	input en,
	input clear,
	output reg [15:0] digits
);

initial begin
	digits = 0;
end



always @(posedge clk) begin
	if( en ) digits <= digits + 1'b1;
	else digits <= digits;
	
	if( clear ) digits <= 0;
end

endmodule
