#!/bin/bash

# Копирование файлов веб-сайта в директорию Apache
sudo cp -R ./src/* /var/www/html/

# Перезапуск Apache для применения изменений
sudo systemctl restart httpd
