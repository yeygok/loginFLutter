#!/bin/bash

# 🌐 Script para iniciar ngrok en puerto 3000
# Uso: ./start_ngrok.sh

echo "🌐 Iniciando ngrok en puerto 3000..."
echo ""
echo "📡 Esto creará un túnel público para tu backend"
echo "⏳ Espera unos segundos hasta que aparezca la URL..."
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Iniciar ngrok
ngrok http 3000
