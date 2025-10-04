# 🚀 APP MÓVIL - MEGA LAVADO S.A.S

## 📱 EJECUTAR LA APP

### **Opción 1: Mismo WiFi (Local)**
Si tu teléfono y Mac están en la misma red:

1. Ejecuta tu backend:
   ```bash
   cd tu-backend && npm start
   ```

2. Ejecuta Flutter:
   ```bash
   flutter run -d 7b416ed3
   ```
   O presiona **F5** en VS Code

3. Configuración en `lib/config/app_config.dart`:
   ```dart
   static const String _connectionMode = 'local';
   ```

### **Opción 2: Redes Diferentes (Ngrok)** ⭐ RECOMENDADO

Si tu teléfono está en otra red (4G, WiFi diferente, etc.):

1. **Instala ngrok:**
   ```bash
   bash setup_ngrok.sh
   ```

2. **Inicia tu backend:**
   ```bash
   cd tu-backend && npm start
   ```

3. **En otra terminal, inicia ngrok:**
   ```bash
   ngrok http 3000
   ```

4. **Copia la URL de ngrok** (ej: `https://abc123.ngrok.io`)

5. **Actualiza `lib/config/app_config.dart`:**
   ```dart
   static const String _connectionMode = 'ngrok';
   static const String _ngrokUrl = 'https://abc123.ngrok.io'; // 👈 TU URL
   ```

6. **Hot reload en Flutter:**
   - Presiona `r` en la terminal
   - O botón de hot reload en VS Code

---

## 🔐 CREDENCIALES DE PRUEBA

- **Email:** `yeygok777@gmail.com`
- **Password:** `121212`

---

## 📚 DOCUMENTACIÓN

- **`EJECUTAR_EN_VSCODE.md`** - Guía para ejecutar desde VS Code
- **`CONECTAR_REDES_DIFERENTES.md`** - Todas las opciones para conectar desde redes diferentes
- **`INTEGRACION_COMPLETADA.md`** - Resumen de la integración API
- **`setup_ngrok.sh`** - Script para instalar ngrok

---

## 🎯 FLUJO DE USO

1. **Login** → Ingresa credenciales
2. **Ver Servicios** → Selecciona un servicio
3. **Crear Reserva** → Completa el wizard de 3 pasos
4. **Mis Reservas** → Ve tus reservas activas
5. **Cancelar** → Cancela reservas si es necesario

---

## 🛠️ CONFIGURACIÓN ACTUAL

Tu app está configurada en modo: **`local`**

Para cambiar el modo, edita `lib/config/app_config.dart`:
```dart
static const String _connectionMode = 'local'; // 👈 Cambiar aquí

// Opciones:
// 'local'      → Mismo WiFi (10.31.103.28:3000)
// 'ngrok'      → Cualquier red (túnel público)
// 'production' → Servidor en producción
```

---

## 📊 ESTADO DEL PROYECTO

### ✅ Completado:
- [x] Login con backend real
- [x] Crear reservas (POST /api/reservas)
- [x] Listar reservas (GET /api/reservas/cliente/:id)
- [x] Cancelar reservas (PUT /api/reservas/:id/cancelar)
- [x] Pull-to-refresh
- [x] Manejo de errores
- [x] Estados de carga
- [x] Soporte para múltiples modos de conexión

### 🔜 Próximas mejoras:
- [ ] Notificaciones push
- [ ] Sistema de rating
- [ ] Chat en vivo
- [ ] Seguimiento GPS del técnico
- [ ] Múltiples métodos de pago
- [ ] Programa de fidelidad

---

## 🐛 TROUBLESHOOTING

### **Error: "Failed to connect"**
1. Verifica que el backend esté corriendo
2. Verifica la configuración en `app_config.dart`
3. Si usas `local`, verifica que estés en la misma red WiFi
4. Si usas `ngrok`, verifica que la URL sea correcta

### **Error: "404 Not Found"**
- La URL no incluye `/api` correctamente
- Verifica que `baseUrl` en `app_config.dart` sea correcto

### **Error: "Network error"**
1. Verifica tu conexión a internet
2. Si usas Android, verifica que tenga permisos de red
3. Revisa los logs de Flutter: `flutter logs`

---

## 🚀 INICIO RÁPIDO

### **Misma Red WiFi:**
```bash
# Terminal 1: Backend
cd tu-backend && npm start

# Terminal 2: Flutter
flutter run -d 7b416ed3
```

### **Redes Diferentes:**
```bash
# Terminal 1: Backend
cd tu-backend && npm start

# Terminal 2: Ngrok
ngrok http 3000

# Copia la URL de ngrok
# Actualiza app_config.dart con la URL
# Hot reload en Flutter (presiona 'r')
```

---

## 📞 SOPORTE

Para más detalles, revisa:
- `CONECTAR_REDES_DIFERENTES.md` - Guía completa de opciones de red
- `INTEGRACION_COMPLETADA.md` - Documentación técnica de la API
- Logs de Flutter: `flutter logs`
- Dashboard de ngrok: `http://127.0.0.1:4040`

---

**🎉 ¡Todo listo para desarrollar y probar!**

Fecha: 3 de octubre de 2025
Proyecto: MEGA LAVADO S.A.S
