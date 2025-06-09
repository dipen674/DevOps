FROM python:3.9.23-bookworm

WORKDIR /app

COPY . /app

RUN pip install --upgrade pip \
    pip install -r requirements.txt

ENV FLASK_APP=app.py

EXPOSE 5000


CMD [ "flask", "run", "--host=0.0.0.0" ]




