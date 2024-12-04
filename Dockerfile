FROM python:3.9 AS builder

RUN apt update && apt upgrade -y
RUN apt install git -y
COPY requirements.txt /requirements.txt
FROM python:3.9-slim AS prod
RUN cd /
RUN pip3 install -U pip && pip3 install -U -r requirements.txt
RUN mkdir /IMDb-Movie-Bot
WORKDIR /IMDb-Movie-Bot
COPY start.sh /start.sh
CMD ["/bin/bash", "/start.sh"]

