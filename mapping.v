module mapping(
	input clk,
	input wire [15:0] num,
	output reg [6:0] codeout
);
	always@(posedge clk) begin
		case(num)
			4'b0000:codeout=7'b1111110;
			4'b0001:codeout=7'b0110000;
			4'b0010:codeout=7'b1101101;
			4'b0011:codeout=7'b1111001;
			4'b0100:codeout=7'b0110011;
			4'b0101:codeout=7'b1011011;
			4'b0110:codeout=7'b1011111;
			4'b0111:codeout=7'b1110000;
			4'b1000:codeout=7'b1111111;
			4'b1001:codeout=7'b1111011;
		endcase
	end
endmodule
