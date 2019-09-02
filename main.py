import os

from asonic import Client
from asonic.enums import Channels
from fastapi import FastAPI

SONIC_HOST = os.environ['SONIC_HOST']
SONIC_PORT = os.environ['SONIC_PORT']
SONIC_PASSWORD = os.environ['SONIC_PASSWORD']


app = FastAPI()


def sonic_client():
    return Client(
        host=SONIC_HOST,
        port=SONIC_PORT,
        password=SONIC_PASSWORD,
        max_connections=100,
    )


@app.get("/query/{collection}/{bucket}/{term}")
async def query(collection: str, bucket: str, term: str):
    """Perform a `query` of some term vs some sonic bucket."""
    print(collection, bucket, term)
    c = sonic_client()
    await c.channel(Channels.SEARCH.value)
    result = await c.query(collection, bucket, term)
    return {'result': result}


@app.get("/suggest/{collection}/{bucket}/{term}")
async def suggest(collection: str, bucket: str, term: str):
    """Perform a `suggest` of some term vs some sonic bucket."""
    c = sonic_client()
    await c.channel(Channels.SEARCH.value)
    result = await c.suggest(collection, bucket, term, 1)
    return {'result': result}
