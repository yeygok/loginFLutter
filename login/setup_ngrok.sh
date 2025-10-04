#!/bin/bash

# Script para configurar ngrok rápidamente
# Ejecutar con: bash setup_ngrok.sh

echo "🚀 CONFIGURACIÓN RÁPIDA DE NGROK"
echo "================================"
echo ""

# Verificar si ngrok está instalado
if command -v ngrok &> /dev/null; then
    echo "✅ Ngrok ya está instalado"
else
    echo "📦 Instalando ngrok..."
    if command -v brew &> /dev/null; then
        brew install ngrok/ngrok/ngrok
        echo "✅ Ngrok instalado correctamente"
    else
        echo "❌ Homebrew no está instalado"
        echo "Instala manualmente desde: https://ngrok.com/download"
        exit 1
    fi
fi

echo ""
echo "🔧 PASOS SIGUIENTES:"
echo "==================="
echo ""
echo "1. Inicia tu backend Node.js:"
echo "   cd tu-proyecto-backend"
echo "   npm start"
echo ""
echo "2. En otra terminal, inicia ngrok:"
echo "   ngrok http 3000"
echo ""
echo "3. Copia la URL que muestra (ej: https://abc123.ngrok.io)"
echo ""
echo "4. Actualiza lib/config/app_config.dart:"
echo "   static const String _connectionMode = 'ngrok';"
echo "   static const String _ngrokUrl = 'https://tu-url.ngrok.io';"
echo ""
echo "5. Hot reload en Flutter (presiona 'r')"
echo ""
echo "📖 Más información: CONECTAR_REDES_DIFERENTES.md"
echo ""
echo "✅ ¡Listo para usar ngrok!"
