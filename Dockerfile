# Use Webdevops PHP + Nginx image (PHP 8.2 or newer recommended)
FROM webdevops/php-nginx:8.2-alpine

# Set working directory inside container
WORKDIR /app

# Copy composer files first (for dependency caching)
COPY composer.json composer.lock ./

# Install Composer dependencies in production mode
RUN composer install --no-dev --no-interaction --optimize-autoloader --no-scripts --no-progress

# Copy all Laravel application files
COPY . .

# Ensure storage and cache directories are writable
RUN chmod -R 775 storage bootstrap/cache

# Set environment variables for Render and Laravel
ENV APP_ENV=production \
    APP_DEBUG=false \
    WEB_DOCUMENT_ROOT=/app/public \
    PORT=8080

# Expose Render port
EXPOSE 8080

# Tell Nginx to listen on Render's assigned port ($PORT)
RUN sed -i "s/listen 80;/listen \$PORT;/" /opt/docker/etc/nginx/vhost.conf

# Optimize Laravel for production
RUN php artisan config:cache && \
    php artisan route:cache && \
    php artisan view:cache || true

# Start PHP-FPM and Nginx via supervisor (Webdevops default CMD)
CMD ["/opt/docker/bin/entrypoint.sh"]
