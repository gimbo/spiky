FROM python:3.7.4-alpine3.10

# This is based on https://stackoverflow.com/a/54763270
#
# It's not really best practice, e.g. we'd prefer not to pip install poetry
# (because of possible dependency clashes), it doesn't run in a venv, and it
# runs as root. But as a quick and dirty solution it's OK. :-)


ENV \
    PYTHONFAULTHANDLER=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONHASHSEED=random \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    POETRY_VERSION=0.12.11


RUN apk --no-cache add \
     bash \
     build-base \
     gcc \
     gettext \
     libffi-dev \
     linux-headers \
     musl-dev \
     tini \
     && pip install -U "pip<19.0" \
     && pip install "poetry==$POETRY_VERSION"


WORKDIR /code
COPY poetry.lock pyproject.toml /code/


RUN poetry config settings.virtualenvs.create false \
    && poetry install $(test "$YOUR_ENV" == production && echo "--no-dev") --no-interaction --no-ansi


COPY . /code


ENTRYPOINT ["/sbin/tini", "--"]
CMD /usr/local/bin/uvicorn --host 0.0.0.0 main:app
