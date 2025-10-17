# Use PHP-FPM
FROM php:8.4-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
    nginx \
    git \
    curl \
    zip \
    unzip \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    libpq-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_pgsql pgsql mbstring exif pcntl bcmath gd zip

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy project
WORKDIR /var/www
COPY . .

# Configure Nginx
COPY ./nginx.conf /etc/nginx/nginx.conf

# Expose HTTP port
EXPOSE 80

# Start both services
CMD service nginx start && php-fpm
