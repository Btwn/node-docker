# syntax=docker/dockerfile:1

FROM node:12.18.1 as base
WORKDIR /code
COPY package.json package.json
COPY package-lock.json package-lock.json

FROM base as test
RUN npm ci
COPY . .
RUN npm run test

FROM base as prod
ENV NODE_ENV=production
RUN npm install --production
COPY . .
CMD ["node", "server.js"]
