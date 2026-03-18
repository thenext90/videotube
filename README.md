# videotube

Despliegue de `youtube-dl-server` con Docker Compose para usar en local y luego copiar al VPS.

## Requisitos

- Docker Engine + Docker Compose v2

## Levantar en local

1. Copia variables de entorno:

   ```bash
   cp .env.example .env
   cp .auth.env.example .auth.env
   ```

2. Inicia el servicio:

   ```bash
   docker compose up -d
   ```

3. Abre la UI:

   ```
   http://localhost:8090
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

Por defecto expone en el puerto `8090`.

## Login de acceso (usuario/clave)

El acceso a la UI/API está protegido con `Basic Auth` por `Caddy`.

Configura en `.auth.env`:

- `VIDEOTUBE_USER` (ej: `admin`)
- `VIDEOTUBE_PASSWORD_HASH` (hash bcrypt)

Generación rápida (recomendado):

```bash
./scripts/set-auth.sh admin 'TU_PASSWORD_SEGURA'
```

El script crea `.auth.env` con el hash en formato compatible con Docker Compose.

Si prefieres hacerlo manual, empieza con:

```bash
cp .auth.env.example .auth.env
```

Luego reinicia:

```bash
docker compose up -d
```

## Conversión MP4 de alta calidad

La configuración actual prioriza fuente `webm` y luego recodifica a `mp4` con ffmpeg:

- video: `libx264`
- calidad: `-crf 18`
- preset: `slow`
- audio: `aac` a `192k`

## Redes sociales

Se añadieron perfiles en la UI para:

- `TikTok MP4`
- `Instagram MP4`
- `Facebook MP4`

Además, `yt-dlp` ya incluye extractores para esas plataformas en esta instalación.

## Contenido privado (cookies/login)

Para publicaciones privadas o con restricciones de sesión, puedes usar perfiles `Auth`:

- `TikTok MP4 (Auth)`
- `Instagram MP4 (Auth)`
- `Facebook MP4 (Auth)`
- `YouTube MP4 (Auth)`

Pasos:

1. Exporta tus cookies de navegador en formato `Netscape` (archivo `cookies.txt`).
2. Guarda el archivo en `cookies/cookies.txt`.
3. Reinicia el servicio:

   ```bash
   docker compose up -d
   ```

4. En la UI selecciona un perfil `Auth` al descargar.

Notas:

- `cookies/` se monta en modo solo lectura dentro del contenedor.
- `cookies.txt` no se sube a git (está ignorado en `.gitignore`).
- `YouTube MP4 (Auth)` es útil para videos con restricción de edad/sesión.
- Usa solo contenido permitido por la plataforma y tus permisos de cuenta.