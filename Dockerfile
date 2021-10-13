FROM python:3.7.5-slim-buster AS compile-image

## install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc

## Create virtualenv
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

## add and install requirements
RUN pip install --upgrade pip && pip install pip-tools
COPY ./src/requirements.txt .
RUN pip install -r requirements.txt

## build-image
FROM python:3.7.5-slim-buster AS runtime-image

## copy Python dependencies from build image
COPY --from=compile-image /opt/venv /opt/venv

## set working directory
WORKDIR /usr/src/app

## add user
RUN addgroup --system user && adduser --system --no-create-home --group user
RUN chown -R user:user /usr/src/app && chmod -R 755 /usr/src/app


## switch to non-root user
USER user

## add app
COPY . /usr/src/app

## set environment variables
ENV PATH="/opt/venv/bin:$PATH"
ENV REDIS_HOST=redis
ENV REDIS_PORT=6379
ENV BIND_PORT=5000

## run server
CMD python ./src/main.py
