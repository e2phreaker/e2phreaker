#!/data/data/com.termux/files/usr/bin/bash

WORKDIR="$HOME/MediaMatrix"

# =========================
# CONFIG UPDATE
# =========================
VERSION="1.0"
REPO="https://raw.githubusercontent.com/USERNAME/REPO/main"

# =========================
# WARNA
# =========================
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
CYAN="\e[36m"
RESET="\e[0m"

# =========================
# CEK UPDATE
# =========================
check_update() {
    echo ""
    echo "🔍 Mengecek update..."

    latest=$(curl -s "$REPO/version.txt")

    echo ""
    echo "📦 Versi lokal : $VERSION"
    echo "🌐 Versi terbaru: $latest"

    if [ "$latest" != "$VERSION" ]; then
        echo -e "${YELLOW}⚠️ Update tersedia!${RESET}"
    else
        echo -e "${GREEN}✅ Sudah versi terbaru${RESET}"
    fi
}

# =========================
# DRAW MENU
# =========================
draw_menu() {
    clear
    echo -e "${CYAN}╔══════════════════════════════╗${RESET}"
    echo -e "${CYAN}║   🎛️ MediaMatrix Suite      ║${RESET}"
    echo -e "${CYAN}╠══════════════════════════════╣${RESET}"
    echo -e "${CYAN}║${RESET} ${YELLOW}1) 🎵 AudioMatrix Pro${RESET}      ${CYAN}║${RESET}"
    echo -e "${CYAN}║${RESET} ${YELLOW}2) 🎬 VideoMatrix Engine${RESET}  ${CYAN}║${RESET}"
    echo -e "${CYAN}║${RESET} ${YELLOW}3) 📺 StreamMatrix Pro${RESET}   ${CYAN}║${RESET}"
    echo -e "${CYAN}║${RESET} ${YELLOW}9) 🔍 Cek Update${RESET}         ${CYAN}║${RESET}"
    echo -e "${CYAN}╠══════════════════════════════╣${RESET}"
    echo -e "${CYAN}║${RESET} ${RED}0) ❌ Keluar${RESET}              ${CYAN}║${RESET}"
    echo -e "${CYAN}╚══════════════════════════════╝${RESET}"
}

# =========================
# LOOP
# =========================
while true; do
    draw_menu

    echo ""
    read -p "Pilih menu: " menu

    case $menu in
        1)
            clear
            bash "$WORKDIR/prompt-aio-audio.sh"
            ;;
        2)
            clear
            bash "$WORKDIR/prompt-aio-video.sh"
            ;;
        3)
            clear
            bash "$WORKDIR/prompt-aio-yt-dlp.sh"
            ;;
        9)
            check_update
            echo ""
            read -p "ENTER untuk kembali..."
            ;;
        0)
            echo -e "${RED}Keluar...${RESET}"
            break
            ;;
        *)
            echo -e "${RED}❌ Pilihan tidak valid${RESET}"
            sleep 1
            ;;
    esac
done