# tec-CNC-PEN
TEC-1 cnc driven pen


## Forth code 
 for controlling a 2D plotter or CNC machine. The main features of the code include:

1. **IO Port Initialization**: The code defines constants for IO ports which are associated with different stepper motor controls and pen controls. These ports are initialized using the `INIT-IO-PORTS` word.

2. **Motor Control**: The code defines the `MOVE-X` and `MOVE-Y` words for controlling the stepper motors of the plotter's X and Y axes, respectively. These words take the number of steps to move as an argument, determine the direction of the movement (based on whether the number of steps is positive or negative), and then perform the movement.

3. **Pen Control**: The code defines the `PEN-UP` and `PEN-DOWN` words for controlling the plotter's pen.

4. **G-code Processing**: The code defines the `PROCESS-GCODE` word for processing G-code commands. This word recognizes "G0", "G1", and "G28" commands. Other commands are considered unsupported and result in an error message.

5. **Input Reading**: The code defines the `READ-GCODE` word for reading input from the serial terminal.

6. **Main Loop**: The code provides an `EXAMPLE` word which initializes the IO ports, moves the plotter to the origin, and then enters a loop in which it continually reads G-code commands from the terminal and processes them.

## Additional work that may be required includes:

1. **G-code Parameter Parsing**: The `PROCESS-GCODE` word does not currently parse parameters from the G-code commands. It needs to be extended to extract numerical parameters from the G-code commands and pass them to the `MOVE-X` and `MOVE-Y` words.

2. **Support for More G-code Commands**: The `PROCESS-GCODE` word currently only supports three G-code commands ("G0", "G1", "G28"). It may need to be extended to support more commands, depending on the requirements of your application.

3. **Error Handling**: The code does not currently handle errors robustly. For example, it may crash or behave unpredictably if the user enters a G-code command with a malformed parameter. Error handling routines could be added to make the program more robust and user-friendly.

4. **Code Documentation**: While the code contains some comments, more detailed documentation would help others understand how it works, how to use it, and how to extend it.

5. **User Interface Improvements**: The user interface, which is currently a simple command-line interface, could be improved. For example, the program could provide more detailed prompts or help messages. It could also use a more structured format for input, such as reading G-code commands from a file rather than from the terminal.

Please note that these are potential improvements. The exact work required will depend on the specific requirements of your application.
