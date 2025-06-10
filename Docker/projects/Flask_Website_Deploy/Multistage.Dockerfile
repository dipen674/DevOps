FROM python:3.9.23-bookworm AS build

WORKDIR /build
COPY requirements.txt /build

RUN pip install --upgrade pip && \
    pip install --target /build/packages -r requirements.txt

COPY . .



FROM python:3.9.23-slim-bookworm  AS deploy

LABEL maintainer="Deependra Bhatta"
LABEL version="1.0"

RUN groupadd -r appuser && useradd -r -g appuser -d /app -s /bin/bash appuser

WORKDIR /app


COPY --from=build /build/packages /app/packages
COPY --from=build /build /app


ENV PYTHONPATH=/app/packages
ENV FLASK_APP=app.py


EXPOSE 5000
CMD ["python", "-m", "flask", "run", "--host=0.0.0.0"]
