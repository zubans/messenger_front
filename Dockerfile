# Stage 1: Build stage using Node.js
FROM node:18 AS build-stage

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json и package-lock.json, чтобы установить зависимости
COPY package*.json ./

# Устанавливаем все необходимые зависимости проекта
RUN npm install

# Добавляем конфигурацию ESLint
# (опционально: если создаете конфигурацию ESLint в проекте, она должна быть копирована)
COPY .eslintrc.js ./

# Копируем весь исходный код проекта
COPY . .

RUN npm install vuex@3 --save

# Устанавливаем ESLint (если не установлен глобально)
RUN npm install eslint eslint-plugin-vue --save-dev

# Выполняем линтинг исходного кода
RUN npm run lint

# Сборка проекта
RUN npm run build

# Stage 2: Production stage using Nginx
FROM nginx:alpine AS production-stage

# Копируем собранный проект в папку Nginx
COPY --from=build-stage /app/dist /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

# Экспонируем порт 80 для доступа извне
EXPOSE 80

# Запускаем Nginx
CMD ["nginx", "-g", "daemon off;"]