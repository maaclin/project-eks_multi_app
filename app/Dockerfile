
FROM nginx:1.25-alpine 

RUN rm -rf /usr/share/nginx/html/*

WORKDIR /usr/share/nginx/html/

COPY . .

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]