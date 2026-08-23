FROM node:18-alpine

# Install Python and build tools for native SQLite bindings
RUN apk add --no-cache python3 make g++ gcc sqlite-dev

# Install 9router globally
RUN npm install -g 9router

# explicitly install better-sqlite3 globally so 9router can find it
RUN npm install -g better-sqlite3

# Create a non-root user and directory
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser
WORKDIR /app

EXPOSE $PORT

# Run 9router
CMD ["sh", "-c", "9router -p ${PORT:-10000} -H 0.0.0.0 -n -l --skip-update"]
