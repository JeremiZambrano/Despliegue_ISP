FROM node:22
WORKDIR /usr/src/app

RUN npm install -g npm@10.8.2

COPY package*.json ./

# Limpiamos cualquier instalación previa corrupta y usamos npm ci (más estricto y confiable que npm install)
RUN rm -rf node_modules && \
    npm cache clean --force && \
    npm ci --no-fund --no-audit \
    --fetch-retries=5 \
    --fetch-retry-mintimeout=20000 \
    --fetch-timeout=600000

COPY index.js .
EXPOSE 3000
CMD ["node", "index.js"]
