# Use Bitnami's official Laravel image as the base
FROM bitnami/laravel:latest

# Set working directory
WORKDIR /app

# Copy composer files first (for build cache)
COPY composer.json composer.lock ./

# Install dependencies (production only, optimize autoloader)
RUN composer install --no-dev --optimize-autoloader --no-interaction --no-scripts --no-progress

# Copy all application files
COPY . .

# Ensure storage and cache directories are writable
RUN chmod -R 775 storage bootstrap/cache

# Set Laravel environment variables (Render will override these)
ENV APP_ENV=production \
    APP_DEBUG=false \
    APP_STORAGE_PATH=/app/storage \
    PORT=8080

# Expose port for Render
EXPOSE 8080

# Update Nginx config to listen on the Render-assigned port
RUN sed -i "s/listen 8080;/listen \$PORT;/" /opt/bitnami/nginx/conf/server_blocks/laravel-server-block.conf

# Start PHP-FPM and Nginx in the foreground
CMD ["nami", "start", "--foreground", "php-fpm", "nginx"]
