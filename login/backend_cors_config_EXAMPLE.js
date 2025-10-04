// Configuración de CORS para tu backend Node.js
// Este archivo debe estar en la raíz de tu proyecto backend

const express = require('express');
const cors = require('cors');

const app = express();

// ============================================
// CONFIGURACIÓN DE CORS PARA DESARROLLO
// ============================================

const corsOptions = {
  origin: function (origin, callback) {
    // Lista de orígenes permitidos
    const allowedOrigins = [
      'http://localhost:3000',
      'http://localhost:8080',
      'http://localhost:5000',
      'http://127.0.0.1:3000',
      'http://127.0.0.1:8080',
      'http://10.31.103.28:3000',
      'http://10.31.103.28:8080',
      // Orígenes de Flutter Web (genera puertos aleatorios)
      /^http:\/\/localhost:\d+$/,
      /^http:\/\/127\.0\.0\.1:\d+$/,
      // Permitir requests sin origin (apps móviles, Postman, curl)
      undefined,
      null
    ];

    // Si no hay origin (apps móviles) o está en la lista, permitir
    if (!origin || 
        allowedOrigins.includes(origin) || 
        allowedOrigins.some(allowed => allowed instanceof RegExp && allowed.test(origin))) {
      callback(null, true);
    } else {
      console.log(`❌ CORS bloqueado para origen: ${origin}`);
      callback(new Error('Not allowed by CORS'));
    }
  },
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH', 'OPTIONS'],
  allowedHeaders: [
    'Content-Type', 
    'Authorization', 
    'X-Requested-With',
    'Accept',
    'Origin'
  ],
  exposedHeaders: ['Content-Length', 'X-Request-Id'],
  maxAge: 86400 // 24 horas
};

// Aplicar CORS
app.use(cors(corsOptions));

// Middleware adicional para logs de CORS
app.use((req, res, next) => {
  const origin = req.headers.origin;
  console.log(`📡 Request desde: ${origin || 'sin origin (mobile app)'}`);
  next();
});

// ============================================
// MIDDLEWARE PARA PREFLIGHT
// ============================================

app.options('*', cors(corsOptions));

// ============================================
// TUS RUTAS
// ============================================

app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true, limit: '10mb' }));

// Health check
app.get('/health', (req, res) => {
  res.json({ 
    status: 'OK', 
    timestamp: new Date().toISOString(),
    cors: 'enabled'
  });
});

// Tus rutas de API
app.use('/api', require('./routes'));

// ============================================
// SERVIDOR
// ============================================

const PORT = process.env.PORT || 3000;
const HOST = '0.0.0.0'; // ✅ Importante: escuchar en todas las interfaces

app.listen(PORT, HOST, () => {
  console.log(`🚀 Servidor corriendo en http://${HOST}:${PORT}`);
  console.log(`✅ CORS habilitado para desarrollo`);
  console.log(`📱 Apps móviles pueden conectarse desde cualquier origen`);
  console.log(`🌐 Flutter Web puede conectarse desde localhost`);
});

module.exports = app;
