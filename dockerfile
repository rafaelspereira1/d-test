FROM node:latest as build 

#Define a pasta do app em React
WORKDIR /frexco

#Copia o app em React para o container  
COPY .  /frexco

#Prepara o container para o build do React
RUN npm install --silent
RUN npm install react-scripts@4.0.3 -g --silent

RUN npm run build

#Prepara o NGINX
FROM nginx:1.21.4-alpine
COPY --from=build /frexco/build /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx/nginx.conf /etc/nginx/conf.d 

#Inicia o NGINX

EXPOSE 80
CMD ["nginx", "-g","daemon off;"]