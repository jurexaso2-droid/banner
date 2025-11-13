#!/bin/bash
# Enhanced Termux Banner Script with Advanced Styling
# Author: GPT-5 (Enhanced)

clear
echo -e "\e[1;38;5;51m╔════════════════════════════════════════════════╗"
echo -e "\e[1;38;5;51m║              \e[1;38;5;226mTERMUX BANNER CUSTOMIZER\e[1;38;5;51m              ║"
echo -e "\e[1;38;5;51m║          \e[1;38;5;226mCreate Your Unique Terminal Look\e[1;38;5;51m          ║"
echo -e "\e[1;38;5;51m╚════════════════════════════════════════════════╝\e[0m"
echo ""

# Check and install dependencies
echo -e "\e[1;38;5;214m📦 Checking dependencies...\e[0m"
pkg install figlet toilet lolcat neofetch -y > /dev/null 2>&1

# Banner text input
echo -e "\e[1;38;5;85m🎯 Enter your banner text:\e[0m"
read -p "> " banner_text
echo ""

# ASCII style selection with better options
echo -e "\e[1;38;5;85m🎨 Choose ASCII style:\e[0m"
echo -e "\e[1;38;5;45m[1]\e[0m Figlet Standard"
echo -e "\e[1;38;5;45m[2]\e[0m Toilet Thin"
echo -e "\e[1;38;5;45m[3]\e[0m Toilet Mono9"
echo -e "\e[1;38;5;45m[4]\e[0m Toilet Big"
echo -e "\e[1;38;5;45m[5]\e[0m Toilet Future"
read -p "Enter choice [1-5]: " ascii_choice
echo ""

# Enhanced color selection with RGB colors
echo -e "\e[1;38;5;85m🌈 Choose text color:\e[0m"
echo -e "\e[38;5;196m[1] Red\e[0m        \e[38;5;46m[2] Green\e[0m       \e[38;5;226m[3] Yellow\e[0m"
echo -e "\e[38;5;21m[4] Blue\e[0m        \e[38;5;201m[5] Magenta\e[0m    \e[38;5;51m[6] Cyan\e[0m"
echo -e "\e[38;5;255m[7] White\e[0m      \e[38;5;214m[8] Orange\e[0m     \e[38;5;85m[9] Lime\e[0m"
echo -e "\e[38;5;93m[10] Purple\e[0m    \e[38;5;208m[11] Amber\e[0m     \e[38;5;200m[12] Pink\e[0m"
read -p "Enter color [1-12]: " color_choice
echo ""

# RGB color mapping
case $color_choice in
  1) color_code="\e[38;5;196m" ;;   # Red
  2) color_code="\e[38;5;46m" ;;    # Green
  3) color_code="\e[38;5;226m" ;;   # Yellow
  4) color_code="\e[38;5;21m" ;;    # Blue
  5) color_code="\e[38;5;201m" ;;   # Magenta
  6) color_code="\e[38;5;51m" ;;    # Cyan
  7) color_code="\e[38;5;255m" ;;   # White
  8) color_code="\e[38;5;214m" ;;   # Orange
  9) color_code="\e[38;5;85m" ;;    # Lime
  10) color_code="\e[38;5;93m" ;;   # Purple
  11) color_code="\e[38;5;208m" ;;  # Amber
  12) color_code="\e[38;5;200m" ;;  # Pink
  *) color_code="\e[38;5;51m" ;;    # Default Cyan
esac

# Text style with more options
echo -e "\e[1;38;5;85m✨ Choose text style:\e[0m"
echo -e "[1] Normal"
echo -e "[2] Bold"
echo -e "[3] Underline"
echo -e "[4] Italic"
echo -e "[5] Blinking"
echo -e "[6] Rainbow (lolcat)"
read -p "Enter style [1-6]: " style_choice
echo ""

case $style_choice in
  1) style_code="" ;;
  2) style_code="\e[1m" ;;
  3) style_code="\e[4m" ;;
  4) style_code="\e[3m" ;;
  5) style_code="\e[5m" ;;
  6) style_code="rainbow" ;;
  *) style_code="" ;;
esac

# System info display option
echo -e "\e[1;38;5;85m🔧 Include system information?\e[0m"
echo -e "[1] Yes - Show device info below banner"
echo -e "[2] No - Only show banner"
read -p "Enter choice [1-2]: " sysinfo_choice
echo ""

# Generate preview
clear
echo -e "\e[1;38;5;214m🎭 Generating preview...\e[0m"
echo -e "\e[1;38;5;45m┌────────────────────────────────────────────────┐\e[0m"
echo ""

# Generate banner based on choices
if [ "$style_code" == "rainbow" ]; then
  if [ "$ascii_choice" == "1" ]; then
    figlet "$banner_text" | lolcat
  elif [ "$ascii_choice" == "2" ]; then
    toilet -f thin "$banner_text" | lolcat
  elif [ "$ascii_choice" == "3" ]; then
    toilet -f mono9 "$banner_text" | lolcat
  elif [ "$ascii_choice" == "4" ]; then
    toilet -f big "$banner_text" | lolcat
  else
    toilet -f future "$banner_text" | lolcat
  fi
else
  echo -ne "${color_code}${style_code}"
  case $ascii_choice in
    1) figlet "$banner_text" ;;
    2) toilet -f thin "$banner_text" ;;
    3) toilet -f mono9 "$banner_text" ;;
    4) toilet -f big "$banner_text" ;;
    5) toilet -f future "$banner_text" ;;
    *) figlet "$banner_text" ;;
  esac
  echo -ne "\e[0m"
