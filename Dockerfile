FROM nginx:alpine
COPY . /usr/share/nginx/html
EXPOSE 88
CMD ["nginx", "-g", "daemon off;"]
