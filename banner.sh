#!/bin/bash

# Colors for modern UI
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Banner directory
BANNER_DIR="$HOME/.termux"
BANNER_FILE="$BANNER_DIR/banner.txt"
PROP_FILE="$BANNER_DIR/termux.properties"

# Animation function
animate_text() {
    local text="$1"
    local color="$2"
    for (( i=0; i<${#text}; i++ )); do
        echo -ne "${color}${text:$i:1}${NC}"
        sleep 0.03
    done
    echo
}

# Modern header
show_header() {
    clear
    echo -e "${CYAN}"
    echo "╔══════════════════════════════════════════════╗"
    echo "║              TERMUX BANNER MANAGER           ║"
    echo "║              Modern Custom Banner            ║"
    echo "╚══════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Check if banner directory exists
check_dir() {
    if [ ! -d "$BANNER_DIR" ]; then
        mkdir -p "$BANNER_DIR"
    fi
}

# Create modern banner
create_banner() {
    show_header
    echo -e "${YELLOW}[*] Creating Custom Banner${NC}"
    echo
    
    # Get user input for banner text
    echo -e "${GREEN}Enter your banner text:${NC}"
    read -r banner_text
    
    if [ -z "$banner_text" ]; then
        echo -e "${RED}[!] Banner text cannot be empty!${NC}"
        sleep 2
        return
    fi
    
    # Color selection
    echo -e "${GREEN}Choose banner color:${NC}"
    echo -e "1. ${RED}Red${NC}"
    echo -e "2. ${GREEN}Green${NC}"
    echo -e "3. ${YELLOW}Yellow${NC}"
    echo -e "4. ${BLUE}Blue${NC}"
    echo -e "5. ${PURPLE}Purple${NC}"
    echo -e "6. ${CYAN}Cyan${NC}"
    echo -e "7. ${WHITE}White${NC}"
    echo -n "Select (1-7): "
    read -r color_choice
    
    case $color_choice in
        1) COLOR=$RED ;;
        2) COLOR=$GREEN ;;
        3) COLOR=$YELLOW ;;
        4) COLOR=$BLUE ;;
        5) COLOR=$PURPLE ;;
        6) COLOR=$CYAN ;;
        7) COLOR=$WHITE ;;
        *) COLOR=$CYAN ;;
    esac
    
    # Style selection
    echo -e "${GREEN}Choose banner style:${NC}"
    echo "1. Simple Text"
    echo "2. Boxed Text"
    echo "3. Double Line Box"
    echo "4. Modern Header"
    echo -n "Select (1-4): "
    read -r style_choice
    
    # Create banner based on style
    case $style_choice in
        1)
            echo -e "${COLOR}$banner_text${NC}" > "$BANNER_FILE"
            ;;
        2)
            {
                echo -e "${COLOR}╔════════════════════════════════════╗${NC}"
                echo -e "${COLOR}║           $banner_text           ║${NC}"
                echo -e "${COLOR}╚════════════════════════════════════╝${NC}"
            } > "$BANNER_FILE"
            ;;
        3)
            {
                echo -e "${COLOR}╔══════════════════════════════════════════╗${NC}"
                echo -e "${COLOR}║                                          ║${NC}"
                echo -e "${COLOR}║           $banner_text           ║${NC}"
                echo -e "${COLOR}║                                          ║${NC}"
                echo -e "${COLOR}╚══════════════════════════════════════════╝${NC}"
            } > "$BANNER_FILE"
            ;;
        4)
            {
                echo -e "${COLOR}┌──────────────────────────────────────────┐${NC}"
                echo -e "${COLOR}│   ╔╦╗┬ ┬┌─┐┌┐┌┌┬┐  ┌─┐┌┬┐┌─┐┌─┐┌─┐┌┬┐     │${NC}"
                echo -e "${COLOR}│   ║║║│ │├─┤│││ ││  ├┤ │││├─┤├─┘├─┤│││     │${NC}"
                echo -e "${COLOR}│   ╩ ╩└─┘┴ ┴┘└┘─┴┘  └─┘┴ ┴┴ ┴┴  ┴ ┴┴ ┴     │${NC}"
                echo -e "${COLOR}├──────────────────────────────────────────┤${NC}"
                echo -e "${COLOR}│           $banner_text           │${NC}"
                echo -e "${COLOR}└──────────────────────────────────────────┘${NC}"
            } > "$BANNER_FILE"
            ;;
        *)
            echo -e "${COLOR}$banner_text${NC}" > "$BANNER_FILE"
            ;;
    esac
    
    # Update termux.properties
    update_termux_properties
    
    echo -e "${GREEN}[✓] Banner created successfully!${NC}"
    echo -e "${YELLOW}[*] Restart Termux to see changes${NC}"
    sleep 3
}

