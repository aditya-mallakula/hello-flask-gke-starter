# syntax=docker/dockerfile:1
FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1     PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app/ ./app/
WORKDIR /app

RUN useradd -m app && chown -R app /app
USER app

EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=2s --retries=3   CMD wget -qO- http://127.0.0.1:8080/healthz || exit 1

CMD ["gunicorn","-w","2","-b","0.0.0.0:8080","app:app"]
