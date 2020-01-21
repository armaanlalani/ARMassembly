
module Lab5_P3(SW, KEY, HEX3, HEX2, HEX1, HEX0);

    input [1:0] SW;

    input [0:0] KEY;

    output [6:0] HEX3, HEX2, HEX1, HEX0;


    wire [14:0] t;

    wire [15:0] q;

    wire clk;

    wire clear;

    wire enable;


    assign clk = KEY[0];

    assign clear = SW[0];

    assign enable = SW[1];

    assign t[0] = enable & q[0];

    assign t[1] = t[0] & q[1];

    assign t[2] = t[1] & q[2];

    assign t[3] = t[2] & q[3];

    assign t[4] = t[3] & q[4];

    assign t[5] = t[4] & q[5];

    assign t[6] = t[5] & q[6];

    assign t[7] = t[6] & q[7];

    assign t[8] = t[7] & q[8];

    assign t[9] = t[8] & q[9];

    assign t[10] = t[9] & q[10];

    assign t[11] = t[10] & q[11];

    assign t[12] = t[11] & q[12];

    assign t[13] = t[12] & q[13];

    assign t[14] = t[13] & q[14];


    tff d0 (enable, clk, clear, q[0]);

    tff d1 (t[0], clk, clear, q[1]);

    tff d2 (t[1], clk, clear, q[2]);

    tff d3 (t[2], clk, clear, q[3]);

    tff d4 (t[3], clk, clear, q[4]);

    tff d5 (t[4], clk, clear, q[5]);

    tff d6 (t[5], clk, clear, q[6]);

    tff d7 (t[6], clk, clear, q[7]);

    tff d8 (t[7], clk, clear, q[8]);

    tff d9 (t[8], clk, clear, q[9]);

    tff d10 (t[9], clk, clear, q[10]);

    tff d11 (t[10], clk, clear, q[11]);

    tff d12 (t[11], clk, clear, q[12]);

    tff d13 (t[12], clk, clear, q[13]);

    tff d14 (t[13], clk, clear, q[14]);

    tff d15 (t[14], clk, clear, q[15]);


    decoder f0(q[3:0], HEX0);

    decoder f1(q[7:4], HEX1);

    decoder f2(q[11:8], HEX2);

    decoder f3(q[15:12], HEX3);

endmodule



module tff(T, clock, resetn, Q);

    input T, clock, resetn;

    output reg Q;

    always @(posedge clock, negedge resetn)

    begin

        if(resetn == 1'b0)

            Q <= 1'b0;

        else if(T == 1'b1)

            Q <= ~Q;

    end

endmodule


module decoder (input [3:0] s, output [6:0] hex);

    wire c3, c2, c1, c0;

    assign {c3, c2, c1, c0} = {s[3], s[2], s[1], s[0]};

    

    assign hex[0] = ~((c3 | c2 | c1 | ~c0) & (c3 | ~c2 | c1 | c0) & (~c3 | c2 | ~c1 | ~c0)  & (~c3 | ~c2 | c1 | ~c0));

    assign hex[1] = ~((c3 | ~c2 | c1 | ~c0) & (c3 | ~c2 | ~c1 | c0) & (~c3 | c2 | ~c1 | ~c0) & (~c3 | ~c2 | c1 | c0) & (~c3 | ~c2 | ~c1 | c0) & (~c3 | ~c2 | ~c1 | ~c0));

    assign hex[2] = ~((c3 | c2 | ~c1 | c0) & (~c3 | ~c2 | c1 | c0) & (~c3 | ~c2 | ~c1 | c0) & (~c3 | ~c2 | ~c1 | ~c0));

    assign hex[3] = ~((c3 | c2 | c1 | ~c0) & (c3 | ~c2 | c1 | c0) & (c3 | ~c2 | ~c1 | ~c0) & (~c3 | c2 | c1 | ~c0) & (~c3 | c2 | ~c1 | c0) & (~c3 | ~c2 | ~c1 | ~c0));

     assign hex[4] = ~((c3 | c2 | c1 | ~c0) & (c3 | c2 | ~c1 | ~c0) & (c3 | ~c2 | c1 | c0) & (c3 | ~c2 | c1 | ~c0) & (c3 | ~c2 | ~c1 | ~c0) & (~c3 | c2 | c1 | ~c0));

     assign hex[5] = ~((c3 | c2 | c1 | ~c0) & (c3 | c2 | ~c1 | c0) & (c3 | c2 | ~c1 | ~c0) & (c3 | ~c2 | ~c1 | ~c0) & (~c3 | ~c2 | c1 | ~c0));

    assign hex[6] = ~((c3 | c2 | c1 | c0) & (c3 | c2 | c1 | ~c0) & (c3 | ~c2 | ~c1 | ~c0) & (~c3 | ~c2 | c1 | c0));

endmodule

