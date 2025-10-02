// EJEMPLO DE API BACKEND PARA TESTING
// Este archivo contiene ejemplos de cómo debería responder tu API

/*
ENDPOINT: POST /api/auth/login

REQUEST BODY:
{
  "email": "usuario@example.com",
  "password": "password123"
}

RESPONSE SUCCESS (200):
{
  "success": true,
  "message": "Login exitoso",
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": 1,
    "name": "Juan Pérez",
    "email": "usuario@example.com",
    "phone": "+573001234567",
    "avatar": "https://api.example.com/avatars/user1.jpg",
    "created_at": "2024-01-15T10:30:00Z"
  }
}

RESPONSE ERROR - CREDENCIALES INCORRECTAS (401):
{
  "success": false,
  "message": "Credenciales incorrectas"
}

RESPONSE ERROR - DATOS INVÁLIDOS (422):
{
  "success": false,
  "message": "El email es requerido"
}

ENDPOINT: GET /api/auth/verify
HEADERS:
Authorization: Bearer <token>

RESPONSE SUCCESS (200):
{
  "success": true,
  "message": "Token válido"
}

RESPONSE ERROR - TOKEN INVÁLIDO (401):
{
  "success": false,
  "message": "Token inválido o expirado"
}
*/

// DATOS DE PRUEBA PARA TESTING
class TestData {
  // Credenciales válidas para testing
  static const String testEmail = 'test@mega-lavado.com';
  static const String testPassword = 'Test123!';

  // Respuesta de login exitoso
  static const String mockLoginSuccess = '''
  {
    "success": true,
    "message": "Login exitoso",
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.test.mock.token",
    "user": {
      "id": 1,
      "name": "Usuario de Prueba",
      "email": "test@mega-lavado.com",
      "phone": "+573001234567",
      "avatar": null,
      "created_at": "2024-01-15T10:30:00Z"
    }
  }
  ''';

  // Respuesta de error
  static const String mockLoginError = '''
  {
    "success": false,
    "message": "Credenciales incorrectas"
  }
  ''';
}

/*
// EJEMPLO DE SERVIDOR NODE.JS/EXPRESS PARA TESTING:

const express = require('express');
const app = express();

app.use(express.json());

// Endpoint de login
app.post('/api/auth/login', (req, res) => {
  const { email, password } = req.body;

  // Validación simple para testing
  if (email === 'test@mega-lavado.com' && password === 'Test123!') {
    res.json({
      success: true,
      message: "Login exitoso",
      token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.test.mock.token",
      user: {
        id: 1,
        name: "Usuario de Prueba",
        email: "test@mega-lavado.com",
        phone: "+573001234567",
        avatar: null,
        created_at: "2024-01-15T10:30:00Z"
      }
    });
  } else {
    res.status(401).json({
      success: false,
      message: "Credenciales incorrectas"
    });
  }
});

// Endpoint de verificación de token
app.get('/api/auth/verify', (req, res) => {
  const token = req.headers.authorization?.replace('Bearer ', '');

  if (token === 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.test.mock.token') {
    res.json({ success: true, message: "Token válido" });
  } else {
    res.status(401).json({ success: false, message: "Token inválido" });
  }
});

app.listen(3000, () => {
  console.log('API Server running on port 3000');
});
*/
