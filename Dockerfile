FROM nginx:alpine
COPY . /usr/share/nginx/html
EXPOSE 87
CMD ["nginx", "-g", "daemon off;"]
