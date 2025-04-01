module tb_simple_soc;
    // Testbench signals
    reg clk;            // Clock signal 
    reg reset;          // Reset signal 
    reg enable;         // Enable signal 
    wire [3:0] count;   // Counter output 
    wire match;         // Comparator output  

    // Instantiate the SOC DUT 
    simple_soc dut(
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .count(count),
        .match(match)
    );

    // Clock generation: 10-unit period
    always #5 clk = ~clk; 

    // Test sequence 
    initial begin
        // Initialize signals
        clk = 0;
        reset = 0;
        enable = 0; 

        // Dump waveform for debugging
        $dumpfile("soc_tb.vcd");
        $dumpvars(0, tb_simple_soc); 

        // Test Case 1: Apply reset
        #10 reset = 1;          // Assert reset 
        #10 reset = 0;          // Deassert reset 
        $display("After reset, count = %d, match = %b", count, match); 

        // Test Case 2: Count up to threashold (10) and beyond
        #10 enable = 1;         // Start counting 
        #100;                   // Wait 100 units (10 clock cycles, count goes 0 to 10) 

        // Test Case 3: Count one more cycle, past threashold
        #10;                    // 1 more cycle (count = 11)
        $display("After 11 cycles, count = %d, match= %b", count, match);         

        // Test Case 4: Disable and hold 
        #10 enable = 0;       // Stop counting 
        #20;                    // Wait 2 cycles 
        $display("After disable, count = %d, match = %b", count, match);

        // End simulation
        #10 $finish; 
    end 

    // Monitor signals
    initial 
        $monitor("Time=%0t | reset = %b | enable = %b | count = %d | match = %b", 
        $time, reset, enable, count, match);
    
    // SystemVerilog Assertions 
    // Assertion 1: After reset, count should be 0
    property reset_check;
        @(posedge clk) reset |=> (count == 0);
    endproperty
    assert property (reset_check) else 
        $error("Assertion failed: count != 0 after reset at time %0t", $time);

    // Assertion 2: When count == 10, match must be 1
    property match_at_threshold;
        @(posedge clk) (count == 10) |-> (match == 1);
    endproperty 
    assert property (match_at_threshold) else 
        $error("Assertion failed: match != 1 when count == 10 at time %0t", $time); 

    // Assertion 3: When count != 10, match must be 0 
    property no_match_off_threshold;
        @(posedge clk) (count != 10) |-> (match == 0);
    endproperty 
    assert property (no_match_off_threshold) else 
        $error("Assertion failed: match != 0 when count != 10 at time %0t", $time);

    // Assertion 4: When enable is low and reset is low count holds 
    property hold_when_disabled;
        @(posedge clk) (!enable && !reset) |=> ($stable(count));
    endproperty 
    assert property (hold_when_disabled) else 
        $error("Assertion failed: count changed when disabled at time %0t", $time);
endmodule 
