from fastapi import FastAPI, HTTPException, Header
import requests
import random
import string
from typing import Optional

# sudo docker compose up -d --build
# sudo docker logs myproject-nginx
# sudo docker logs myproject-web
# https://myproject.local/

app = FastAPI()

@app.get("/")
async def root():
    return {"Server says It's All Good Man"}

@app.get("/data/{numChars}")
async def getData(numChars : int):
    return {'data':''.join(random.choices(string.ascii_lowercase, k=numChars))}

@app.post("/data/")
async def postData(data: str):
    print(data)
    return {"received data"}
