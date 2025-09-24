#!/bin/bash

echo "Запуск Galaxy в Docker..."
date

# Создаём директорию для данных Galaxy
mkdir -p galaxy_storage
cd galaxy_storage || exit 1

# Создаём минимальный конфиг
cat > galaxy.yml <<EOL
galaxy:
  database_connection: sqlite:///./database/galaxy.sqlite?isolation_level=IMMEDIATE
  tool_data_path: ./tool-data
  file_path: ./files
  enable_api: true
  allow_user_creation: true
EOL

echo "Конфиг создан, запускаем Docker контейнер..."

# Запускаем Galaxy в Docker (используем образ с Docker Hub)
docker run -d \
  -p 8080:80 \
  -v "$(pwd):/export" \
  -v "$(pwd)/galaxy.yml:/galaxy-central/config/galaxy.yml" \
  --name my_galaxy \
  bgruening/galaxy-stable

echo "Готово! Проверьте статус контейнера командой: docker ps"