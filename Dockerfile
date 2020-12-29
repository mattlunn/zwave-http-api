# Builder
FROM node:14-slim AS builder
WORKDIR /usr/src/app
COPY . .
RUN npm install
RUN npm run build

# Production
FROM node:14-slim
ENV NODE_ENV=production
WORKDIR /usr/src/app

COPY ./package* ./
RUN npm ci --only=production
COPY --from=builder /usr/src/app/dist ./dist

EXPOSE 3000
CMD npm start