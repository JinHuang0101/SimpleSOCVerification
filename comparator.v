module comparator(
    input wire [3:0] count,         // 4-bit input from the counter 
    output reg match                // Output: 1 if count equals threashold 
);
    parameter THRESHOLD = 4'b1010;  // Fixed threashold (10 in decimal)

    always @(*) begin               // Combinational logic
        if (count == THRESHOLD)
            match = 1; 
        else 
            match = 0; 
    end 
endmodule