# Update termux properties with modern theme
update_termux_properties() {
    cat > "$PROP_FILE" << EOF
# Termux properties updated by Banner Manager
# UI Theme Settings
use-black-ui = false
background = rgba(13, 17, 23, 0.95)
foreground = #58a6ff

# Terminal Colors
color_0 = #484f58
color_1 = #ff7b72
color_2 = #3fb950
color_3 = #d29922
color_4 = #58a6ff
color_5 = #bc8cff
color_6 = #39c5cf
color_7 = #b1bac4
color_8 = #6e7681
color_9 = #ffa198
color_10 = #56d364
color_11 = #e3b341
color_12 = #79c0ff
color_13 = #d2a8ff
color_14 = #56d4dd
color_15 = #f0f6fc

# Font Settings
font = JetBrains Mono
additional-bold-fonts = JetBrains Mono Bold

# Cursor Settings
cursor-style = block
cursor-blink-rate = 500

# Bell Settings
bell-character = beep
bell-volume = 0

# Miscellaneous
allow-external-apps = false
back-button-behavior = back
enforce-char-based-input = false
fullscreen = false
ctrl-space-workaround = true
soft-keyboard-theme = dark
EOF
}

# Remove banner
remove_banner() {
    show_header
    echo -e "${YELLOW}[*] Removing Banner${NC}"
    
    if [ -f "$BANNER_FILE" ]; then
        rm "$BANNER_FILE"
        echo -e "${GREEN}[✓] Banner removed successfully!${NC}"
    else
        echo -e "${RED}[!] No banner found to remove${NC}"
    fi
    
    # Reset termux properties
    if [ -f "$PROP_FILE" ]; then
        rm "$PROP_FILE"
        echo -e "${GREEN}[✓] Theme reset to default${NC}"
    fi
    
    echo -e "${YELLOW}[*] Restart Termux to see changes${NC}"
    sleep 3
}

# Show information
show_info() {
    show_header
    echo -e "${GREEN}Termux Banner Manager Information${NC}"
    echo "=================================="
    echo -e "${CYAN}Version:${NC} 2.0 Modern"
    echo -e "${CYAN}Author:${NC} Termux Community"
    echo -e "${CYAN}Features:${NC}"
    echo -e "  • Custom banner text"
    echo -e "  • Multiple color options"
    echo -e "  • Different banner styles"
    echo -e "  • Synchronized theme"
    echo -e "  • Modern UI design"
    echo
    echo -e "${YELLOW}Banner File:${NC} $BANNER_FILE"
    echo -e "${YELLOW}Theme File:${NC} $PROP_FILE"
    echo
    echo -e "${GREEN}Press any key to continue...${NC}"
    read -n 1
}

# Main menu
main_menu() {
    while true; do
        show_header
        
        # Animated menu options
        echo -e "${GREEN}Available Options:${NC}"
        echo
        animate_text "1. Banner Set" "$GREEN"
        animate_text "2. Banner Remove" "$RED"
        animate_text "3. Info" "$BLUE"
        animate_text "4. Exit" "$YELLOW"
        echo
        echo -n "Select option (1-4): "
        
        read -r choice
        case $choice in
            1)
                create_banner
                ;;
            2)
                remove_banner
                ;;
            3)
                show_info
                ;;
            4)
                echo -e "${GREEN}[✓] Thank you for using Termux Banner Manager!${NC}"
                echo -e "${CYAN}Goodbye! 👋${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}[!] Invalid option! Please select 1-4${NC}"
                sleep 2
                ;;
        esac
    done
}

# Initialize
check_dir

# Check if running in Termux
if [ ! -d "/data/data/com.termux/files/usr" ]; then
    echo -e "${RED}[!] This script is designed to run in Termux${NC}"
    exit 1
fi

# Start the application
main_menu
