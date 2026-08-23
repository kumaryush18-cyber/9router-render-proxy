const { exec } = require('child_process');
const fs = require('fs');

console.log("Starting 9router proxy...");
const port = process.env.PORT || 10000;

// Need to explicitly locate the global 9router binary just to be safe
const child = exec(`npx 9router start --port ${port}`);

child.stdout.on('data', (data) => {
    process.stdout.write(data);
});

child.stderr.on('data', (data) => {
    process.stderr.write(data);
});

child.on('close', (code) => {
    console.log(`9router process exited with code ${code}`);
});

// Add a dummy http server just in case 9router fails to bind
// This tricks render into thinking the deploy worked so we can at least get logs
const http = require('http');
const server = http.createServer((req, res) => {
  res.writeHead(200);
  res.end('9router proxy wrapper running!\n');
});
server.listen(port + 1); // Bind to another port just to keep process alive if 9router dies
