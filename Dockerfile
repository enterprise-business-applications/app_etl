FROM python:3.11

WORKDIR /app_etl

RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

COPY requirements.txt requirements.txt

RUN pip install --cache-dir /pip.cache --src /usr/local/src -r requirements.txt

COPY ./src/app_etl/api api
COPY ./src/app_etl/etl etl
COPY ./src/app_etl/gateway gateway
COPY ./src/app_etl/migrations migrations
COPY ./src/app_etl/repository repository
COPY ./src/app_etl/app_flask.py app_flask.py

CMD ["python", "-m", "flask", "--app", "app_flask", "run", "--host=0.0.0.0"]