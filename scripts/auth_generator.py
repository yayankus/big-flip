import  base64

def generate_basic_auth(apiKey):
    data_string = apiKey + ":"
    data_bytes = data_string.encode("utf-8")
    encoded_bytes = base64.b64encode(data_bytes)
    encoded_string = encoded_bytes.decode("utf-8")
    auth = "Basic " + encoded_string

    return  auth
