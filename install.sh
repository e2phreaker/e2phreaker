#!/data/data/com.termux/files/usr/bin/bash

clear
echo "===================================="
echo " 🚀 MediaMatrix Installer"
echo "===================================="

# =========================
# CONFIG
# =========================
REPO="https://raw.githubusercontent.com/USERNAME/REPO/main"
WORKDIR="$HOME/MediaMatrix"

# =========================
# STORAGE PERMISSION
# =========================
if [ ! -d "$HOME/storage" ]; then
    echo "📂 Setup storage permission..."
    termux-setup-storage
fi

# =========================
# UPDATE SYSTEM
# =========================
echo ""
echo "📦 Updating system..."
apt update -y && apt upgrade -y

# =========================
# INSTALL DEPENDENCIES
# =========================
echo ""
echo "📦 Installing dependencies..."

apt install -y python ffmpeg curl

# =========================
# INSTALL YT-DLP
# =========================
if ! command -v yt-dlp >/dev/null 2>&1; then
    echo "⬇️ Installing yt-dlp..."
    pip install -U yt-dlp
else
    echo "✅ yt-dlp already installed"
fi

# =========================
# CREATE WORKDIR
# =========================
mkdir -p "$WORKDIR"
cd "$WORKDIR" || exit

# =========================
# DOWNLOAD SCRIPT
# =========================
echo ""
echo "⬇️ Downloading MediaMatrix tools..."

curl -fLO "$REPO/prompt-aio-audio.sh" || { echo "❌ Gagal download audio script"; exit 1; }
curl -fLO "$REPO/prompt-aio-video.sh" || { echo "❌ Gagal download video script"; exit 1; }
curl -fLO "$REPO/prompt-aio-yt-dlp.sh" || { echo "❌ Gagal download yt-dlp script"; exit 1; }
curl -fLO "$REPO/mediamatrix.sh" || { echo "❌ Gagal download launcher"; exit 1; }

# =========================
# FIX FORMAT (CRLF)
# =========================
echo ""
echo "🔧 Fixing script format..."

sed -i 's/\r$//' *.sh

# =========================
# PERMISSION
# =========================
chmod +x *.sh

# =========================
# SET ALIAS (ONLY 1)
# =========================
echo ""
echo "⚙️ Setting alias..."

BASHRC="$HOME/.bashrc"

# hapus alias lama (biar bersih)
sed -i '/alias matrix=/d' "$BASHRC"
sed -i '/alias audio=/d' "$BASHRC"
sed -i '/alias video=/d' "$BASHRC"
sed -i '/alias ytp=/d' "$BASHRC"

# tambah alias baru
echo "alias matrix='$WORKDIR/mediamatrix.sh'" >> "$BASHRC"

# =========================
# RELOAD BASHRC
# =========================
source "$BASHRC"

# =========================
# DONE
# =========================
clear
echo "===================================="
echo " ✅ INSTALLATION COMPLETE"
echo "===================================="
echo ""
echo "📦 MediaMatrix berhasil diinstall!"
echo ""
echo "👉 Jalankan dengan perintah:"
echo ""
echo "   matrix"
echo ""
echo "===================================="