# Imagen oficial de Python, version Slim para optimizar el tamaño de la imagen final. 
FROM python:3.11.3-slim

WORKDIR /app

# Mejores practicas para mantener limpio el filesystem y mejorar el logging
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Non-root user dentro del contenedor
RUN addgroup --system appuser && adduser --system --group appuser
USER appuser

# Copiar solo el archivo requirements.txt para instalar las dependencias antes de incluir el resto del codigo.
COPY --chown=appuser:appuser requirements.txt .

# Instalar dependencias
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

COPY --chown=appuser:appuser . .

ENV PATH="/home/appuser/venv/bin:$PATH"

CMD ["python", "app.py"]