// server.js

const WebSocket = require('ws');
const express = require('express');
const http = require('http');
const { getRandomPrice } = require('./src/utils');
const { PORT, STOCKS } = require('./config/config');

const app = express();
const server = http.createServer(app);
const wss = new WebSocket.Server({ server });

const sendStockUpdates = () => {
  const updates = STOCKS.map(symbol => ({
    symbol,
    price: getRandomPrice()
  }));
  wss.clients.forEach(client => {
    if (client.readyState === WebSocket.OPEN) {
      client.send(JSON.stringify(updates));
    }
  });
};

wss.on('connection', ws => {
  const interval = setInterval(sendStockUpdates, 1000);

  ws.on('close', () => {
    clearInterval(interval);
  });
});

// API endpoint to get stock updates
app.get('/api/stockUpdates', (req, res) => {
  const updates = STOCKS.map(symbol => ({
    symbol,
    price: getRandomPrice()
  }));
  res.json(updates);
});

server.listen(PORT, () => {
  console.log(`Server started on http://localhost:${PORT}`);
});
