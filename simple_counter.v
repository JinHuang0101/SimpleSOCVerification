module simple_counter(
    input wire clk,         // Clock input
    input wire reset,       // Synchronous reset
    input wire enable,      // Enable counting
    output reg [3:0] count        // 4-bit counter output 
);

    always @(posedge clk) begin
        if (reset)              // Reset takes priority
            count <= 4'b0000;
        else if (enable)        // Increment when enabled 
            count <= count + 1; 
    end 

endmodule
