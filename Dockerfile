# Use a PHP base image with FPM (choose appropriate version, e.g. 8.4 or 8.x)
FROM php:8.4-fpm

# Arguments for user creation (map host user to container)
ARG USER=wwwuser
ARG UID=1000

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    # any others you need
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions required by Laravel
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

# Install Composer (copy from official composer image)
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create a non-root user (so file permissions are nicer)
RUN useradd -G www-data,root -u ${UID} -d /home/${USER} ${USER} \
    && mkdir -p /home/${USER}/.composer \
    && chown -R ${USER}:${USER} /home/${USER}

# Set working directory
WORKDIR /var/www

# Copy project files
COPY . /var/www

# Change ownership to our user
RUN chown -R ${USER}:${USER} /var/www

# Switch to non-root user
USER ${USER}

# Expose the port (if needed)
EXPOSE 9000

# Default command
CMD ["php-fpm"]
