🎹 Piano in Assembly (8086 DOSBox)

This is a simple piano program written in x86 Assembly (8086), built to run in DOSBox.
It was one of my first graphics & sound projects, made in 2024 as a fun way to combine keyboard input, VGA graphics mode, and PC speaker sound.

🚀 Features

Runs in graphics mode 13h (320x200, 256 colors).

Draws 6 white keys on screen (A–H keys on keyboard).

Each key changes color when pressed and plays a note:

A → Do (Red)

S → Re (Orange)

D → Mi (Yellow)

F → Fa (Green)

G → Sol (Light Blue)

H → La (Blue)

Press ESC to exit and return to text mode.

Uses PC speaker for sound, sending frequencies directly to port 42h.

Simple message handling (see you later) when closing the program.

🖥️ How It Works

Graphics: Keys are drawn using custom macros and procedures (drawPixel, drawLine, print).

Sound: Notes are played with playnote, controlling the PC speaker via I/O ports.

Keyboard Input: Polls the keyboard buffer (in al, 60h) to detect key presses/releases.

Macros simplify repetitive tasks like enabling sound, drawing keys, and switching modes.

▶️ Running the Program

Install DOSBox
.

Assemble and link the code with TASM or MASM:

tasm piano2.asm
tlink piano2.obj


Run the executable inside DOSBox:

piano2.exe


Press the keys A, S, D, F, G, H to play notes.
Press ESC to exit.

📸 Demo

(You can add a screenshot of the piano keys here once you run it in DOSBox!)

📂 File Structure

PIANO2.ASM → Source code for the piano program.

(Optional: compiled .EXE if you want to include it in the repo).

