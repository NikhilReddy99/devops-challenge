FROM node:18-alpine AS build
WORKDIR /app
COPY package.json ./
RUN npm ci --silent
COPY src ./src
RUN npm run build || true

FROM node:18-alpine
WORKDIR /app
RUN npm install -g http-server
COPY src ./src
EXPOSE 3000
CMD ["http-server","./src","-p","3000"]
