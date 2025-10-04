# 📱 Guía Rápida: Flutter + Ngrok

## 🚀 Inicio Rápido (3 pasos)

### 1️⃣ Iniciar Backend
```bash
cd /ruta/a/tu/backend
npm start
```

### 2️⃣ Iniciar Ngrok
```bash
ngrok http 3000
```

### 3️⃣ Iniciar Flutter
```bash
cd /Users/yeygok/Desktop/flutter_login/login
chmod +x start_dev.sh
./start_dev.sh
```

---

## 🔄 Cuando Ngrok cambia de URL

Si reinicias ngrok y la URL cambia:

### Opción A: Automático (Recomendado)
```bash
chmod +x update_ngrok_url.sh
./update_ngrok_url.sh
# Luego presiona 'r' en el terminal de Flutter
```

### Opción B: Manual
1. Copia la nueva URL de ngrok
2. Edita `lib/config/app_config.dart`
3. Actualiza `_ngrokUrl` con la nueva URL
4. Presiona 'r' en el terminal de Flutter

---

## 📱 Ejecutar en Dispositivos

### Teléfono Android conectado por USB
```bash
flutter run -d <device-id>
# Ejemplo: flutter run -d 7b416ed3
```

### Teléfono (cualquier dispositivo disponible)
```bash
flutter run
# Selecciona el dispositivo cuando te lo pida
```

### Chrome (Web)
```bash
flutter run -d chrome
```

### Emulador Android
```bash
flutter run -d emulator
```

---

## 🔥 Comandos durante Flutter Run

Mientras `flutter run` está activo:

- **`r`** - Hot reload (recarga código, mantiene estado)
- **`R`** - Hot restart (reinicia app completamente)
- **`p`** - Mostrar performance overlay
- **`o`** - Toggle platform (Android/iOS)
- **`q`** - Salir

---

## 🔍 Verificar que todo esté corriendo

```bash
# Backend
lsof -i :3000

# Ngrok
lsof -i :4040

# Ver URL de Ngrok
curl -s http://127.0.0.1:4040/api/tunnels | python3 -c "import sys, json; data = json.load(sys.stdin); print(data['tunnels'][0]['public_url'])"
```

---

## ⚠️ Solución de Problemas

### "TimeoutException" en el teléfono
1. Verifica que ngrok esté corriendo: `lsof -i :4040`
2. Verifica que el backend esté corriendo: `lsof -i :3000`
3. La primera vez, abre el navegador del teléfono y ve a la URL de ngrok
4. Presiona "Visit Site" para verificar

### "ERR_NGROK_3200 - Endpoint offline"
- Ngrok se cerró, reinícialo: `ngrok http 3000`
- Actualiza la URL en `app_config.dart`
- Presiona 'r' en Flutter

### Cambios no se reflejan
- Presiona 'r' para hot reload
- Si no funciona, presiona 'R' para hot restart
- Si aún no funciona, cierra y vuelve a ejecutar `flutter run`

---

## 📝 Modos de Conexión

Edita `lib/config/app_config.dart`:

```dart
// Para desarrollo con ngrok (desde cualquier red)
static const String _connectionMode = 'ngrok';

// Para desarrollo en la misma red WiFi
static const String _connectionMode = 'local';

// Para producción
static const String _connectionMode = 'production';
```

---

## 🎯 Flujo de Trabajo Típico

```
1. Abrir terminal → Iniciar backend
2. Abrir terminal → Iniciar ngrok
3. Abrir terminal → Ejecutar ./start_dev.sh
4. Hacer cambios en el código
5. Presionar 'r' para ver los cambios
6. Repetir 4-5 según necesites
```

---

## 📦 Compilar APK para producción

```bash
# APK release
flutter build apk --release

# APK se genera en:
# build/app/outputs/flutter-apk/app-release.apk

# Instalar en teléfono
adb install build/app/outputs/flutter-apk/app-release.apk
```

---

## 💡 Tips

- ✅ Ngrok gratuito funciona perfecto para desarrollo
- ✅ La primera vez en un dispositivo nuevo, visita la URL en el navegador
- ✅ Hot reload ('r') es MUCHO más rápido que hot restart ('R')
- ✅ Puedes desconectar el USB después de instalar la app
- ✅ El teléfono puede estar en cualquier red (WiFi diferente, 4G, 5G)
- ⚠️ Ngrok gratuito tiene sesiones de 2 horas, luego se reinicia
- ⚠️ La URL de ngrok cambia cada vez que lo reinicias

---

## 🔗 Enlaces Útiles

- Ngrok Dashboard: http://127.0.0.1:4040
- Flutter DevTools: Se muestra en la consola después de ejecutar
- Backend: http://localhost:3000
