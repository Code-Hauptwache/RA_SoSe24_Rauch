# RA_SoSe24_Rauch

This repository contains the solutions for the exercises in the Computer Architecture module for the summer semester 2024 at the Frankfurt University of Applied Sciences under the supervision of Prof. Wolfgang Rauch.

## Content

- `Exercise Sheets`: Contains the exercise sheets for the tasks.
- `Solutions`: Contains the solutions to the tasks in the form of MIPS assembly programs.
- `Mars.jar`: MIPS Assembler and Runtime Simulator for running the programs.

## Installation

1. **Clone the repository**:
    ```sh
    git clone https://github.com/Code-Hauptwache/RA_SoSe24_Rauch.git
    cd RA_SoSe24_Rauch
    ```

2. **Install Java**:
    To use MARS, Java must be installed on your system. Use one of the following commands to install Java:

    ```sh
    sudo apt update
    sudo apt install default-jdk
    ```

    Alternatively, you can use the specific version commands:
    ```sh
    sudo apt install openjdk-11-jre-headless   # Version 11
    sudo apt install openjdk-17-jre-headless   # Version 17
    ```

3. **Download and Start MARS**:
    First, download the `Mars.jar` file from the course website or from the following link:
    - [Download Mars.jar](http://courses.missouristate.edu/KenVollmar/MARS/)
    - [Professor's Website](https://www.informatik.fb2.frankfurt-university.de/~rauch/)

    Alternatively, you can use the unofficial version of MARS that supports themes:
    - [MARS Theme Engine Releases](https://github.com/aeris170/MARS-Theme-Engine/releases)
    - [MARS Theme Engine GitHub Repository](https://github.com/aeris170/MARS-Theme-Engine)

    **Note**: This repository uses the unofficial version of MARS, which can be found in the `head` directory named `Mars4_5_1_1Unofficial.jar`. You can use this version without installing MARS yourself.

    To start MARS, you can use the following command:
    ```sh
    java -jar Mars.jar
    ```
    If you are using the version from this repository, use:
    ```sh
    java -jar head/Mars4_5_1_1Unofficial.jar
    ```

    If you want to open MARS from another path, simply replace `<path>` with the actual path to the `Mars.jar` file:
    ```sh
    java -jar <path>/Mars.jar
    ```
## Running `.asm` files in MARS

1. **Create a new MIPS assembly file**:
    - Open MARS and create a new file or open an existing `.asm` file from the `Solutions` directory.

2. **Assemble the program**:
    - In MARS, go to the menu and select `Run -> Assemble` or use the assemble button to convert the assembly code into machine code.

3. **Run the program**:
    - After assembling, you can run the program in two modes:
      - **Single Step**: Use `Run -> Step` to execute one instruction at a time.
      - **Go**: Use `Run -> Go` to run the entire program.

### Running Existing `.asm` Files

1. **Open an existing `.asm` file**:
    - In MARS, go to `File -> Open` and navigate to the `Solutions` directory of this repository. Select the `.asm` file you want to run.

2. **Assemble the file**:
    - Click on `Run -> Assemble` to assemble the selected file.

3. **Run the assembled file**:
    - Use `Run -> Go` to execute the entire program or `Run -> Step` to execute it step by step.

## Contributors

- **Hauptwache Code Team**: Management and organization of the repository.
- **Students from Frankfurt UAS**: Contributors to the tasks and examples.
