# 🌐 CONECTAR APP DESDE REDES DIFERENTES

## 🎯 OPCIONES DISPONIBLES

Tu app Flutter ahora soporta **3 modos de conexión**. Puedes cambiar entre ellos editando `lib/config/app_config.dart`:

```dart
static const String _connectionMode = 'local'; // 👈 CAMBIAR AQUÍ
```

---

## ✅ OPCIÓN 1: NGROK (RECOMENDADO - Fácil y rápido) ⭐

### **¿Qué es ngrok?**
Ngrok crea un túnel público hacia tu servidor local. Funciona desde **cualquier red** (WiFi, datos móviles, etc.).

### **Instalación:**

```bash
# Opción 1: Con Homebrew
brew install ngrok/ngrok/ngrok

# Opción 2: Descargar desde https://ngrok.com/download
```

### **Configuración:**

1. **Inicia tu backend:**
   ```bash
   cd tu-proyecto-backend
   npm start
   ```
   Debería mostrar: `🚀 API ejecutándose en 0.0.0.0:3000`

2. **En otra terminal, inicia ngrok:**
   ```bash
   ngrok http 3000
   ```

3. **Copia la URL pública** que aparece:
   ```
   Forwarding  https://abc123.ngrok.io -> http://localhost:3000
                      ^^^^^^^^^^^^^^^^^^^^^^
                      Esta es tu URL
   ```

4. **Actualiza `lib/config/app_config.dart`:**
   ```dart
   static const String _connectionMode = 'ngrok'; // 👈 Cambiar a ngrok
   static const String _ngrokUrl = 'https://abc123.ngrok.io'; // 👈 Tu URL de ngrok
   ```

5. **Hot reload en Flutter:**
   - Si la app ya está corriendo, presiona `r` en la terminal
   - O presiona el botón de hot reload en VS Code

### **Ventajas:**
✅ Funciona desde cualquier red (WiFi, 4G, 5G)
✅ Fácil de configurar
✅ No requiere abrir puertos en el router
✅ HTTPS incluido (perfecto para iOS)
✅ Gratis para desarrollo

### **Desventajas:**
⚠️ La URL cambia cada vez que reinicias ngrok (en la versión gratuita)
⚠️ Requiere tener ngrok corriendo

---

## ✅ OPCIÓN 2: LOCALHOST TUNNEL (Alternativa a ngrok)

Similar a ngrok pero open-source:

```bash
# Instalar localtunnel
npm install -g localtunnel

# Crear túnel
lt --port 3000
```

Te dará una URL como: `https://xyz.loca.lt`

Actualiza `app_config.dart`:
```dart
static const String _connectionMode = 'ngrok'; // Usa el mismo modo
static const String _ngrokUrl = 'https://xyz.loca.lt'; // Tu URL de localtunnel
```

---

## ✅ OPCIÓN 3: PORT FORWARDING EN ROUTER (Avanzado)

Abre el puerto 3000 de tu router hacia tu Mac.

### **Pasos:**
1. Accede a tu router (usualmente `192.168.1.1` o `192.168.0.1`)
2. Busca "Port Forwarding" o "Reenvío de puertos"
3. Crea una regla:
   - Puerto externo: 3000
   - Puerto interno: 3000
   - IP interna: Tu Mac (10.31.103.28)
   - Protocolo: TCP

4. Obtén tu IP pública:
   ```bash
   curl ifconfig.me
   ```

5. Actualiza `app_config.dart`:
   ```dart
   static const String _connectionMode = 'ngrok'; // Usa el mismo modo
   static const String _ngrokUrl = 'http://TU_IP_PUBLICA:3000'; // Tu IP pública
   ```

### **Ventajas:**
✅ No requiere servicios de terceros
✅ URL permanente

### **Desventajas:**
⚠️ Requiere acceso al router
⚠️ Expone tu red (riesgo de seguridad)
⚠️ Tu IP pública puede cambiar
⚠️ No incluye HTTPS

---

## ✅ OPCIÓN 4: VPN (Para equipos/empresa)

Conecta tu teléfono a la red de tu empresa/casa mediante VPN.

### **Herramientas:**
- **Tailscale** (fácil de configurar, gratuito): https://tailscale.com
- **WireGuard** (open-source)
- **OpenVPN**

Con Tailscale:
```bash
# Instalar en Mac
brew install tailscale
tailscale up

# Instalar app de Tailscale en tu teléfono Android
# Ambos dispositivos estarán en la misma red virtual
```

Luego usa modo `'local'` en `app_config.dart`.

---

## ✅ OPCIÓN 5: DESPLEGAR BACKEND EN LA NUBE (Producción)

Sube tu backend a un servicio en la nube:

