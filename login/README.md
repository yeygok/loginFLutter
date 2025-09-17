# 🔐 Flutter Login App

Una aplicación Flutter minimalista y profesional con sistema de autenticación, navegación dual (drawer y bottom navigation) y gestión de usuario.

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)

## 📱 Descripción

Aplicación móvil desarrollada en Flutter que implementa un sistema completo de autenticación de usuarios, navegación fluida y diseño minimalista. Incluye splash screen, login, registro, perfil, cambio de contraseña y configuraciones.

### ✨ Características Principales

- 🚀 **Splash Screen** - Pantalla de bienvenida
- 🔐 **Login** - Autenticación con validación robusta
- 📝 **Registro** - Formulario de registro validado
- 🏠 **Home** - Dashboard principal
- 👤 **Perfil** - Visualización y edición de usuario
- ⚙️ **Configuraciones** - Cambiar correo, contraseña, idioma y tema
- 🧭 **Navegación Dual** - Drawer lateral y bottom navigation minimalista
- 🎨 **Tema Personalizado** - Verde, negro y blanco, profesional y limpio
- 📱 **Responsivo** - Adaptable a cualquier pantalla

## 📸 Screenshots

<!-- Agrega aquí tus screenshots reales de la app -->


## 🏗️ Estructura del Proyecto

```
lib/
├── auth/                 # Autenticación y formularios
│   ├── login.dart
│   └── change_password.dart
├── home/                 # Pantalla principal
│   └── home.dart
├── splash/               # Splash screen
│   └── splash_app.dart
├── user/                 # Perfil y registro
│   ├── user.dart
│   └── form.dart
├── widgets/              # Componentes reutilizables
│   ├── appbar.dart
│   ├── navigation_drawer.dart
│   └── navigation_bottom.dart
├── theme/                # Temas y estilos
│   └── yeygokstilo.dart
└── main.dart             # Punto de entrada
```

## 🚀 Instalación y Ejecución

1. **Clona el repositorio**
   ```bash
   git clone https://github.com/yeygok/loginFLutter.git
   cd loginFLutter
   ```
2. **Instala dependencias**
   ```bash
   flutter pub get
   ```
3. **Ejecuta la app**
   ```bash
   flutter run
   ```

## 📦 Dependencias Principales

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0
  flutter_launcher_icons: ^0.13.1
```

## 🎯 Funcionalidades

- **Validación de Email y Contraseña**: Validación robusta y mensajes claros.
- **Navegación**: Drawer lateral y barra inferior sincronizados.
- **Cambio de correo y contraseña**: Desde la sección de configuración.
- **Tema personalizado**: Verde, negro y blanco, minimalista y profesional.
- **Componentes reutilizables**: AppBar, Drawer, BottomNavigation.
- **Logout**: Cierre de sesión seguro.

## 📝 Autor

**Yeison D. González**
- Ficha: 2023503
- GitHub: [@yeygok](https://github.com/yeygok)

---

