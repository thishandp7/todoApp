FROM todobackend-base-tdp7:latest
MAINTAINER Thishan D Pathmanathan <thishandp7@gmail.com>

COPY target /wheelhouse

RUN . /appenv/bin/activate && \
    pip3 install --no-index -f /wheelhouse todobackend && \
    rm -rf /wheelhouse
