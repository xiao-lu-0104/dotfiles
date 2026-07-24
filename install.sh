cat > ~/.dotfiles/install.sh << 'EOF'
#!/usr/bin/env bash

# dotfiles 目录
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 要链接的文件列表
files=(
    "bashrc:.bashrc"
    "vimrc:.vimrc"
    "gitconfig:.gitconfig"
)

# 创建软链接
for file in "${files[@]}"; do
    src="${file%%:*}"
    dst="${file##*:}"
    if [ -e "$HOME/$dst" ] && [ ! -L "$HOME/$dst" ]; then
        echo "Backing up existing $dst to $dst.bak"
        mv "$HOME/$dst" "$HOME/$dst.bak"
    fi
    ln -sf "$DOTFILES_DIR/$src" "$HOME/$dst"
    echo "Linked $src -> $HOME/$dst"
done

echo "Dotfiles installed successfully!"
EOF

chmod +x ~/.dotfiles/install.sh
