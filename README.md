# 8-bit ALU-Based Temperature-Controlled Fan Speed Controller

## Overview

This project implements an FPGA-based 8-bit Arithmetic Logic Unit (ALU) used to control fan speed based on temperature readings (in Celsius).  
Instead of using direct comparison logic, all temperature comparisons are carried out through ALU operations, making the design modular and reusable for a variety of computational tasks.

The system reads the ambient temperature, processes it using the ALU, and dynamically adjusts the fan speed accordingly.

---

## System Architecture

- **ALU Block**:  
  A modular 8-bit ALU capable of handling arithmetic (addition, subtraction, multiplication) and logical (AND, OR, XOR) operations, as well as shifts and comparisons.

- **Temperature Controller Block**:
  - Receives an 8-bit temperature input (`temp_in`).
  - Subtracts preset thresholds (20°C and 40°C) from the current temperature using the ALU.
  - Decides fan speed based on the subtraction results:
    - Temperature < 20°C → **Low speed**
    - 20°C ≤ Temperature < 40°C → **Medium speed**
    - Temperature ≥ 40°C → **High speed**

---

## ALU Operation

| Opcode | Operation      |
|:------:|:---------------|
| 000    | Addition (A + B) |
| 001    | Subtraction (A - B) |
| 010    | Multiplication (A × B) |
| 011    | Logical AND (A & B) |
| 100    | Logical OR (A \| B) |
| 101    | Logical XOR (A ^ B) |
| 110    | Shift Left (A << 1) |
| 111    | Shift Right (A >> 1) |

- The **Opcode** is a 3-bit input that selects the desired ALU operation.
- For fan control, the system primarily uses the **subtraction** operation (Opcode = `001`).

---

## Fan Speed Control Logic

1. **Subtraction Phase**:
   - The system first subtracts **20** from the temperature using the ALU.
   - If the result is negative (`diff20 < 0`), fan is set to **Low speed**.

2. **Second Subtraction Phase**:
   - If `diff20 ≥ 0`, the system then subtracts **40** from the temperature.
   - If this result (`diff40`) is negative, fan is set to **Medium speed**.

3. **Otherwise**:
   - If both `diff20` and `diff40` are ≥ 0, fan is set to **High speed**.

4. **Fan Speed Encoding**:
   - `00` → Low
   - `01` → Medium
   - `10` → High

---





## Files Included

- `alu.v` : ALU module
- `TempFanController.v` : Temperature-based fan controller using the ALU
- `Testbench.v` : Testbench for simulation and verification
- `architecture.png` : System block diagram
- `README.md` : Project documentation

---

## Future Improvements

- Integrate real sensor data (e.g., using an ADC input from a temperature sensor).
- Expand ALU to support more complex operations like division.
- Add PWM control for more granular fan speed adjustment.

---

## License

This project is open-source and free to use for academic and educational purposes.

