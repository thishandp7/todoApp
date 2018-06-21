FROM todobackend-base-tdp7:latest
MAINTAINER Thishan D Pathmanathan <thishandp7@gmail.com>

RUN apt-get update && \
    apt-get install -qy python3-dev python3-pip libmysqlclient-dev

#Activate virtual environment and wheel support
RUN . /appenv/bin/activate && \
    pip3 install wheel --upgrade

#pip environment variables(Must be set after installing wheel)
ENV WHEELHOUSE=/wheelhouse PIP_WHEEL_DIR=/wheelhouse PIP_FIND_LINKS=/wheelhouse XDG_CACHE_HOME=/cache

#Volumes for build artifacts and test reports
VOLUME /wheelhouse

#volume for build cache
VOLUME /build

VOLUME /reports

COPY scripts/test.sh /usr/local/bin/test.sh
RUN chmod +x /usr/local/bin/test.sh

ENTRYPOINT ["test.sh"]
CMD ["python3", "manage.py", "test", "--noinput"]

#This step need to be done last since this is where most changes occour
COPY src /application
WORKDIR /application
