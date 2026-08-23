const { exec } = require('child_process');

console.log("Starting 9router proxy...");
const port = process.env.PORT || 10000;

// Execute the 9router global binary installed by NPM
const child = exec(`npx 9router start --port ${port}`);

child.stdout.on('data', (data) => {
    console.log(`STDOUT: ${data}`);
});

child.stderr.on('data', (data) => {
    console.error(`STDERR: ${data}`);
});

child.on('close', (code) => {
    console.log(`9router process exited with code ${code}`);
});
