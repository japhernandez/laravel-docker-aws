FROM php:7.4-apache
# FROM php:7.3.2-apache-stretch

# Arguments defined in docker-compose.yml
# ARG user
# ARG uid

COPY --chown=www-data:www-data . /srv/app

COPY docker/vhost.conf /etc/apache2/sites-available/000-default.conf

WORKDIR /srv/app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Clear cache
# RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install mbstring pdo pdo_mysql \
    && a2enmod rewrite negotiation \
    && docker-php-ext-install opcache

# Get latest Composer
# COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

## Create system user to run Composer and Artisan Commands
# RUN useradd -G www-data,root -u $uid -d /home/$user $user
# RUN mkdir -p /home/$user/.composer && \
#    chown -R $user:$user /home/$user
#
## Set working directory
# WORKDIR /var/www
#
# USER $user
