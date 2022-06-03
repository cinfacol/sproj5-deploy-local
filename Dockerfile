FROM python:3.9.13-alpine3.16
LABEL maintainer="cinfacol@gmail.com"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
COPY ./app /app

WORKDIR /app
EXPOSE 8000

RUN pip install --upgrade pip && \
  apk add --update --no-cache postgresql-client libffi-dev && \
  apk add --update --no-cache --virtual .tmp-deps  \
  build-base postgresql-dev musl-dev && \
  pip install -r /requirements.txt && \
  apk del .tmp-deps && \
  adduser --disabled-password --no-create-home app && \
  # chown -R app:app /app && \
  mkdir -p /vol/web/static && \
  mkdir -p /vol/web/media && \
  chown -R app:app /vol && \
  chmod -R 755 /vol
# chmod -R +x /scripts

ENV PATH="$PATH"

USER app

# CMD [ "run.sh" ]
