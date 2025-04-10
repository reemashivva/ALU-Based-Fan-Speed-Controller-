# Testbench

The testbench provides a simulation of different temperature values to verify the correct operation of the fan speed controller. It tests different temperature ranges:

- Low speed for temperatures below 20°C.
- Medium speed for temperatures between 20°C and 40°C.
- High speed for temperatures above 40°C.



---
## ALU Output Alone:

- This will show the raw output of the ALU when it is functioning independently, just performing operations on the operands without considering the temperature input for fan speed control.
![Image](https://github.com/user-attachments/assets/acb481ff-4dc2-4e5f-a9bc-02b91a07c6a8)


## ALU Output with Temperature-Based Fan Speed Control:

- This will show how the ALU output is integrated into your temperature-based fan speed controller logic, using the temperature input to determine the fan speed based on the ALU's results.
![Image](https://github.com/user-attachments/assets/9ffc1717-8f63-4a87-945f-993953b39f92)
