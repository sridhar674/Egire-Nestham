# ---------- Build Stage ----------
FROM cirrusci/flutter:latest AS builder

# Set working directory
WORKDIR /app

# Copy pubspec files and get dependencies
COPY pubspec.* ./
RUN flutter pub get

# Copy the rest of the source code
COPY . .

# Build the web version of the Flutter app
RUN flutter build web

# ---------- Production Stage ----------
FROM nginx:alpine

# Copy build output from builder stage to Nginx html folder
COPY --from=builder /app/build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

