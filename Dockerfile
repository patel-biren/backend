
FROM node:20-slim AS builder

WORKDIR /app

COPY package*.json ./
COPY tsconfig.json ./

RUN npm ci && npm cache clean --force

COPY src ./src

RUN npm run build

FROM node:20-slim

WORKDIR /app

COPY package*.json ./

RUN npm ci && npm cache clean --force

COPY --from=builder /app/dist ./dist

EXPOSE 3000

CMD ["node", "dist/index.js"]
