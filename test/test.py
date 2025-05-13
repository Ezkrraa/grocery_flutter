import requests
import io

route = "https://api.boodschappen-app.nl:5000"


def create_acc(username: str, pw: str, email: str):
    url = f"{route}/api/auth/create"
    with open("c3po.jpg", "rb") as img:
        payload = {"UserName": (None, username), "Password": (None, pw), "Email": (None, email), "ProfilePicture": ("robot.jpg", img.read(), "image/jpg", None)}
    response = requests.post(url, files=payload)
    response.raise_for_status()
    print(f"Created {username}")


def get_jwt(username: str, pw: str) -> str:
    url = f"{route}/api/auth/login"

    payload = {"Username": username, "Password": pw}
    headers = {"Content-Type": "application/json"}

    response = requests.request("POST", url, json=payload, headers=headers)
    return response.text


def get_id(username: str, jwt: str):
    url = f"{route}/api/user/" + username
    headers = {"Content-Type": "application/json", "Authorization": "Bearer " + jwt}
    response = requests.get(url, headers=headers)
    return response.json()[0]["id"]


def accept_invite(username: str, group_id: str):
    url = f"{route}/api/group/accept-invite"
    jwt = get_jwt(username, "Password_123?")
    my_id = get_id(username, jwt)
    payload = {"groupId": group_id, "userId": my_id}
    headers = {"Content-Type": "application/json", "Authorization": "Bearer " + jwt}
    response = requests.post(url, json=payload, headers=headers)
    print(response.status_code)


for i in range(4000, 5000):
    create_acc(f"Test-{i}", "Password_123?", f"Test-{i}@test.com")
