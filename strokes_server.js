const http = require('http');
const url = require('url');
const hanzi = require('/www/wwwroot/name.imoons.cn/node_modules/hanzi');

hanzi.start();

const PORT = 8087;

const server = http.createServer((req, res) => {
  const parsedUrl = url.parse(req.url, true);
  const chars = (parsedUrl.query.chars || '').split(',').slice(0, 20);
  const result = {};
  chars.forEach(c => {
    c = c.trim();
    if (!c) return;
    try {
      const dec = hanzi.decompose(c);
      result[c] = (dec && dec.components3) ? dec.components3.length : 0;
    } catch(e) {
      result[c] = 0;
    }
  });
  res.writeHead(200, {'Content-Type': 'application/json; charset=utf-8'});
  res.end(JSON.stringify(result));
});

server.listen(PORT, '127.0.0.1', () => {
  console.log(`Strokes service running on port ${PORT}`);
});
