    # Stage de construction
    FROM node:16-alpine as build-step
    WORKDIR /app
    COPY package.json package-lock.json ./
    RUN npm install --legacy-peer-deps
    COPY . .
    RUN npm run build

    # Stage de déploiement
    FROM nginx:alpine
    COPY --from=build-step /app/dist/* /usr/share/nginx/html/
    EXPOSE 80
    CMD ["nginx", "-g", "daemon off;"]
