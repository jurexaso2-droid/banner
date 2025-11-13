#!/bin/bash
# Custom Termux Banner Script with ASCII Art & Styling
# Author: GPT-5

clear
echo -e "\e[1;32m=========================================="
echo -e "\e[1;33m     CUSTOM TERMUX BANNER CREATOR"
echo -e "\e[1;32m=========================================="
echo ""

# Check dependencies
pkg install figlet toilet -y > /dev/null 2>&1

echo -e "\e[1;36mEnter your banner text:\e[0m"
read banner_text
echo ""

echo -e "\e[1;36mChoose an ASCII style:\e[0m"
echo -e "\e[1;33m[1]\e[0m Figlet (simple)"
echo -e "\e[1;33m[2]\e[0m Toilet (stylish)"
read -p "Enter number: " ascii_choice
echo ""

echo -e "\e[1;36mChoose a text color:\e[0m"
echo -e "\e[1;31m[1]\e[0m Red"
echo -e "\e[1;32m[2]\e[0m Green"
echo -e "\e[1;33m[3]\e[0m Yellow"
echo -e "\e[1;34m[4]\e[0m Blue"
echo -e "\e[1;35m[5]\e[0m Magenta"
echo -e "\e[1;36m[6]\e[0m Cyan"
echo -e "\e[1;37m[7]\e[0m White"
read -p "Enter color number: " color_choice
echo ""

# Color mapping
case $color_choice in
  1) color_code="\e[1;31m" ;;
  2) color_code="\e[1;32m" ;;
  3) color_code="\e[1;33m" ;;
  4) color_code="\e[1;34m" ;;
  5) color_code="\e[1;35m" ;;
  6) color_code="\e[1;36m" ;;
  7) color_code="\e[1;37m" ;;
  *) color_code="\e[1;37m" ;;
esac

# Text style options
echo -e "\e[1;36mChoose text style:\e[0m"
echo -e "[1] Normal"
echo -e "[2] Bold"
echo -e "[3] Underline"
echo -e "[4] Italic (toilet only)"
read -p "Enter number: " style_choice
echo ""

case $style_choice in
  1) style_code="" ;;
  2) style_code="\e[1m" ;;
  3) style_code="\e[4m" ;;
  4) style_code="\e[3m" ;;
  *) style_code="" ;;
esac

# Generate ASCII banner preview
clear
echo -e "\e[1;32mGenerating preview...\e[0m"
echo ""
sleep 1

if [ "$ascii_choice" == "1" ]; then
  figlet "$banner_text"
else
  toilet -f bigascii12 "$banner_text"
fi

echo ""
read -p "Would you like to set this as your Termux banner? (y/n): " confirm

if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
  echo "clear" > /data/data/com.termux/files/usr/etc/bash.bashrc
  echo -e "echo -e '${color_code}${style_code}'" >> /data/data/com.termux/files/usr/etc/bash.bashrc
  if [ "$ascii_choice" == "1" ]; then
    echo "figlet \"$banner_text\"" >> /data/data/com.termux/files/usr/etc/bash.bashrc
  else
    echo "toilet -f bigascii12 \"$banner_text\"" >> /data/data/com.termux/files/usr/etc/bash.bashrc
  fi
  echo -e "echo -e '\e[0m'" >> /data/data/com.termux/files/usr/etc/bash.bashrc
  clear
  echo -e "\e[1;32m✅ Custom banner successfully applied!"
  echo -e "\e[1;33mRestart Termux to see your new look.\e[0m"
else
  echo -e "\e[1;31mCancelled.\e[0m"
fi
