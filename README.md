# 🎹 Piano in Assembly (8086 DOSBox)

A simple piano program written in **x86 Assembly (8086)**.  
It runs inside **DOSBox** using **graphics mode 13h** and the **PC speaker** to simulate a mini piano.

---

## ▶️ How to Run

1. Install [DOSBox](https://www.dosbox.com/).

2. Clone or download this repository.

3. Make sure the following files are present in the project folder:
   - `TASM.EXE`
   - `TLINK.EXE`
   - `PIANO2.ASM`

4. In DOSBox, navigate to the project folder and assemble/link:
   ```bash
   tasm piano2.asm
   tlink piano2.obj

🎶 Press A, S, D, F, G, H to play notes.
Press ESC to quit.

##🛠 Tech Stack
Language: x86 Assembly (TASM)

Graphics Mode: Mode 13h (320x200, 256 colors)

Sound: PC speaker via port 42h

Tools: Turbo Assembler (TASM), Turbo Linker (TLINK)

Emulation: DOSBox

## 🎨 Features
Draws 6 white piano keys on screen.

Each key changes color when pressed:

A → Do (Red)

S → Re (Orange)

D → Mi (Yellow)

F → Fa (Green)

G → Sol (Light Blue)

H → La (Blue)

Plays the corresponding note frequency on the PC speaker.

Pressing ESC exits and shows a goodbye message.

## 📸 Screenshots

<img width="752" height="540" alt="Screenshot 2025-09-07 at 20 41 49" src="https://github.com/user-attachments/assets/3379c918-7020-44f5-8ba2-02d36bed0145" />

<img width="752" height="540" alt="Screenshot 2025-09-07 at 20 41 31" src="https://github.com/user-attachments/assets/10318d86-f40b-4153-b5ad-996fa338f34d" />


