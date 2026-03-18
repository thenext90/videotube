# videotube

Despliegue de `youtube-dl-server` con Docker Compose para usar en local y luego copiar al VPS.

## Requisitos

- Docker Engine + Docker Compose v2

## Levantar en local

1. Copia variables de entorno:

   ```bash
   cp .env.example .env
   ```

2. Inicia el servicio:

   ```bash
   docker compose up -d
   ```

3. Abre la UI:

   ```
   http://localhost:8080
   ```

## Estructura

- `docker-compose.yml`: servicio `videotube`
- `config.yml`: configuración de la app
- `data/`: descargas y base de datos sqlite (no se versiona)

## Operación

Ver logs:

```bash
docker compose logs -f
```

Actualizar imagen:

```bash
docker compose pull
docker compose up -d
```

Detener:

```bash
docker compose down
```

## Copiar al VPS

En el VPS, clona este repo y ejecuta:

```bash
cp .env.example .env
docker compose up -d
```

Por defecto expone en el puerto `8080`.