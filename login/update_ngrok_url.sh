#!/bin/bash

# 🔄 Script para actualizar la URL de ngrok en app_config.dart
# Uso: ./update_ngrok_url.sh

echo "🔍 Obteniendo URL de ngrok..."

# Obtener URL de ngrok
NGROK_URL=$(curl -s http://127.0.0.1:4040/api/tunnels 2>/dev/null | python3 -c "import sys, json; data = json.load(sys.stdin); print(data['tunnels'][0]['public_url'] if data.get('tunnels') else '')" 2>/dev/null)

if [ -z "$NGROK_URL" ]; then
    echo "❌ Error: No se pudo obtener la URL de ngrok"
    echo "💡 Asegúrate de que ngrok esté corriendo: ngrok http 3000"
    exit 1
fi

echo "✅ URL de ngrok obtenida: $NGROK_URL"
echo ""

# Archivo de configuración
CONFIG_FILE="lib/config/app_config.dart"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "❌ Error: No se encontró $CONFIG_FILE"
    exit 1
fi

# Leer la URL actual
CURRENT_URL=$(grep "_ngrokUrl =" "$CONFIG_FILE" | sed "s/.*'\(.*\)'.*/\1/")

echo "📝 URL actual en app_config.dart: $CURRENT_URL"

if [ "$CURRENT_URL" = "$NGROK_URL" ]; then
    echo "✅ La URL ya está actualizada"
    exit 0
fi

echo "🔄 Actualizando URL en $CONFIG_FILE..."

# Hacer backup
cp "$CONFIG_FILE" "$CONFIG_FILE.backup"

# Actualizar la URL usando sed (compatible con macOS)
sed -i '' "s|static const String _ngrokUrl =.*|static const String _ngrokUrl = '$NGROK_URL';|" "$CONFIG_FILE"

echo "✅ URL actualizada correctamente"
echo ""
echo "Nueva configuración:"
echo "  $_ngrokUrl = '$NGROK_URL'"
echo ""
echo "💡 Ahora ejecuta 'r' en el terminal de Flutter para hot reload"
