# 🚀 GUÍA RÁPIDA: EJECUTAR EN VS CODE

## ✅ MÉTODO 1: Usando F5 (RECOMENDADO)

1. **Abre VS Code**
2. **Abre el proyecto:** `/Users/yeygok/Desktop/flutter_login/login`
3. **Abre el archivo:** `lib/main.dart`
4. **Presiona F5** (o selecciona **Run > Start Debugging**)
5. **Selecciona:** "Flutter (Android)"
6. **Espera** a que compile e instale en tu dispositivo

---

## ✅ MÉTODO 2: Desde el Command Palette

1. **Presiona:** `Cmd + Shift + P`
2. **Escribe:** `Flutter: Select Device`
3. **Selecciona:** `M2007J20CG (7b416ed3)`
4. **Presiona:** `F5`

---

## ✅ MÉTODO 3: Desde la terminal de VS Code

1. **Abre una terminal en VS Code** (`Ctrl + ~`)
2. **Ejecuta:**
   ```bash
   flutter run -d 7b416ed3
   ```

---

## 🔍 VERIFICAR CONEXIÓN

Ejecuta en la terminal:
```bash
flutter devices
```

Deberías ver:
```
M2007J20CG (mobile) • 7b416ed3 • android-arm64 • Android 12 (API 31)
```

---

## 📱 CREDENCIALES DE LOGIN

Una vez que la app esté corriendo:

- **Email:** `yulyosorio757@gmail.com` o `yeygok777@gmail.com`
- **Password:** `121212`

---

## 🐛 TROUBLESHOOTING

### **Si el dispositivo no aparece:**
1. Desconecta y reconecta el cable USB
2. En tu teléfono, acepta "Permitir depuración USB"
3. Ejecuta: `adb devices` en la terminal

### **Si no compila:**
1. Ejecuta: `flutter clean`
2. Ejecuta: `flutter pub get`
3. Intenta nuevamente con F5

### **Si hay error de conexión al backend:**
1. Verifica que el servidor esté corriendo: `npm start` (en el proyecto del backend)
2. Verifica la IP en `lib/config/app_config.dart`: debe ser `10.31.103.28`
3. Asegúrate de que el teléfono esté en la misma red WiFi que tu Mac

---

## ✅ CONFIGURACIONES CREADAS

✅ `.vscode/launch.json` - Configuraciones de ejecución
✅ `.vscode/settings.json` - Configuraciones del editor

---

## 🎯 FLUJO DE PRUEBA

1. **Login** → Ingresa credenciales
2. **Navega a "Reservations"** → Selecciona un servicio
3. **Completa el wizard** → 3 pasos (datos, dirección, fecha)
4. **Confirma la reserva** → Debería crear en el backend
5. **Ve a "Mis Reservas"** → Debería cargar desde la API
6. **Pull-to-refresh** → Actualiza la lista
7. **Cancela una reserva** → Si está en estado 1 o 2

---

**🎉 ¡Todo listo para ejecutar!**

Ahora solo presiona **F5** en VS Code con `lib/main.dart` abierto.
