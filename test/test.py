import requests


def get_jwt(username: str, pw: str) -> str:
    url = "http://localhost:7020/api/auth/login"

    payload = {"Username": username, "Password": pw}
    headers = {"Content-Type": "application/json"}

    response = requests.request("POST", url, json=payload, headers=headers)
    return response.text


def get_id(username: str, jwt: str):
    url = "http://localhost:7020/api/user/" + username
    headers = {"Content-Type": "application/json", "Authorization": "Bearer " + jwt}
    response = requests.get(url, headers=headers)
    return response.json()[0]["id"]


def accept_invite(username: str, group_id: str):
    url = "http://localhost:7020/api/group/accept-invite"
    jwt = get_jwt(username, "Password_123?")
    my_id = get_id(username, jwt)
    payload = {"groupId": group_id, "userId": my_id}
    headers = {"Content-Type": "application/json", "Authorization": "Bearer " + jwt}
    response = requests.post(url, json=payload, headers=headers)
    print(response.status_code)


for i in range(1, 10):
    try:
        accept_invite("test" + str(i), "3013146F-BC79-4D53-9228-ECED311932ED")
    except Exception as e:
        print(f"failed at {i}, because {e}")
