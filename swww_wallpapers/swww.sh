# Carpeta donde están las imágenes
IMAGE_DIR="$HOME/Documentos/NixOs-Conf/swww_wallpapers/"

# Tipo de transición y duración
TRANSITION="fade"
DURATION=5  # en segundos

swww-daemon &

# Selecciona una imagen aleatoria de la carpeta
IMAGE=$(find "$IMAGE_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) -print | shuf -n 1)

echo "$IMAGE"

wal -e --cols16  -q -i "$IMAGE"

bash "$IMAGE_DIR/vscode.sh"

