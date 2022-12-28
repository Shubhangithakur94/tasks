FROM node:16-alpine AS builder
WORKDIR /app
COPY . .
RUN npm install -g @angular/cli
RUN npm install
RUN npm run build --output-path=dist --configuration=$CONFIGURATION --output-hashing=all
FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /app/dist/ /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
