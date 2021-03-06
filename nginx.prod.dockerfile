##### Stage 1
FROM node:latest as node
LABEL author="Dan Wahlin customized by Johannes Sim"
WORKDIR /app
COPY package.json package.json
RUN npm install
COPY . .
RUN npm run build -- --prod

##### Stage 2
FROM nginx:alpine
VOLUME /var/cache/nginx
COPY --from=node /app/dist /usr/share/nginx/html
COPY ./config/nginx.conf /etc/nginx/conf.d/default.conf

# docker build -t nginx-angular -f nginx.prod.dockerfile .
# docker container run -d --rm -p 8080:80 nginx-angular