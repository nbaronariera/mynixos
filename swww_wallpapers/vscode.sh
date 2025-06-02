# Ruta al archivo de configuración de VS Code
VSCODE_SETTINGS="$HOME/.config/Code/User/settings.json"

# Extraer colores de pywal
BACKGROUND=$(jq -r '.special.background' ~/.cache/wal/colors.json)
FOREGROUND=$(jq -r '.special.foreground' ~/.cache/wal/colors.json)
COLOR0=$(jq -r '.colors.color0' ~/.cache/wal/colors.json)
COLOR1=$(jq -r '.colors.color1' ~/.cache/wal/colors.json)
COLOR2=$(jq -r '.colors.color2' ~/.cache/wal/colors.json)
COLOR3=$(jq -r '.colors.color3' ~/.cache/wal/colors.json)
COLOR4=$(jq -r '.colors.color4' ~/.cache/wal/colors.json)
COLOR5=$(jq -r '.colors.color5' ~/.cache/wal/colors.json)
COLOR6=$(jq -r '.colors.color6' ~/.cache/wal/colors.json)
COLOR7=$(jq -r '.colors.color7' ~/.cache/wal/colors.json)

# Modificar el archivo settings.json de VS Code
jq ". + {
  \"workbench.colorCustomizations\": {
    \"editor.background\": \"$BACKGROUND\",
    \"editor.foreground\": \"$FOREGROUND\",
    \"activityBar.background\": \"$COLOR1\",
    \"sideBar.background\": \"$COLOR0\",
    \"editorCursor.foreground\": \"$COLOR4\",
    \"terminal.foreground\": \"$FOREGROUND\"
  }
}" "$VSCODE_SETTINGS" > "$VSCODE_SETTINGS.tmp" && mv "$VSCODE_SETTINGS.tmp" "$VSCODE_SETTINGS"

echo "Estilo de vs completado"
