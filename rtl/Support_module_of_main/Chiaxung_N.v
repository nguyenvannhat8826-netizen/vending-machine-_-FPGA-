module Chiaxung_N #(parameter DIV = 50_000)(
    input  wire clk,
    output reg  tick = 1'b0
);
    reg [31:0] count = 0;
    always @(posedge clk) begin
        if (count == DIV - 1) begin
            count <= 0;
            tick <= 1'b1;
        end else begin
            count <= count + 1'b1;
            tick <= 1'b0;
        end
    end
endmodule
