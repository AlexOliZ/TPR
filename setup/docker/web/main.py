from fastapi import FastAPI, HTTPException, Header
import requests

app = FastAPI()

@app.get("/")
async def root():
    return {"Server says It's All Good Man"}
