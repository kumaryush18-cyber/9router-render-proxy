FROM node:18-alpine

# Install Python and build tools for native SQLite bindings
RUN apk add --no-cache python3 make g++ gcc sqlite-dev

# Set an environment variable so 9router knows where to store data
ENV DATA_DIR="/data"
RUN mkdir -p /data && chown -R 1000:100 /data

# Install 9router globally
RUN npm install -g 9router

# explicitly install better-sqlite3 globally so 9router can find it
RUN npm install -g better-sqlite3

# We must run a postinstall script or tell 9router where better-sqlite3 is
ENV NODE_PATH="/usr/local/lib/node_modules"

# Create a non-root user and directory (matching the chown above)
# Alpine's default 'users' group is gid 100
RUN adduser -u 1000 -S appuser -G users
USER appuser
WORKDIR /app

EXPOSE $PORT

# Run 9router 
CMD ["sh", "-c", "9router -p ${PORT:-10000} -H 0.0.0.0 -n -l --skip-update"]