### **Servicios recomendados:**
- **Heroku** (fácil, gratuito para pruebas)
- **Railway** (moderno, fácil deployment)
- **DigitalOcean** (VPS desde $5/mes)
- **AWS/Azure/Google Cloud** (empresarial)
- **Vercel/Netlify** (para Node.js)

### **Ejemplo con Railway:**

1. **Sube tu código a GitHub**
2. **Ve a railway.app** y crea una cuenta
3. **Conecta tu repositorio**
4. **Railway desplegará automáticamente**
5. **Copia la URL generada** (ej: `https://tu-app.railway.app`)
6. **Actualiza `app_config.dart`:**
   ```dart
   static const String _connectionMode = 'production';
   static const String _productionUrl = 'https://tu-app.railway.app';
   ```

---

## 📱 CONFIGURACIÓN ACTUAL

Tu `app_config.dart` está configurado así:

```dart
static const String _connectionMode = 'local'; // 👈 Modo actual

// Opciones disponibles:
// - 'local'      → Misma red WiFi (10.31.103.28:3000)
// - 'ngrok'      → Túnel público (cualquier red)
// - 'production' → Servidor en producción
```

---

## 🚀 GUÍA RÁPIDA: USAR NGROK (RECOMENDADO)

### **Paso 1: Instalar ngrok**
```bash
brew install ngrok/ngrok/ngrok
```

### **Paso 2: Iniciar backend**
```bash
cd tu-proyecto-backend
npm start
```

### **Paso 3: Iniciar ngrok**
```bash
ngrok http 3000
```

### **Paso 4: Copiar URL**
Copia la URL que muestra ngrok (ej: `https://abc123.ngrok.io`)

### **Paso 5: Actualizar Flutter**
En `lib/config/app_config.dart`:
```dart
static const String _connectionMode = 'ngrok';
static const String _ngrokUrl = 'https://abc123.ngrok.io'; // 👈 TU URL
```

### **Paso 6: Hot reload**
Si la app ya está corriendo:
- Presiona `r` en la terminal de Flutter
- O el botón de hot reload en VS Code

### **Paso 7: ¡Probar!**
Login con:
- Email: `yeygok777@gmail.com`
- Password: `121212`

---

## 🔍 VERIFICAR LOGS

### **Logs de ngrok:**
```
ngrok by @inconshreveable

Session Status    online
Region            United States (us)
Web Interface     http://127.0.0.1:4040    👈 Dashboard web
Forwarding        https://abc123.ngrok.io -> http://localhost:3000
```

### **Dashboard de ngrok:**
Abre: `http://127.0.0.1:4040`
- Verás todas las peticiones HTTP en tiempo real
- Útil para debugging

### **Logs de Flutter:**
Deberías ver:
```
🔐 Intentando login a: https://abc123.ngrok.io/api/auth/login
📥 Respuesta del servidor: 200
✅ Login exitoso
```

---

## 🐛 TROUBLESHOOTING

### **Error: "tunnel session failed"**
- Ngrok gratuito tiene límites
- Reinicia ngrok: `Ctrl+C` y luego `ngrok http 3000`

### **Error: "Failed to connect"**
1. Verifica que tu backend esté corriendo
2. Verifica la URL de ngrok en `app_config.dart`
3. Abre `http://127.0.0.1:4040` para ver los requests

### **Error: "CORS blocked"**
Tu backend ya tiene CORS configurado, pero verifica que permita el origen de ngrok:
```javascript
origin: function (origin, callback) {
  // Permitir requests sin origin (apps móviles)
  if (!origin) return callback(null, true);
  callback(null, true); // Permitir todos en desarrollo
}
```

---

## 📊 COMPARACIÓN DE OPCIONES

| Opción | Facilidad | Velocidad | Seguridad | Costo | Recomendado para |
|--------|-----------|-----------|-----------|-------|------------------|
| **ngrok** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | Gratis | **Desarrollo** ⭐ |
| Local Tunnel | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ | Gratis | Desarrollo |
| Port Forward | ⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐ | Gratis | Pruebas internas |
| VPN | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | Gratis-Pago | Equipos |
| **Cloud Deploy** | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | Desde $0 | **Producción** ⭐ |

---

## ✅ RECOMENDACIÓN FINAL

Para **desarrollo inmediato**:
1. **Usa ngrok** (5 minutos de setup)
2. Funciona desde cualquier red
3. Perfecto para mostrar demos

Para **producción**:
1. **Despliega en Railway/Heroku**
2. URL permanente
3. Escalable

---

**🎉 ¡Listo! Ahora puedes conectarte desde cualquier red.**

Ejecuta estos comandos y estarás online en 2 minutos:
```bash
# Terminal 1: Backend
cd tu-backend && npm start

# Terminal 2: Ngrok
ngrok http 3000

# Copia la URL de ngrok y actualiza app_config.dart
# Luego hot reload en Flutter (presiona 'r')
```
