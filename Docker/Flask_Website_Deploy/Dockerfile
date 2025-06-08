FROM python:3.9.23-bookworm

WORKDIR /app

COPY . /app

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

ENV FLASK_APP=app.py

EXPOSE 5000

LABEL "com.example.vendor"="Big Star Collectibles"
LABEL version="1.0"
LABEL description="The Big Star Collectibles Website \
using the Python base image."



CMD [ "flask", "run", "--host=0.0.0.0" ]
