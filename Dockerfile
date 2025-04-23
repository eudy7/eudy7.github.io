# Usa una imagen base con Node.js v18.x para construir la aplicación
FROM node:18 AS build

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar los archivos del proyecto Angular a la imagen
COPY . .

# Instalar dependencias
RUN npm install

# Construir la aplicación para producción
RUN npm run build --prod

# Usar una imagen base de Apache para servir la aplicación
FROM httpd:2.4

# Copiar los archivos generados por Angular al directorio de Apache
COPY --from=build /app/dist/mycv/ /usr/local/apache2/htdocs/

# Exponer el puerto 80 para que la app sea accesible
EXPOSE 80
