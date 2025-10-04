// CONFIGURACIÓN CORS PARA TU SERVIDOR NODE.JS/EXPRESS
// Agrega esto a tu archivo server.js o app.js

const express = require('express');
const cors = require('cors'); // npm install cors

const app = express();

// CONFIGURACIÓN CORS - IMPORTANTE PARA FLUTTER WEB
const corsOptions = {
  origin: [
    'http://localhost:3000',      // Puerto típico de desarrollo
    'http://localhost:65315',     // Puerto que usa Flutter web
    'http://127.0.0.1:3000',
    'http://127.0.0.1:65315',
    'http://192.168.137.39:3000', // Tu IP local
    'http://localhost:8080',      // Otros puertos comunes
    'http://localhost:5000',
    'http://localhost:4000',
  ],
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: [
    'Content-Type',
    'Authorization',
    'Accept',
    'Origin',
    'X-Requested-With'
  ],
  credentials: true,
  optionsSuccessStatus: 200
};

// Aplicar CORS antes de tus rutas
app.use(cors(corsOptions));

// O si quieres permitir TODOS los orígenes (menos seguro):
// app.use(cors());

// Tus rutas van después de CORS
app.use(express.json());

// Ejemplo de endpoint de login
app.post('/api/auth/login', (req, res) => {
  const { email, password } = req.body;

  console.log('Login attempt:', { email, password });

  // Tu lógica de autenticación aquí
  if (email === 'test@example.com' && password === 'password123') {
    res.json({
      success: true,
      message: "Login exitoso",
      token: "test_jwt_token_" + Date.now(),
      user: {
        id: 1,
        name: "Usuario Test",
        email: email,
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

// Endpoint de verificación de token
app.get('/api/auth/verify', (req, res) => {
  const token = req.headers.authorization?.replace('Bearer ', '');

  if (token && token.startsWith('test_jwt_token_')) {
    res.json({ success: true, message: "Token válido" });
  } else {
    res.status(401).json({ success: false, message: "Token inválido" });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, '0.0.0.0', () => {
  console.log(`🚀 Servidor corriendo en puerto ${PORT}`);
  console.log(`🌐 Accesible en:`);
  console.log(`   - http://localhost:${PORT}`);
  console.log(`   - http://127.0.0.1:${PORT}`);
  console.log(`   - http://192.168.137.39:${PORT}`);
});