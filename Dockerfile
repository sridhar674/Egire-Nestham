# Use Flutter stable image
FROM cirrusci/flutter:latest

# Set working directory
WORKDIR /app

# Copy pubspec and fetch dependencies
COPY pubspec.* ./
RUN flutter pub get

# Copy the rest of the code
COPY . .

# Build web app (for mobile builds you'd do flutter build apk / ios instead)
RUN flutter build web

# Use a lightweight web server to serve the built files
FROM nginx:alpine
COPY --from=0 /app/build/web /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

