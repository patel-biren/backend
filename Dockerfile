FROM node:22-slim AS builder

WORKDIR /app

COPY package*.json ./
COPY tsconfig.json ./

RUN npm ci --include=dev && npm cache clean --force

COPY src ./src

RUN npm run build

FROM node:22-slim

ENV NODE_ENV=production

RUN groupadd -r nodeuser && useradd -r -g nodeuser nodeuser

WORKDIR /app

COPY package*.json ./

RUN npm ci --omit=dev && npm cache clean --force

COPY --from=builder /app/dist ./dist

RUN chown -R nodeuser:nodeuser /app

USER nodeuser

EXPOSE 3000

CMD ["node", "dist/index.js"]