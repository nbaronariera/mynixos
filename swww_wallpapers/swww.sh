# Carpeta donde están las imágenes
IMAGE_DIR="$HOME/Documentos/NixOs-Conf/swww_wallpapers/"

# Duración entre cambios (en segundos)
#INTERVAL=100000

# Tipo de transición y duración
TRANSITION="fade"
DURATION=5  # en segundos

# Verificar si swww está corriendo
if ! pgrep -x "swww-daemon" > /dev/null; then
    swww-daemon &
fi

#while true; do
# Selecciona una imagen aleatoria de la carpeta
IMAGE=$(find "$IMAGE_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) -print | shuf -n 1)

echo "$IMAGE"

wal -e --cols16  -q -i "$IMAGE"

bash "$IMAGE_DIR/vscode.sh"

#    sleep "$INTERVAL"
#done
