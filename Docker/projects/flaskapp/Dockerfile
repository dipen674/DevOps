FROM python:3.9.23-bookworm

WORKDIR /flask

copy . /flask


RUN pip install --upgrade pip
RUN pip install -r requirements.txt

EXPOSE 5000



CMD ["flask","run","--host=0.0.0.0"]
