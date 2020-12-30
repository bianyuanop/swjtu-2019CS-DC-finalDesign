module splittor(
	input clk_in,
	output reg clk_out
);

reg [15:0] counter;

initial begin
	counter = 0;
	clk_out = 0;
end

always @(posedge clk_in) begin
		counter <= counter + 1'b1;
		if( counter >= 1 ) begin //50*1000 ) begin
			counter <= 0;
			clk_out <= ~clk_out;
		end

end
endmodule
