#!/usr/bin/env python3
"""
Termux Matrix Banner Animation
Displays a hacker banner followed by a Matrix-style falling code animation.
Exit with Ctrl+C.
"""

import os
import sys
import time
import random
import signal

# ====================== CONFIGURATION: YOUR BANNER ======================
# You can customize the ASCII art banner text here.
BANNER_TEXT = """
╔═══╗╔╗──╔╗╔═══╗╔═══╗╔═══╗╔═══╗╔╗──╔╗
║╔═╗║║║──║║║╔═╗║║╔══╝║╔══╝║╔═╗║║║──║║
║║─║║║║──║║║║─╚╝║╚══╗║╚══╗║║─║║║║──║║
║║─║║║║──║║║║─╔╗║╔══╝║╔══╝║╚═╝║║║──║║
║╚═╝║║╚═╗║╚╝╚═╝║║╚══╗║╚══╗║╔═╗║║╚═╗║╚═╗
╚═══╝╚══╝╚═╝╚═══╝╚═══╝╚═══╝╚╝─╚╝╚══╝╚══╝
"""

# ====================== ANIMATION SETTINGS ======================
# Character set for the matrix rain (includes Japanese Katakana)
CHARS = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%^&*()ｱｲｳｴｵｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄﾅﾆﾇﾈﾉﾊﾋﾌﾍﾎﾏﾐﾑﾒﾓﾔﾕﾖﾗﾘﾙﾚﾛﾜｦ"[citation:4]
# Color codes: Bright green for head, darker greens for the trail[citation:4]
COLORS = [
    '\033[38;2;0;255;0m',  # Bright Green (Head character)
    '\033[38;2;0;200;0m',  # Green
    '\033[38;2;0;150;0m',  # Medium Green
    '\033[38;2;0;100;0m',  # Dark Green
    '\033[38;2;0;50;0m',   # Very Dark Green
]
RESET_COLOR = '\033[0m'

# ====================== 1. FUNCTION TO DISPLAY BANNER ======================
def show_banner():
    """Clears the screen and prints the hacker banner."""
    os.system('clear')  # Clear the Termux screen
    print('\033[92m')   # Set text color to green
    print(BANNER_TEXT)
    print(RESET_COLOR)
    time.sleep(2)  # Pause for 2 seconds to view the banner

# ====================== 2. MATRIX ANIMATION CORE ======================
def run_matrix():
    """Main function for the Matrix falling code animation."""
    # Get terminal size
    try:
        rows, cols = os.get_terminal_size()
    except:
        rows, cols = 40, 80  # Default size if detection fails

    # Initialize data for each column: [current_row, speed_counter, speed]
    columns = []
    for _ in range(cols):
        # Start at a random row, with a random speed between 1 and 5
        columns.append([random.randint(-rows, 0), 0, random.randint(1, 5)])

    # Hide the cursor for a cleaner look[citation:4]
    sys.stdout.write('\033[?25l')
    sys.stdout.flush()

    try:
        while True:
            # Create a frame buffer to draw all at once (smoother)
            buffer = [[' ' for _ in range(cols)] for _ in range(rows)]

            for x in range(cols):
                col_data = columns[x]
                current_row, counter, speed = col_data

                # Only update this column if its speed counter is ready
                col_data[1] += 1
                if col_data[1] < speed:
                    continue
                col_data[1] = 0  # Reset counter

                # Move the head of the column down
                col_data[0] += 1

                # If the head goes off screen, reset the column
                if current_row >= rows:
                    col_data[0] = random.randint(-rows // 2, 0)
                    col_data[2] = random.randint(1, 5)  # New random speed
                    continue

                # Draw the trail for this column
                trail_length = len(COLORS)
                for i in range(trail_length):
                    draw_row = current_row - i
                    if 0 <= draw_row < rows:
                        # Pick a random character
                        char = random.choice(CHARS)
                        # Put the colored character in the buffer
                        buffer[draw_row][x] = f"{COLORS[i]}{char}{RESET_COLOR}"

            # Clear screen and draw the entire frame
            sys.stdout.write('\033[H')  # Move cursor to top-left
            for row in buffer:
                sys.stdout.write(''.join(row) + '\n')
            sys.stdout.flush()

            time.sleep(0.05)  # Control the overall animation speed

    except KeyboardInterrupt:
        # Exit gracefully on Ctrl+C
        pass
    finally:
        # Show cursor and reset colors on exit[citation:4]
        sys.stdout.write('\033[?25h' + RESET_COLOR)
        sys.stdout.flush()
        print("\n\n\033[92m[+] Animation terminated.\033[0m")

# ====================== MAIN EXECUTION ======================
if __name__ == "__main__":
    # Handle Ctrl+C gracefully
    signal.signal(signal.SIGINT, lambda s, f: sys.exit(0))

    # Step 1: Show the hacker banner
    show_banner()

    # Step 2: Start the Matrix animation
    run_matrix()