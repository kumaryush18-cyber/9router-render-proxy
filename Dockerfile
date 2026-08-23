FROM node:18-alpine

# Install 9router globally
RUN npm install -g 9router

# Create a non-root user and directory
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser
WORKDIR /app

EXPOSE $PORT

# Run 9router using the actual CLI flags
# -n: Don't open browser automatically (CRITICAL FOR HEADLESS/RENDER)
# -l: Show server logs
# --skip-update: Skip auto-update check to prevent hanging
CMD ["sh", "-c", "9router -p ${PORT:-10000} -H 0.0.0.0 -n -l --skip-update"]
