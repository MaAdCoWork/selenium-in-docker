# Usa una imagen base de Python
FROM python:3.11

# Actualiza e instala las dependencias necesarias, junto con Firefox
RUN apt-get update \
    && apt-get install -y firefox-esr \
    && apt-get -y install coreutils \ 
    && rm -rf /var/lib/apt/lists/* \
    && which firefox

# Install GeckoDriver
ADD https://github.com/mozilla/geckodriver/releases/download/v0.34.0/geckodriver-v0.34.0-linux64.tar.gz /usr/local/bin/
RUN tar -xzf /usr/local/bin/geckodriver-v0.34.0-linux64.tar.gz -C /usr/local/bin/

# Set the working directory
WORKDIR /selenium_tests/

# Copy the folder with the tests into the container
COPY selenium_tests/ /selenium_tests/

# Install all dependencies
RUN pip install -r requirements.txt

# Ejecutar las pruebas
RUN pytest -v