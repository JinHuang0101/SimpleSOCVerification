# Simple SOC Design and Verification Project

## Overview
This project demonstrates a basic System-on-Chip (SOC) design and its verification using Verilog and SystemVerilog. The SOC includes a 4-bit counter and a comparator, connected to simulate a small system. The testbench verifies the functionality of the SOC, ensuring the counter increments correctly and the comparator accurately detects a threshold value. This project showcases my skills in SOC verification, including testbench development, simulation, and assertion-based verification.

## Project Structure
- **Design Files**:
  - `simple_counter.v`: A 4-bit counter that increments on each clock cycle when enabled and resets when a reset signal is active.
  - `comparator.v`: A comparator that outputs a `match` signal when the counter value equals a predefined threshold (10 in decimal).
  - `simple_soc.v`: The top-level SOC module that integrates the counter and comparator.

- **Testbench File**:
  - `tb_simple_soc.sv`: A SystemVerilog testbench that stimulates the SOC, verifies its behavior, and includes assertions to check key properties.

## Key Features
- **Counter Functionality**: The counter increments from 0 to 15, resets to 0 when `reset` is high, and holds its value when `enable` is low.
- **Comparator Functionality**: The comparator sets `match` to 1 when the counter value equals 10, otherwise 0.
- **Testbench Verification**:
  - Applies reset, enables counting for 10 cycles, counts one more cycle past the threshold, and disables counting to verify holding behavior.
  - Uses `$monitor` and `$display` to log signal values and results.
  - Includes SystemVerilog assertions to verify:
    - Counter resets to 0 after `reset`.
    - `match` is 1 when `count` equals 10.
    - `match` is 0 when `count` does not equal 10.
    - Counter holds its value when disabled.

## How to Run the Simulation
1. **Prerequisites**:
   - A Verilog/SystemVerilog simulator (e.g., Icarus Verilog, Synopsys VCS).
   - For assertions, use a simulator with SystemVerilog support (e.g., Synopsys VCS).

2. **Clone the Repository**:
   ```bash
   git clone https://github.com/JinHuang0101/SimpleSOCVerification.git
   cd simple-soc-verification
   ```

3. **Run with Icarus Verilog (Without Assertions)**:
   - If using Icarus Verilog, remove the assertions from `tb_simple_soc.sv` (lines 49–71) as Icarus Verilog 12.0 has limited assertion support.
   - Compile and simulate:
     ```bash
     iverilog -o sim simple_counter.v comparator.v simple_soc.v tb_simple_soc.sv
     vvp sim
     ```

4. **Run with Synopsys VCS (With Assertions)**:
   - Use a simulator like Synopsys VCS to support SystemVerilog assertions.
   - Example command (varies by environment):
     ```bash
     vcs -full64 -sverilog simple_counter.v comparator.v simple_soc.v tb_simple_soc.sv
     ./simv
     ```

5. **View Waveforms**:
   - The testbench generates a `soc_tb.vcd` file for waveform viewing.
   - Open with a tool like GTKWave:
     ```bash
     gtkwave soc_tb.vcd
     ```

## Expected Output
The simulation logs the following key results:
- After reset: `count = 0`, `match = 0`.
- After 10 cycles: `count = 10`, `match = 1` (threshold reached).
- After 11 cycles: `count = 11`, `match = 0`.
- After disable: `count = 12`, `match = 0` (holds value after one extra increment).

## Purpose
This project was developed to practice SOC verification fundamentals, including testbench design, simulation, and assertion-based verification. It demonstrates my ability to verify hardware designs, a skill relevant to roles in chip design and verification.

## Contact
For questions or collaboration, reach out via [LinkedIn](https://www.linkedin.com/in/jin-huang-5b427a12/) or email at jinhuang922@gmail.com.

---

This README provides a clear summary of your project, making it easy for potential employers or collaborators to understand your work. You can copy this into a `README.md` file in your GitHub repository. Let me know if you’d like to adjust the tone or add more details!
