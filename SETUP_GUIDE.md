# 🚀 GUÍA COMPLETA DE CONFIGURACIÓN - MEGA LAVADO APP

## 📋 ÍNDICE
1. [Requisitos Previos](#requisitos-previos)
2. [Configuración del Backend](#configuración-del-backend)
3. [Configuración de Flutter](#configuración-de-flutter)
4. [Pruebas y Validación](#pruebas-y-validación)
5. [Solución de Problemas](#solución-de-problemas)

---

## 🔧 REQUISITOS PREVIOS

### ✅ Software Necesario
- Node.js (v14 o superior)
- Flutter SDK (v3.0 o superior)
- MySQL (para la base de datos)
- Editor de código (VS Code recomendado)
- Android Studio (para emulador Android) o dispositivo físico

### ✅ Verificar Instalaciones
```bash
# Verificar Node.js
node --version

# Verificar Flutter
flutter --version
flutter doctor

# Verificar MySQL
mysql --version
```

---

## 🖥️ CONFIGURACIÓN DEL BACKEND

### PASO 1: Configurar tu Servidor Node.js

Tu servidor **DEBE** escuchar en **0.0.0.0** (todas las interfaces de red), NO en localhost.

#### ❌ INCORRECTO:
```javascript
app.listen(3000, 'localhost', () => {
  console.log('Server running on localhost:3000');
});
```

#### ✅ CORRECTO:
```javascript
const express = require('express');
const cors = require('cors');
const app = express();

const PORT = process.env.PORT || 3000;

// Middleware
app.use(express.json());
app.use(cors()); // Importante para desarrollo

// Escuchar en TODAS las interfaces de red
app.listen(PORT, '0.0.0.0', () => {
  console.log(`🚀 Servidor corriendo en puerto ${PORT}`);
  console.log(`📱 Accesible en:`);
  console.log(`   - http://localhost:${PORT}`);
  console.log(`   - http://127.0.0.1:${PORT}`);
  console.log(`   - http://[TU_IP_LOCAL]:${PORT}`);
});
```

### PASO 2: Encontrar tu IP Local

#### En Windows:
```bash
ipconfig
# Busca "Dirección IPv4" en tu adaptador WiFi
# Ejemplo: 192.168.1.100
```

#### En Mac/Linux:
```bash
ifconfig | grep "inet "
# O también:
hostname -I
# Ejemplo: 192.168.1.100
```

#### En cualquier sistema:
```bash
# En Node.js puedes usar:
const os = require('os');
const interfaces = os.networkInterfaces();
console.log(interfaces);
```

### PASO 3: Configurar CORS en tu Backend

Instala el paquete CORS si no lo tienes:
```bash
npm install cors
```

Agrega configuración CORS en tu servidor:

```javascript
const cors = require('cors');

// Configuración CORS para desarrollo
const corsOptions = {
  origin: [
    'http://localhost:3000',
    'http://127.0.0.1:3000',
    'http://192.168.1.100:3000', // TU IP LOCAL
    'http://localhost:*',         // Cualquier puerto local
  ],
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization', 'Accept'],
  credentials: true,
  optionsSuccessStatus: 200
};

app.use(cors(corsOptions));

// Para desarrollo rápido (menos seguro):
// app.use(cors()); // Permitir TODOS los orígenes
```

### PASO 4: Crear Endpoints de API

#### Endpoint de Login
```javascript
app.post('/api/auth/login', async (req, res) => {
  try {
    const { email, password } = req.body;

    // Tu lógica de autenticación con MySQL
    const user = await db.query(
      'SELECT * FROM users WHERE email = ?',
      [email]
    );

    if (!user || !bcrypt.compareSync(password, user.password)) {
      return res.status(401).json({
        success: false,
        message: 'Credenciales incorrectas'
      });
    }

    // Generar token JWT
    const token = jwt.sign({ userId: user.id }, 'tu_secret_key');

    res.json({
      success: true,
      message: 'Login exitoso',
      token: token,
      user: {
        id: user.id,
        name: user.name,
        email: user.email,
        phone: user.phone
      }
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Error del servidor'
    });
  }
});
```

#### Endpoint de Crear Cita
```javascript
app.post('/api/appointments/create', async (req, res) => {
  try {
    // Verificar token
    const token = req.headers.authorization?.replace('Bearer ', '');
    const decoded = jwt.verify(token, 'tu_secret_key');

    const {
      serviceType,
      vehicleType,
      date,
      time,
      address,
      customerName,
      customerPhone,
      customerEmail,
      notes
    } = req.body;

    // Insertar en MySQL
    const result = await db.query(
      `INSERT INTO appointments 
       (user_id, service_type, vehicle_type, date, time, address, 
        customer_name, customer_phone, customer_email, notes, status, created_at)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'pending', NOW())`,
      [decoded.userId, serviceType, vehicleType, date, time, address,
       customerName, customerPhone, customerEmail, notes]
    );

    const appointment = {
      id: result.insertId,
      userId: decoded.userId,
      serviceType,
      vehicleType,
      date,
      time,
      address,
      customerName,
      customerPhone,
      customerEmail,
      notes,
      status: 'pending',
      createdAt: new Date()
    };

    res.status(201).json({
      success: true,
      message: 'Cita creada exitosamente',
      appointment: appointment
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Error al crear la cita'
    });
  }
});
```

#### Endpoint de Obtener Mis Citas
```javascript
app.get('/api/appointments/my-appointments', async (req, res) => {
  try {
    const token = req.headers.authorization?.replace('Bearer ', '');
    const decoded = jwt.verify(token, 'tu_secret_key');

    const appointments = await db.query(
      'SELECT * FROM appointments WHERE user_id = ? ORDER BY created_at DESC',
      [decoded.userId]
    );

    res.json(appointments);
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Error al cargar las citas'
    });
  }
});
```

### PASO 5: Crear Tabla de Citas en MySQL

```sql
CREATE TABLE IF NOT EXISTS appointments (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  service_type VARCHAR(100) NOT NULL,
  vehicle_type VARCHAR(50) NOT NULL,
  date DATE NOT NULL,
  time TIME NOT NULL,
  address TEXT NOT NULL,
  customer_name VARCHAR(100),
  customer_phone VARCHAR(20),
  customer_email VARCHAR(100),
  notes TEXT,
  status ENUM('pending', 'confirmed', 'completed', 'cancelled') DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);
```

---

## 📱 CONFIGURACIÓN DE FLUTTER

### PASO 1: Actualizar app_config.dart

Abre `lib/config/app_config.dart` y cambia `_localIP` por tu IP:

```dart
// CAMBIA ESTO 👇
static const String _localIP = '192.168.1.100'; // TU IP AQUÍ
static const String _localPort = '3000';
```

### PASO 2: Instalar Dependencias

```bash
cd login
flutter pub get
```

### PASO 3: Limpiar y Compilar

```bash
# Limpiar builds anteriores
flutter clean

# Compilar de nuevo
flutter pub get

# Verificar que no haya errores
flutter analyze
```

### PASO 4: Configurar Firewall

#### Windows:
```powershell
# Permitir puerto 3000 en el Firewall
netsh advfirewall firewall add rule name="Node API" dir=in action=allow protocol=TCP localport=3000
```

#### Mac:
```bash
# Generalmente no necesita configuración adicional
# Si hay problemas, ve a System Preferences > Security & Privacy > Firewall
```

#### Linux:
```bash
# UFW
sudo ufw allow 3000/tcp

# Firewalld
sudo firewall-cmd --add-port=3000/tcp --permanent
sudo firewall-cmd --reload
```

---

## 🧪 PRUEBAS Y VALIDACIÓN

### TEST 1: Verificar que el Backend está Accesible

#### Desde tu PC:
```bash
curl http://localhost:3000/api
# Debe responder (aunque sea con error, pero NO debe colgar)
```

#### Desde tu teléfono (mismo WiFi):
1. Abre el navegador en tu teléfono
2. Ve a: `http://[TU_IP]:3000/api`
3. Debe cargar algo (aunque sea un error JSON)

### TEST 2: Probar Login desde Postman

```json
POST http://[TU_IP]:3000/api/auth/login
Content-Type: application/json

{
  "email": "test@example.com",
  "password": "password123"
}
```

### TEST 3: Probar en Flutter

1. **Conecta tu teléfono por USB**
2. **Asegúrate de estar en la MISMA WiFi**
3. **Corre la app:**

```bash
# Ver dispositivos
flutter devices

# Ejecutar en tu teléfono
flutter run

# O ejecutar en Chrome (para probar)
flutter run -d chrome
```

4. **Prueba el Login:**
   - Usa email: `test@example.com`
   - El modo testing está activado, así que funcionará sin API
   - Luego prueba con tu API real

5. **Prueba Agendar Cita:**
   - Ve a "Agendar Cita" desde el botón en inicio
   - Llena el formulario
   - Verifica que llegue a tu base de datos

### TEST 4: Verificar Conectividad desde la App

1. Abre la app
2. Ve al menú → "Pruebas API"
3. Presiona "Conectividad"
4. Debe mostrar: ✅ Conexión exitosa

---

## 🔥 SOLUCIÓN DE PROBLEMAS COMUNES

### Problema 1: "Connection refused" o "Failed to connect"

**Causas:**
- El backend no está corriendo
- Firewall bloqueando el puerto
- IP incorrecta en app_config.dart
- Backend escuchando solo en localhost

**Soluciones:**
```bash
# 1. Verificar que el backend está corriendo
# En tu terminal del backend debe decir "Servidor corriendo..."

# 2. Verificar que está en 0.0.0.0
# En tu código de servidor, asegúrate de:
app.listen(3000, '0.0.0.0', ...)

# 3. Verificar IP
ipconfig  # Windows
ifconfig  # Mac/Linux

# 4. Desactivar firewall temporalmente (para probar)
# Windows: Panel de Control > Firewall
```

### Problema 2: CORS Error en Flutter Web

**Solución:**
```javascript
// En tu backend, agrega:
app.use(cors());

// O específicamente para Flutter web:
const corsOptions = {
  origin: '*', // Para desarrollo
  credentials: true
};
app.use(cors(corsOptions));
```

### Problema 3: "ERR_CLEARTEXT_NOT_PERMITTED" en Android

**Ya está solucionado en el proyecto**, pero si ves este error:

1. Verifica que existe: `android/app/src/main/res/xml/network_security_config.xml`
2. Verifica que `AndroidManifest.xml` tiene:
   ```xml
   android:usesCleartextTraffic="true"
   android:networkSecurityConfig="@xml/network_security_config"
   ```

### Problema 4: El Emulador Android no Conecta

**Solución:**
```dart
// En app_config.dart, usa:
return 'http://10.0.2.2:3000/api'; // Para emulador Android

// NO uses 192.168.x.x con emulador
// 10.0.2.2 es el localhost del emulador
```

### Problema 5: Dispositivo Físico no Conecta

**Checklist:**
- ✅ Teléfono y PC en la MISMA red WiFi
- ✅ Backend corriendo en 0.0.0.0
- ✅ IP correcta en app_config.dart
- ✅ Firewall permite puerto 3000
- ✅ No estás usando VPN

```bash
# Prueba desde el navegador del teléfono:
http://[TU_IP]:3000/api

# Debe cargar algo, aunque sea un error
```

---

## 📊 CHECKLIST FINAL

### Backend
- [ ] Backend escucha en 0.0.0.0
- [ ] CORS configurado
- [ ] Puerto 3000 abierto en firewall
- [ ] Endpoints /api/auth/login y /api/appointments/create funcionan
- [ ] MySQL corriendo y tabla appointments creada

### Flutter
- [ ] IP correcta en app_config.dart
- [ ] flutter pub get ejecutado
- [ ] AndroidManifest.xml actualizado
- [ ] network_security_config.xml creado
- [ ] App compila sin errores

### Red
- [ ] PC y teléfono en la misma WiFi
- [ ] IP estática o reservada en el router
- [ ] Firewall permite conexiones
- [ ] Prueba desde navegador del teléfono funciona

---

## 🎯 MODO TESTING

La app tiene un **modo testing activado** que te permite probar sin backend:

- Cualquier email con "test" o "admin" hace login automático
- Las citas se simulan localmente
- Perfecto para probar la UI sin configurar el backend

Para **desactivar el modo testing** (cuando tu API esté lista):
```dart
// En lib/config/app_config.dart
static const bool enableTestingMode = false; // Cambia a false
```

---

## 📞 SOPORTE

Si sigues teniendo problemas después de seguir esta guía:

1. Verifica los logs del backend (terminal donde corre node)
2. Verifica los logs de Flutter (terminal donde corre flutter run)
3. Usa la pantalla "Pruebas API" en la app para diagnóstico
4. Revisa que todas las dependencias estén instaladas

---

## 🚀 PRÓXIMOS PASOS

Una vez que todo funcione localmente:

1. **Producción**: Despliega tu backend en Heroku, AWS, o DigitalOcean
2. **HTTPS**: Configura SSL/TLS para seguridad
3. **Dominio**: Compra un dominio y configúralo
4. **App Stores**: Publica en Google Play / App Store
5. **Features**: Agrega notificaciones push, pagos en línea, etc.

---

**¡Éxito con tu aplicación MEGA LAVADO! 🚗💧**
