from fastapi import FastAPI, HTTPException, Header
import requests

app = FastAPI()

@app.get("/")
async def root():
    return {"Server says It's All Good Man"}

# method to post information to server and write in .bin file (update)
@app.post("/information")
async def postInfo(information):
    pass

# method to get information from the server ... (download)
@app.get("/information")
async def getInfo():
    pass
