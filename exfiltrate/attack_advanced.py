import requests 

r = requests.get("https://myproject.local/",verify=False)
print(r.status_code,r.content)