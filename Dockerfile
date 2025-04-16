# Imagen oficial de Python, version Slim para optimizar el tamaño de la imagen final. 
FROM python:3.11.3-slim

# Mejores practicas para mantener limpio el filesystem y mejorar el logging
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# crear un non-root user dentro del contenedor y darle privilegios sobre el workspace para que la aplicacion pueda editar la base de datos. 
RUN addgroup --system appuser && \
    adduser --system --group appuser && \
    mkdir -p /app && \ 
    chown -R appuser:appuser /app/
USER appuser

WORKDIR /app

# Copiar solo el archivo requirements.txt para instalar las dependencias antes de incluir el resto del codigo.
COPY --chown=appuser:appuser requirements.txt .

# Instalar dependencias
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

#Copiar el resto de la aplicación
COPY --chown=appuser:appuser . .

# Esta aplicacion se debe servir por puerto 8000
CMD ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]