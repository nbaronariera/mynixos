# Move to Gradience directory
cd $HOME/.config/presets/user

# Create symlink
ln -s $HOME/.cache/wal/pywal.json 

# Move to Kvantum directory
cd $HOME/.config/Kvantum

# Create theme directory and cd into it
mkdir pywal
cd pywal

# Create symlinks
ln -s $HOME/.cache/wal/pywal.kvconfig
ln -s $HOME/.cache/wal/pywal.svg

echo gtk completado