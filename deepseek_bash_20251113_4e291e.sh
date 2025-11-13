cat > ~/banner.sh << 'EOF'
#!/bin/bash

# Colors for modern UI
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# Banner directory
BANNER_DIR="$HOME/.termux"
BANNER_FILE="$BANNER_DIR/motd"
PROP_FILE="$BANNER_DIR/termux.properties"

show_header() {
    clear
    echo -e "${CYAN}"
    echo "╔══════════════════════════════════════════════╗"
    echo "║              TERMUX BANNER MANAGER           ║"
    echo "║                 Easy Setup                   ║"
    echo "╚══════════════════════════════════════════════╝"
    echo -e "${NC}"
}

check_dir() {
    if [ ! -d "$BANNER_DIR" ]; then
        mkdir -p "$BANNER_DIR"
        echo -e "${GREEN}[✓] Created directory${NC}"
    fi
}

create_banner() {
    show_header
    echo -e "${YELLOW}[*] Creating Custom Banner${NC}"
    echo
    
    echo -e "${GREEN}Enter your banner text:${NC}"
    read -r banner_text
    
    if [ -z "$banner_text" ]; then
        echo -e "${RED}[!] Banner text cannot be empty!${NC}"
        sleep 2
        return
    fi
    
    echo -e "${GREEN}Choose banner style:${NC}"
    echo "1. Simple Text"
    echo "2. Box Style" 
    echo "3. Modern Style"
    echo -n "Select (1-3): "
    read -r style_choice
    
    case $style_choice in
        1)
            echo "$banner_text" > "$BANNER_FILE"
            ;;
        2)
            cat > "$BANNER_FILE" << EOB
╔════════════════════════════════════╗
║           $banner_text           ║
╚════════════════════════════════════╝
EOB
            ;;
        3)
            cat > "$BANNER_FILE" << EOB
┌────────────────────────────────────┐
│                                    │
│           $banner_text           │
│                                    │
└────────────────────────────────────┘
EOB
            ;;
        *)
            echo "$banner_text" > "$BANNER_FILE"
            ;;
    esac
    
    update_termux_properties
    
    echo -e "${GREEN}[✓] Banner created successfully!${NC}"
    echo -e "${YELLOW}[*] Close and reopen Termux to see your banner${NC}"
    echo -e "${BLUE}Press any key to continue...${NC}"
    read -n 1
}

update_termux_properties() {
    cat > "$PROP_FILE" << EOP
# Termux Theme - Modern Dark
use-black-ui = false
background = rgba(13, 17, 23, 0.95)
foreground = #58a6ff

# Colors
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

# Font
font = JetBrains Mono
EOP
}

remove_banner() {
    show_header
    echo -e "${YELLOW}[*] Removing Banner${NC}"
    
    if [ -f "$BANNER_FILE" ]; then
        rm "$BANNER_FILE"
        echo -e "${GREEN}[✓] Banner removed!${NC}"
    else
        echo -e "${RED}[!] No banner found${NC}"
    fi
    
    if [ -f "$PROP_FILE" ]; then
        rm "$PROP_FILE"
        echo -e "${GREEN}[✓] Theme reset to default${NC}"
    fi
    
    echo -e "${YELLOW}[*] Close and reopen Termux${NC}"
    echo -e "${BLUE}Press any key to continue...${NC}"
    read -n 1
}

show_info() {
    show_header
    echo -e "${GREEN}Termux Banner Manager${NC}"
    echo "======================"
    echo "For beginners - Easy to use!"
    echo "Files created:"
    echo "• ~/.termux/motd (banner)"
    echo "• ~/.termux/termux.properties (theme)"
    echo
    echo -e "${BLUE}Press any key to continue...${NC}"
    read -n 1
}

main_menu() {
    while true; do
        show_header
        echo -e "${GREEN}Choose option:${NC}"
        echo
        echo "1. Create Banner"
        echo "2. Remove Banner" 
        echo "3. Info"
        echo "4. Exit"
        echo
        echo -n "Select (1-4): "
        
        read -r choice
        case $choice in
            1) create_banner ;;
            2) remove_banner ;;
            3) show_info ;;
            4) 
                echo -e "${GREEN}Thanks for using! Goodbye! 👋${NC}"
                exit 0 
                ;;
            *)
                echo -e "${RED}Invalid choice! Press any key...${NC}"
                read -n 1
                ;;
        esac
    done
}

check_dir
main_menu
EOF

# Make it executable
chmod +x ~/banner.sh
echo -e "\033[1;32m[✓] Banner script created successfully!\033[0m"
echo -e "\033[1;36mRun this command to start: ./banner.sh\033[0m"