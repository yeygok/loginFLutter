# 🔐 Flutter Login App

Una aplicación Flutter completa con sistema de autenticación, navegación y múltiples vistas.

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)

## 📱 Descripción

Aplicación móvil desarrollada en Flutter que implementa un sistema completo de autenticación de usuarios con navegación fluida entre diferentes vistas. La app incluye splash screen, login, registro, perfil de usuario y configuraciones.

### ✨ Características Principales

- 🚀 **Splash Screen** - Pantalla de bienvenida con carga automática
- 🔐 **Sistema de Login** - Autenticación de usuarios
- 📝 **Registro de Usuarios** - Formulario completo de registro
- 🏠 **Pantalla Principal** - Dashboard con navegación
- 👤 **Perfil de Usuario** - Gestión de información personal
- ⚙️ **Configuraciones** - Pantalla de ajustes
- 🧭 **Navegación Dual** - Drawer lateral y bottom navigation
- 📱 **Diseño Responsivo** - Adaptable a diferentes tamaños de pantalla
- 🎨 **UI/UX Moderna** - Interfaz limpia y intuitiva

## 📸 Screenshots

<!-- Agregar screenshots aquí cuando estén disponibles -->
```
🔄 Splash Screen → 🔐 Login → 🏠 Home → 👤 Perfil
```

## 🏗️ Arquitectura del Proyecto

```
lib/
├── auth/                 # 🔐 Módulo de autenticación
│   ├── login.dart       # Pantalla de login
│   └── change_password.dart # Cambio de contraseña
├── home/                # 🏠 Pantalla principal
│   └── home.dart        # Dashboard principal
├── splash/              # 🚀 Splash screen
│   └── splash_app.dart  # Pantalla de carga inicial
├── user/                # 👤 Gestión de usuarios
│   ├── user.dart        # Perfil de usuario
│   └── form.dart        # Formulario de registro
├── widgets/             # 🧩 Componentes reutilizables
│   ├── appbar.dart      # AppBar personalizado
│   ├── navigation_drawer.dart # Menú lateral
│   └── navigation_bottom.dart # Navegación inferior
├── theme/               # 🎨 Temas y estilos
│   └── theme_app.dart   # Configuración de temas
└── main.dart            # 🎯 Punto de entrada
```

## 🚀 Instalación y Configuración

### Prerrequisitos

- [Flutter](https://flutter.dev/docs/get-started/install) >= 3.2.3
- [Dart](https://dart.dev/get-dart) >= 3.2.3
- [Android Studio](https://developer.android.com/studio) o [VS Code](https://code.visualstudio.com/)

### Pasos de Instalación

1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/yeygok/loginFLutter.git
   cd loginFLutter
   ```

2. **Instalar dependencias**
   ```bash
   flutter pub get
   ```

3. **Verificar configuración de Flutter**
   ```bash
   flutter doctor
   ```

4. **Ejecutar la aplicación**
   ```bash
   flutter run
   ```

## 📦 Dependencias

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0
  flutter_launcher_icons: ^0.13.1  # Generación automática de iconos
```

## 🎯 Funcionalidades Detalladas

### 🔐 Sistema de Autenticación
- ✅ Formulario de login con validaciones
- ✅ Registro de nuevos usuarios
- ✅ Validación de campos (email, contraseña, etc.)
- ✅ Navegación automática post-autenticación
- ✅ Función de logout

### 🧭 Sistema de Navegación
- ✅ **Drawer Navigation**: Menú lateral deslizable
- ✅ **Bottom Navigation**: Navegación inferior con 3 tabs
- ✅ **Page Controller**: Transiciones suaves entre pantallas
- ✅ **Estado sincronizado**: Navegación coherente entre ambos métodos

### 👤 Gestión de Usuario
- ✅ Visualización de perfil de usuario
- ✅ Formulario de edición de información
- ✅ Cambio de contraseña (en desarrollo)

### 🎨 Diseño y UI
- ✅ Tema personalizable
- ✅ Iconos personalizados generados automáticamente
- ✅ Diseño Material Design
- ✅ Componentes reutilizables

## 🔧 Configuración de Iconos

La aplicación utiliza `flutter_launcher_icons` para generar automáticamente los iconos:

```bash
# Generar iconos para todas las plataformas
dart run flutter_launcher_icons:main
```

## 🚀 Build y Deploy

### Android APK
```bash
flutter build apk --release
```

### iOS (macOS requerido)
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 🧪 Testing

```bash
# Ejecutar tests
flutter test

# Análisis estático del código
flutter analyze
```

## 📱 Plataformas Soportadas

- ✅ **Android** (API 21+)
- ✅ **iOS** (iOS 11.0+)
- ✅ **Web** (Navegadores modernos)
- ✅ **Windows** (Windows 10+)
- ✅ **macOS** (macOS 10.14+)
- ✅ **Linux** (Ubuntu 18.04+)



## 📝 Licencia

Este proyecto está bajo la licencia MIT - mira el archivo [LICENSE](LICENSE) para detalles.

## 👨‍💻 Autor

**Yeison D. González**
- Ficha: 2023503
- GitHub: [@yeygok](https://github.com/yeygok)
- Email: [tu-email@ejemplo.com] <!-- Agregar email real si deseas -->

## 🙏 Agradecimientos

- [Flutter Team](https://flutter.dev/) por el increíble framework
- [Material Design](https://material.io/) por las guías de diseño
- Casallas Diego instructor

---

