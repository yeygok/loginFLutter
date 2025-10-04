#!/bin/bash

# Script para ejecutar Flutter web con proxy CORS
# Uso: ./run_web_with_proxy.sh

echo "🚀 Ejecutando Flutter web con proxy CORS..."
echo "📡 Proxy configurado para: http://192.168.137.39:3000"
echo ""

# Ejecutar Flutter web con configuración de proxy
flutter run -d chrome --web-port=8080 --web-hostname=127.0.0.1

# Nota: El proxy.conf.json debe estar en web/proxy.conf.json
# Flutter automáticamente detectará y usará la configuración de proxy