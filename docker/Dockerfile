FROM php:8.4-apache

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    libxml2-dev libonig-dev curl ca-certificates gnupg git \
    python3 python3-pip \
    chromium \
    && rm -rf /var/lib/apt/lists/*

# Node.js 22 LTS
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs && rm -rf /var/lib/apt/lists/*

# PHP extensions (xml enables dom + xmlwriter + simplexml)
RUN docker-php-ext-install mysqli mbstring xml

# Apache: serve from www/ subdirectory
COPY docker/apache-uoa.conf /etc/apache2/sites-available/uoa.conf
RUN a2enmod rewrite && a2dissite 000-default && a2ensite uoa

# Claude Code
RUN npm install -g @anthropic-ai/claude-code

# Playwright packages + Chromium browser
WORKDIR /var/www/html/www
COPY www/package.json www/package-lock.json ./
RUN npm ci && npx playwright install --with-deps chromium

# Python / Selenium
COPY www/selenium/requirements.txt /tmp/sel-req.txt
RUN pip3 install --break-system-packages -r /tmp/sel-req.txt

# Non-root user for Claude Code (matches host UID so bind-mount files are writable)
RUN useradd -m -s /bin/bash -u 1000 dev

# Allow dev to self-update Claude Code (npm global install is root-owned by default)
RUN chown -R dev:dev /usr/lib/node_modules/@anthropic-ai/claude-code

COPY docker/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 80
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["apache2-foreground"]
