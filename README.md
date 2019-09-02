# Spiky - a simple API wrapping a sonic search backend

This is just a very very simple wrapper around the
[sonic](https://github.com/valeriansaliou/sonic) search backend, using the
[asonic](https://github.com/moshe/asonic) client library and
[FastAPI](https://fastapi.tiangolo.com/).

## Env vars you'll need to set

* `SONIC_HOST`
* `SONIC_PORT`
* `SONIC_PASSWORD`

## Local installation

* python >= 3.7  (should work with 3.6 actually but then tweak `pyproject.toml`)
* poetry

Then: `poetry install`

## Running

`uvicorn main:app --reload`

## Docker

Yes.

## API

There are just two endpoints:

* `/query/{collection:str}/{bucket:str}/{term:str}`
* `/suggest/{collection:str}/{bucket:str}/{term:str}`

I'm basically wrapping up the "Search channel" example from the [asonic
docs](https://github.com/moshe/asonic) but returning the results rather than
checking them against the expected result as happens there.

For more details, see API docs:

* [Swagger docs](http://127.0.0.1:8000/docs)
* [ReDoc docs](http://127.0.0.1:8000/redoc)