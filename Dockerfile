# Image de base
FROM alpine:3.5

# Installation de Python 3 and pip3
RUN apk add --no-cache --virtual .build-deps g++ python3-dev libffi-dev openssl-dev && \
    apk add --no-cache --update python3 && \
    pip3 install --upgrade pip setuptools

# Mise à jour de pip3
RUN pip3 install --upgrade pip

RUN mkdir /app
WORKDIR /app
COPY * /app/
RUN pip3 install --no-cache-dir -r requirements.txt
RUN pip3 install --no-cache-dir gunicorn

# On ouvre et expose le port 80
EXPOSE 80

# Lancement de l'API
# Attention : ne pas lancer an daemon !
CMD ["gunicorn", "app:app", "-b", "0.0.0.0:80", "-w", "4"]