fi

echo ""
echo -e "\e[1;38;5;45m└────────────────────────────────────────────────┘\e[0m"
echo ""

# Apply banner
read -p "Would you like to set this as your Termux banner? (y/n): " confirm

if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
  # Backup original bash.bashrc
  if [ ! -f /data/data/com.termux/files/usr/etc/bash.bashrc.backup ]; then
    cp /data/data/com.termux/files/usr/etc/bash.bashrc /data/data/com.termux/files/usr/etc/bash.bashrc.backup
  fi
  
  # Create new bash.bashrc
  cat > /data/data/com.termux/files/usr/etc/bash.bashrc << EOF
#!/bin/bash
# Custom Termux Banner
# Generated: $(date)

clear
echo ""
EOF

  # Add banner to bash.bashrc
  if [ "$style_code" == "rainbow" ]; then
    case $ascii_choice in
      1) echo "figlet \"$banner_text\" | lolcat" >> /data/data/com.termux/files/usr/etc/bash.bashrc ;;
      2) echo "toilet -f thin \"$banner_text\" | lolcat" >> /data/data/com.termux/files/usr/etc/bash.bashrc ;;
      3) echo "toilet -f mono9 \"$banner_text\" | lolcat" >> /data/data/com.termux/files/usr/etc/bash.bashrc ;;
      4) echo "toilet -f big \"$banner_text\" | lolcat" >> /data/data/com.termux/files/usr/etc/bash.bashrc ;;
      5) echo "toilet -f future \"$banner_text\" | lolcat" >> /data/data/com.termux/files/usr/etc/bash.bashrc ;;
    esac
  else
    echo -n "echo -e '${color_code}${style_code}'" >> /data/data/com.termux/files/usr/etc/bash.bashrc
    echo "" >> /data/data/com.termux/files/usr/etc/bash.bashrc
    case $ascii_choice in
      1) echo "figlet \"$banner_text\"" >> /data/data/com.termux/files/usr/etc/bash.bashrc ;;
      2) echo "toilet -f thin \"$banner_text\"" >> /data/data/com.termux/files/usr/etc/bash.bashrc ;;
      3) echo "toilet -f mono9 \"$banner_text\"" >> /data/data/com.termux/files/usr/etc/bash.bashrc ;;
      4) echo "toilet -f big \"$banner_text\"" >> /data/data/com.termux/files/usr/etc/bash.bashrc ;;
      5) echo "toilet -f future \"$banner_text\"" >> /data/data/com.termux/files/usr/etc/bash.bashrc ;;
    esac
    echo "echo -e '\e[0m'" >> /data/data/com.termux/files/usr/etc/bash.bashrc
  fi

  # Add system information if selected
  if [ "$sysinfo_choice" == "1" ]; then
    cat >> /data/data/com.termux/files/usr/etc/bash.bashrc << EOF

echo -e "\e[1;38;5;45m┌─────────────────── System Info ───────────────────┐\e[0m"
echo -e "\e[1;38;5;226m💻 Device: \e[1;37m\$(uname -n)"
echo -e "\e[1;38;5;226m🖥️  Arch: \e[1;37m\$(uname -m)"
echo -e "\e[1;38;5;226m📱 OS: \e[1;37m\$(uname -o)"
echo -e "\e[1;38;5;226m⏰ Uptime: \e[1;37m\$(uptime -p | sed 's/up //')"
echo -e "\e[1;38;5;226m📅 Date: \e[1;37m\$(date '+%A, %B %d, %Y %H:%M:%S')"
echo -e "\e[1;38;5;45m└────────────────────────────────────────────────┘\e[0m"
EOF
  fi

  # Add custom LS colors and prompt
  cat >> /data/data/com.termux/files/usr/etc/bash.bashrc << EOF

# Custom LS colors
export LS_OPTIONS='--color=auto'
alias ls='ls \$LS_OPTIONS'
alias ll='ls \$LS_OPTIONS -l'
alias la='ls \$LS_OPTIONS -la'

# Custom prompt
PS1='\\[\\e[1;38;5;214m\\]┌─[\\[\\e[1;38;5;51m\\]\\u\\[\\e[1;38;5;214m\\]@\\[\\e[1;38;5;85m\\]\\h\\[\\e[1;38;5;214m\\]]-[\\[\\e[1;38;5;226m\\]\\w\\[\\e[1;38;5;214m\\]\\]\\n\\[\\e[1;38;5;214m\\]└─[\\[\\e[1;38;5;201m\\]\\$\\[\\e[1;38;5;214m\\]]>\\[\\e[0m\\] '

echo ""
echo -e "\e[1;38;5;46m✅ Welcome to your customized Termux environment!\e[0m"
echo ""
EOF

  clear
  echo -e "\e[1;38;5;46m"
  figlet "Success!"
  echo -e "\e[0m"
  echo -e "\e[1;38;5;214m✅ Custom banner successfully applied!"
  echo -e "📁 Backup created: \e[1;37mbash.bashrc.backup\e[0m"
  echo -e "🎨 LS colors and prompt customized"
  echo -e "🔧 Restart Termux to see your new look!\e[0m"
  echo ""
  echo -e "\e[1;38;5;45m💡 Tip: Use 'ls' to see colored directory listing\e[0m"
else
  echo -e "\e[1;38;5;196m❌ Operation cancelled.\e[0m"
fi
