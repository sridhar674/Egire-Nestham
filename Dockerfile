# Use Node.js runtime
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy app.js
COPY app.js ./

# Expose the port your app uses (example: 3000)
EXPOSE 3000

# Run the app
CMD ["node", "app.js"]

