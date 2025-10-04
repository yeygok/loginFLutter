#!/bin/bash

# 🚀 Script para iniciar el entorno de desarrollo Flutter + Ngrok
# Autor: Asistente AI
# Fecha: 3 de octubre de 2025

echo "═══════════════════════════════════════════════════"
echo "🚀 INICIANDO ENTORNO DE DESARROLLO FLUTTER"
echo "═══════════════════════════════════════════════════"
echo ""

# Colores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Verificar si ngrok está corriendo
echo "🔍 Verificando ngrok..."
if lsof -i :4040 > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Ngrok ya está corriendo${NC}"
    NGROK_URL=$(curl -s http://127.0.0.1:4040/api/tunnels 2>/dev/null | python3 -c "import sys, json; data = json.load(sys.stdin); print(data['tunnels'][0]['public_url'] if data.get('tunnels') else '')" 2>/dev/null)
    if [ -n "$NGROK_URL" ]; then
        echo -e "${GREEN}📡 URL de Ngrok: $NGROK_URL${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  Ngrok no está corriendo${NC}"
    echo -e "${YELLOW}💡 Inicia ngrok en otro terminal: ngrok http 3000${NC}"
fi

echo ""

# Verificar si el backend está corriendo
echo "🔍 Verificando backend (puerto 3000)..."
if lsof -i :3000 | grep LISTEN > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Backend corriendo en puerto 3000${NC}"
else
    echo -e "${RED}❌ Backend NO está corriendo${NC}"
    echo -e "${YELLOW}💡 Inicia el backend en otro terminal${NC}"
fi

echo ""
echo "═══════════════════════════════════════════════════"
echo "📱 DISPOSITIVOS DISPONIBLES"
echo "═══════════════════════════════════════════════════"

# Listar dispositivos disponibles
flutter devices

echo ""
echo "═══════════════════════════════════════════════════"
echo "🎯 OPCIONES DE EJECUCIÓN"
echo "═══════════════════════════════════════════════════"
echo "1) Ejecutar en dispositivo conectado (Android/iOS)"
echo "2) Ejecutar en Chrome (Web)"
echo "3) Ejecutar en emulador Android"
echo "4) Solo mostrar información"
echo "q) Salir"
echo ""
read -p "Selecciona una opción: " option

case $option in
    1)
        echo ""
        echo -e "${GREEN}🚀 Ejecutando en dispositivo físico...${NC}"
        flutter run
        ;;
    2)
        echo ""
        echo -e "${GREEN}🌐 Ejecutando en Chrome...${NC}"
        flutter run -d chrome
        ;;
    3)
        echo ""
        echo -e "${GREEN}📱 Ejecutando en emulador Android...${NC}"
        flutter run -d emulator
        ;;
    4)
        echo ""
        echo -e "${GREEN}ℹ️  Información mostrada${NC}"
        ;;
    q|Q)
        echo ""
        echo -e "${YELLOW}👋 ¡Hasta luego!${NC}"
        exit 0
        ;;
    *)
        echo ""
        echo -e "${RED}❌ Opción no válida${NC}"
        exit 1
        ;;
esac
