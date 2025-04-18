# [ES] Imagen oficial de Python, version Slim para optimizar el tamaño de la imagen final. 
# [EN] Python official image, slim version to optimize the final image size
FROM python:3.11.3-slim

# [ES] Mejores practicas para mantener limpio el filesystem y mejorar el logging
# [EN] Best practices to keep the filesystem clean and improve logging
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# [ES] crear un non-root user dentro del contenedor y darle privilegios sobre el workspace para que la aplicacion pueda editar la base de datos. 
# [EN] Create a non-root user inside the container and assignt it priveledges over the workspace for the app to be able to edit the database.
RUN addgroup --system appuser && \
    adduser --system --group appuser && \
    mkdir -p /app && \ 
    chown -R appuser:appuser /app/
USER appuser

WORKDIR /app

# [ES] Copiar solo el archivo requirements.txt para instalar las dependencias antes de incluir el resto del codigo.
# [EN] Copy just the requirements.txt file to install the project dependencies before adding the rest of the code.
COPY --chown=appuser:appuser requirements.txt .

# [ES] Instalar dependencias
# [EN] Install dependencies
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# [ES] Copiar el resto de la aplicación
# [EN] Copy the left app code
COPY --chown=appuser:appuser . .

# [ES] Esta aplicacion se debe servir por puerto 8000
# [EN] This application is served on port 8000
CMD ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]