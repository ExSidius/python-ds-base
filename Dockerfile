
FROM continuumio/anaconda3:latest

RUN apt-get update && apt-get upgrade -yf && \
  apt-get install -yf --no-install-recommends \
  software-properties-common \
  make \
  nano \
  build-essential && \
  rm -rf /var/lib/apt/lists/*

ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

RUN pip install --upgrade pip
ADD ./requirements.txt /requirements.txt
RUN pip install --ignore-installed -r /requirements.txt

COPY ./ /code

ENV PYTHONPATH "${PYTHONPATH}:/code"
