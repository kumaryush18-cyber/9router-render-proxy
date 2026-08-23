FROM node:18-alpine

# Install OS dependencies for node-gyp and SQLite compilation
RUN apk add --no-cache python3 make g++ gcc sqlite-dev

# Install 9router globally
RUN npm install -g 9router

# Environment variable to control where 9router puts its data/runtime.
# Render's ephemeral disk wipes out ~/.9router on reboot, but we can map
# a persistent disk to /data on Render and point 9router to it!
ENV DATA_DIR="/data"

# Create a non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

EXPOSE $PORT

# Run 9router 
CMD ["sh", "-c", "9router -p ${PORT:-10000} -H 0.0.0.0 -n -l --skip-update"]
