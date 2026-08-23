const { execSync } = require('child_process');

console.log("Starting 9router proxy directly...");
const port = process.env.PORT || 10000;

try {
  // Execute it synchronously so the Node process blocks on it.
  // 9router binds to 0.0.0.0 by default, which is what Render needs.
  execSync(`npx 9router start --port ${port}`, { stdio: 'inherit' });
} catch (e) {
  console.error("9router failed to start:");
  console.error(e);
}
