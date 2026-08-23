FROM node:18-alpine

# Install 9router globally
RUN npm install -g 9router

# Create a non-root user and directory
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser
WORKDIR /app

# The port Render will inject
EXPOSE $PORT

# Run 9router using the command we suspect works
# NOTE: If this prompts for input, it will hang.
CMD ["sh", "-c", "9router start --port ${PORT:-10000}"]
