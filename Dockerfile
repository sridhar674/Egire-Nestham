# ---------- Build Stage ----------
FROM node:18 AS builder

WORKDIR /app

COPY package*.json yarn.lock* ./
RUN yarn install || npm install

COPY . .

RUN npx expo build:web

# ---------- Production Stage ----------
FROM nginx:alpine

COPY --from=builder /app/web-build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

