# � MEGA LAVADO S.A.S - Flutter App

Una aplicación móvil completa para servicios de lavado a vapor profesional desarrollada en Flutter con Material Design 3, sistema de autenticación robusto, gestión de reservas y navegación intuitiva.

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![Material%20Design](https://img.shields.io/badge/material%20design-757575?style=for-the-badge&logo=material%20design&logoColor=white)

## 📱 Descripción

**MEGA LAVADO S.A.S** es una aplicación móvil profesional que ofrece servicios de lavado a vapor especializados. La app permite a los usuarios registrarse, agendar servicios, ver sus reservas con detalles completos como una factura profesional, y gestionar su perfil de manera intuitiva.

### ✨ Características Principales

#### � **Sistema de Autenticación**
- 📱 **Login Profesional** - Interfaz moderna con validaciones robustas
- � **Registro Completo** - Formulario con formateo automático de teléfono colombiano
- 🔒 **Validaciones Avanzadas** - Email, contraseña segura, nombres y teléfonos

#### 🏠 **Dashboard y Navegación**
- 🎯 **Home Responsivo** - Dashboard adaptable con información principal
- 🧭 **Navegación Dual** - Drawer lateral + Bottom Navigation sincronizados
- 📱 **Diseño Mobile-First** - Optimizado específicamente para Android

#### 🛎️ **Sistema de Reservas**
- 📅 **Agendar Servicios** - Flujo completo de reserva en 3 pasos
- 🧾 **Mis Reservas** - Vista tipo factura con detalles completos
- 👨‍🔧 **Información del Técnico** - Datos completos, rating y contacto
- 🚗 **Vehículo del Técnico** - Marca, modelo, placa y color
- 💰 **Precios Detallados** - Formateo profesional con separadores de miles

#### ⚙️ **Gestión de Usuario**
- 👤 **Perfil Completo** - Visualización y edición de datos personales
- 🔧 **Configuraciones** - Cambiar email, contraseña, idioma y tema
- 🌓 **Temas** - Light/Dark mode con persistencia
- 🎨 **Material Design 3** - Diseño moderno y consistente

#### 🏆 **Características Técnicas**
- 🚀 **Optimizado** - Sin advertencias, código limpio
- 📱 **Responsivo** - Adaptable a cualquier tamaño de pantalla
- 🎯 **Android-First** - Diseñado específicamente para Android
- 🔄 **Estado Persistente** - Configuraciones guardadas localmente

## 📸 Screenshots

<!-- Agrega aquí tus screenshots reales de la app -->


## 🏗️ Estructura Técnica del Proyecto

```
lib/
├── main.dart                        # Entry Point con Material App 3
│
├── 🔐 auth/                        # Sistema de Autenticación
│   ├── login.dart                  # Login + Material 3 Design
│   └── register.dart               # Registro con validaciones
│
├── 🏠 home/                        # Pantalla Principal
│   └── home.dart                   # Dashboard con IndexedStack
│
├── 🎨 theme/                       # Sistema de Temas
│   ├── theme_app.dart             # Light/Dark Theme Provider
│   ├── yeygokstilo.dart           # Estilos personalizados MEGA
│   └── theme_provider.dart        # State Management de temas
│
├── 👤 user/                        # Gestión de Usuario
│   ├── form.dart                  # Formularios reutilizables
│   └── user.dart                  # Modelo y lógica de usuario
│
├── 📱 views/                       # Pantallas de la Aplicación
│   ├── change_email_screen.dart       # Cambio de email
│   ├── change_password_screen.dart    # Cambio de contraseña
│   ├── language_settings_screen.dart  # Configuración idioma
│   ├── settings_screen.dart           # Panel configuración
│   ├── theme_settings_screen.dart     # Configuración temas
│   ├── booking_flow.dart              # Flujo reserva guiado
│   ├── reservations_screen.dart       # Pantalla de reservas
│   └── my_reservations_screen.dart    # Facturación detallada
│
├── 🧩 widgets/                     # Componentes Reutilizables
│   ├── appbar.dart                # AppBar personalizado
│   ├── navigation_bottom.dart     # BottomNavigation sincronizado
│   └── navigation_drawer.dart     # Drawer con perfil
│
├── 🔧 utils/                       # Utilidades
│   └── validation_utils.dart      # Validaciones robustas
│
└── 📄 splash/                      # Splash Screen
    └── splash_app.dart            # Pantalla de carga inicial
```

### 📊 Arquitectura de Estado
```
Provider Pattern:
├── ThemeProvider (Light/Dark)
├── NavigationProvider (Sync Bottom/Drawer)
├── UserProvider (Session Management)
└── ReservationProvider (Bookings)

## 🚀 Instalación y Configuración

### 📋 Prerrequisitos

- Flutter SDK (versión 3.35.4 o superior)
- Dart SDK
- Android Studio o VS Code
- Git

### 🔧 Instalación

1. **Clona el repositorio**
   ```bash
   git clone https://github.com/yeygok/loginFLutter.git
   cd loginFLutter/login
   ```

2. **Verifica tu instalación de Flutter**
   ```bash
   flutter doctor
   ```

3. **Instala las dependencias**
   ```bash
   flutter pub get
   ```

4. **Genera los iconos de la app**
   ```bash
   flutter pub run flutter_launcher_icons:main
   ```

### 🏃‍♂️ Ejecutar la Aplicación

#### Para Android:
```bash
flutter run
```

#### Para Chrome (Web - Desarrollo):
```bash
flutter run -d chrome
```

#### Para generar APK:
```bash
flutter build apk --release
```

### 🌐 Despliegue Web en Chrome

La aplicación puede ejecutarse en Chrome para desarrollo y testing:

1. **Habilitar soporte web**
   ```bash
   flutter config --enable-web
   ```

2. **Ejecutar en Chrome**
   ```bash
   flutter run -d chrome --web-port 8080
   ```

3. **Build para producción web**
   ```bash
   flutter build web --release
   ```

4. **Servir archivos estáticos**
   ```bash
   # Usando Python
   cd build/web
   python -m http.server 8080
   
   # O usando Node.js
   npx serve build/web
   ```

## 📦 Dependencias y Tecnologías

### 🔧 Dependencias Principales

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2      # Iconos iOS
  shared_preferences: ^2.2.2   # Almacenamiento local
  provider: ^6.1.1            # Gestión de estado
  http: ^1.1.0                # Peticiones HTTP

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0           # Análisis de código
  flutter_launcher_icons: ^0.13.1 # Generador de iconos
```

### � **Integración con API Backend**

### 📡 **Configuración de la API**

1. **Actualiza la URL de tu API** en `lib/config/app_config.dart`:
```dart
class AppConfig {
  // Cambia esta URL por la de tu servidor backend
  static const String baseUrl = 'https://tu-api-backend.com/api';
  // O para desarrollo local:
  // static const String baseUrl = 'http://10.0.2.2:3000/api'; // Android emulator
  // static const String baseUrl = 'http://localhost:3000/api'; // iOS simulator
}
```

### 🔧 **Estructura de la API Esperada**

#### **POST** `/api/auth/login`
**Request:**
```json
{
  "email": "usuario@example.com",
  "password": "password123"
}
```

**Response (Éxito - 200):**
```json
{
  "success": true,
  "message": "Login exitoso",
  "token": "jwt_token_aqui",
  "user": {
    "id": 1,
    "name": "Juan Pérez",
    "email": "usuario@example.com",
    "phone": "+573001234567",
    "avatar": "https://api.com/avatar.jpg",
    "created_at": "2024-01-15T10:30:00Z"
  }
}
```

**Response (Error - 401):**
```json
{
  "success": false,
  "message": "Credenciales incorrectas"
}
```

#### **GET** `/api/auth/verify`
**Headers:**
```
Authorization: Bearer <token>
```

**Response (200):**
```json
{
  "success": true,
  "message": "Token válido"
}
```

### 🧪 **API de Prueba**

Para testing rápido, puedes usar este servidor Node.js:

```javascript
// server.js
const express = require('express');
const app = express();
app.use(express.json());

app.post('/api/auth/login', (req, res) => {
  const { email, password } = req.body;
  
  if (email === 'test@mega-lavado.com' && password === 'Test123!') {
    res.json({
      success: true,
      message: "Login exitoso",
      token: "test_token",
      user: {
        id: 1,
        name: "Usuario Test",
        email: "test@mega-lavado.com",
        phone: "+573001234567"
      }
    });
  } else {
    res.status(401).json({
      success: false,
      message: "Credenciales incorrectas"
    });
  }
});

app.listen(3000, () => console.log('API Server on port 3000'));
```

### 🔐 **Características de Seguridad**

- **JWT Tokens**: Autenticación basada en tokens
- **Persistencia Segura**: Tokens guardados en SharedPreferences
- **Verificación Automática**: Validación de tokens al iniciar app
- **Timeouts**: Protección contra conexiones lentas (30s)
- **Manejo de Errores**: Mensajes claros para diferentes tipos de error

## 🎯 Funcionalidades Detalladas

### 🔐 **Autenticación y Registro**
- **Login Seguro**: Validación de email y contraseña con mensajes claros
- **Registro Completo**: Formulario con datos personales, teléfono y dirección
- **Validaciones Robustas**: 
  - Email con formato válido
  - Contraseña: 8-16 chars, mayúscula, minúscula, número, carácter especial
  - Teléfono: Formato colombiano automático (+57 3XX XXX XXXX)
  - Nombres: Solo letras, capitalización automática

### 📱 **Interfaz y Navegación**
- **Material Design 3**: Interfaz moderna y consistente
- **Navegación Dual Sincronizada**: Drawer + Bottom Navigation
- **Responsive Design**: Adaptable a cualquier tamaño de pantalla
- **Temas Dinámicos**: Light/Dark mode con persistencia

### 🛎️ **Sistema de Reservas**
- **Flujo de Reserva Guiado**: 3 pasos (Datos personales → Dirección → Fecha/Hora)
- **Servicios Disponibles**: 
  - Lavado de Carro (Premium, Gold, Sencillo)
  - Lavado de Colchón 
  - Lavado de Alfombra
  - Lavado de Tapete
- **Facturas Detalladas**: Información completa como recibo profesional

### 🧾 **Mis Reservas (Sistema de Facturas)**
- **Información del Técnico**:
  - Nombre completo y experiencia
  - Rating con estrellas
  - Teléfono de contacto directo
- **Datos del Vehículo**:
  - Marca, modelo y año
  - Placa y color para identificación
- **Detalles de Servicio**:
  - Fecha y hora específica
  - Dirección completa
  - Notas especiales del servicio
  - Precio formateado profesionalmente
- **Estados Dinámicos**:
  - 🟢 Confirmado: "¡Gracias por tu reserva!"
  - 🟠 Pendiente: "Estamos procesando tu solicitud"
  - 🔵 Completado: "¡Servicio completado!"

### ⚙️ **Configuraciones Avanzadas**
- **Gestión de Perfil**: Editar datos personales
- **Cambio de Email**: Con validación de nuevo correo
- **Cambio de Contraseña**: Verificación de contraseña actual
- **Configuración de Idioma**: Soporte multiidioma
- **Configuración de Tema**: Light/Dark mode persistente

### 📊 **Backend Integration Ready**
- **Estructura de API**: Preparado para conectar con backend
- **Formato de Datos**: JSON estructurado para registro y login
- **Error Handling**: Manejo de errores de red y servidor
- **Loading States**: Indicadores de carga durante operaciones

## 🎬 Demo de la Aplicación

### 📱 **Pantallas Principales**

#### 🔐 **Autenticación**
- **Login**: Diseño profesional con validación en tiempo real
- **Registro**: Formulario completo con formato colombiano automático

#### 🏠 **Dashboard**  
- **Home**: Navegación intuitiva con servicios destacados
- **Reservas**: Flujo guiado de 3 pasos para reservar servicios
- **Mis Reservas**: Sistema de facturación con detalles profesionales

#### ⚙️ **Configuraciones**
- **Perfil**: Gestión completa de datos personales
- **Temas**: Cambio Light/Dark con persistencia automática
- **Idioma**: Soporte multiidioma preparado

---

## � **Características Técnicas Avanzadas**

### 🎯 **Performance Optimizada**
- **Flutter 3.35.4**: Latest stable con Material 3
- **State Management**: Provider pattern eficiente
- **Memory Management**: Widgets optimizados con const constructors
- **Navigation**: IndexedStack para preservar estados

### 🔒 **Seguridad y Validación**
- **Input Sanitization**: Validación robusta en todos los campos
- **Session Management**: Tokens seguros con SharedPreferences
- **Error Handling**: Manejo profesional de errores de red

### 📱 **Responsive Design**
- **Adaptive Layout**: Funciona perfecto en móviles y Chrome
- **Breakpoints**: Diseño adaptable a cualquier pantalla
- **Touch Optimized**: Interacciones optimizadas para touch

---

## 🤝 **Contribución y Desarrollo**

### 📋 **Roadmap**
- [ ] Backend Integration (API REST)
- [ ] Push Notifications
- [ ] Google Maps Integration
- [ ] Payment Gateway Integration
- [ ] Multi-language Complete Support

### 🛠️ **Development Guidelines**
```bash
# Antes de contribuir
flutter analyze          # Verificar código
flutter test            # Ejecutar tests
flutter format .        # Formatear código
```

### 🔄 **Git Workflow**
1. Fork del proyecto
2. Crear rama feature: `git checkout -b feature/nueva-funcionalidad`
3. Commit descriptivo: `git commit -m 'feat: agregar sistema de pagos'`
4. Push: `git push origin feature/nueva-funcionalidad`
5. Crear Pull Request con descripción detallada

---

## 📞 **Soporte y Contacto**

### 🏢 **MEGA LAVADO S.A.S**
- **Servicios**: Lavado de vehículos y limpieza profesional
- **Cobertura**: Todo Colombia
- **Tecnología**: Flutter App para reservas

### 👨‍💻 **Desarrollo Técnico**
- **Framework**: Flutter 3.35.4
- **Arquitectura**: Clean Architecture + Provider
- **UI/UX**: Material Design 3 + Custom Theme
- **Platform**: iOS, Android, Web (Chrome)

---

## 📝 **Desarrollador**

**Yeison D. González**
- **Ficha**: 2023503
- **Especialización**: Flutter Mobile & Web Development
- **GitHub**: [@yeygok](https://github.com/yeygok)
- **Proyecto**: MEGA LAVADO S.A.S Flutter App

---

## 📄 **Licencia y Legal**

Este proyecto está desarrollado para **MEGA LAVADO S.A.S** bajo Licencia MIT.  
Ver archivo `LICENSE` para términos completos.

---

## 🌟 **¡Agradecimientos!**

Gracias por usar la aplicación **MEGA LAVADO S.A.S**.  
Tu confianza nos impulsa a seguir innovando en servicios de limpieza profesional.

**⭐ Dale una estrella al repositorio si te resultó útil ⭐**

---

