# 🚀 Guía Ultra Rápida - Levantar Todo

## 📱 Pasos para empezar a trabajar

### 1️⃣ Abrir 3 Terminales

---

### **Terminal 1: Backend (Puerto 3000)**

```bash
# Ve a la carpeta de tu backend
cd ~/Desktop/apirest

# Inicia el servidor
npm start
```

**Deberías ver:**
```
✅ Servidor corriendo en puerto 3000
```

---

### **Terminal 2: Ngrok (Túnel Público)**

```bash
# Ve a la carpeta del proyecto Flutter
cd ~/Desktop/flutter_login/login

# Inicia ngrok
./start_ngrok.sh
```

**Deberías ver algo como:**
```
Forwarding   https://algo-random-123.ngrok-free.dev -> http://localhost:3000
```

**⚠️ IMPORTANTE:** 
- **NO CIERRES** esta terminal
- Copia la URL que empieza con `https://`
- Si necesitas copiar la URL: `Cmd+C` en la terminal

---

### **Terminal 3: Flutter**

```bash
# Ve a la carpeta del proyecto
cd ~/Desktop/flutter_login/login

# Ejecuta en tu teléfono
flutter run

# O usa el script:
./start_dev.sh
```

Cuando te pregunte, selecciona tu dispositivo.

---

## 🔄 Cuando reinicias ngrok

Si cierras ngrok y lo vuelves a abrir, la URL cambia. Debes:

**Opción A - Automático:**
```bash
./update_ngrok_url.sh
# Luego presiona 'r' en el terminal de Flutter
```

**Opción B - Manual:**
1. Copia la nueva URL de ngrok
2. Edita `lib/config/app_config.dart`
3. Cambia `_ngrokUrl` con la nueva URL
4. Presiona 'r' en el terminal de Flutter

---

## ✅ Verificar que todo funciona

```bash
# En otra terminal nueva:

# 1. Verificar backend
curl http://localhost:3000/api

# 2. Verificar ngrok
curl https://tu-url-de-ngrok.ngrok-free.dev/api
```

---

## 🔥 Durante desarrollo

- **`r`** en terminal de Flutter = Hot reload (ver cambios rápido)
- **`R`** en terminal de Flutter = Hot restart (reiniciar app)
- **`q`** en terminal de Flutter = Salir

---

## 🐛 Problemas comunes

### "TimeoutException"
- ✅ Verifica que ngrok esté corriendo
- ✅ Abre el navegador del teléfono y ve a la URL de ngrok
- ✅ Presiona "Visit Site"

### "ERR_NGROK_3200"
- ❌ Ngrok se cerró
- ✅ Reinicia ngrok: `./start_ngrok.sh`
- ✅ Actualiza la URL: `./update_ngrok_url.sh`

### "Port 3000 already in use"
- ❌ El backend ya está corriendo
- ✅ Cierra el proceso: `lsof -ti:3000 | xargs kill -9`

---

## 📝 Tu cuenta de prueba

**Email:** yeygok777@gmail.com  
**Password:** 121212

---

## 🎯 Resumen visual

```
┌─────────────────────────────────────────────────┐
│  TERMINAL 1: Backend                            │
│  cd ~/Desktop/apirest && npm start              │
│  ✅ Puerto 3000                                  │
└─────────────────────────────────────────────────┘
                    ⬇️
┌─────────────────────────────────────────────────┐
│  TERMINAL 2: Ngrok                              │
│  cd ~/Desktop/flutter_login/login               │
│  ./start_ngrok.sh                               │
│  ✅ Túnel: https://xxx.ngrok-free.dev           │
└─────────────────────────────────────────────────┘
                    ⬇️
┌─────────────────────────────────────────────────┐
│  TERMINAL 3: Flutter                            │
│  cd ~/Desktop/flutter_login/login               │
│  flutter run                                    │
│  ✅ App en teléfono                             │
└─────────────────────────────────────────────────┘
```
