FROM node:22
WORKDIR /usr/src/app

# Fija una versión de npm sin el bug de "Exit handler never called"
RUN npm install -g npm@10.8.2

COPY package*.json ./

# Reintentos y timeouts más generosos por si hay problemas de red
RUN npm install --no-fund --no-audit \
    --fetch-retries=5 \
    --fetch-retry-mintimeout=20000 \
    --fetch-timeout=600000

COPY index.js .
EXPOSE 3000
CMD ["node", "index.js"]
