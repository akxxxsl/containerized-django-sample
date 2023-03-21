# Utilisez l'image officielle Python avec Alpine Linux comme base
FROM python:3.9-alpine

# Installez les dépendances nécessaires pour psycopg2
RUN apk add --no-cache postgresql-libs && \
    apk add --no-cache --virtual .build-deps gcc musl-dev postgresql-dev

# Créez un répertoire pour l'application et définissez-le comme répertoire de travail
WORKDIR /app

# Copiez les fichiers requirements.txt et installez les dépendances
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Supprimez les dépendances de construction
RUN apk --purge del .build-deps

# Copiez le reste de l'application
COPY . .

# Exposez le port sur lequel Gunicorn va s'exécuter
EXPOSE 8000

# Lancez Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "3", "project.wsgi:application"]