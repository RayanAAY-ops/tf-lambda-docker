import json
import os
import requests
from module import random_generator
from sm_secrets import get_db_secret


SECRET_NAME = os.environ.get("SECRET_NAME")
REGION_NAME = os.environ.get("REGION_NAME")

def handler(event, context):
    random_number = random_generator()
    secrets = get_db_secret(secret_name=SECRET_NAME,
                            region_name=REGION_NAME)
    return {
        'headers': {'Content-Type' : 'application/json'},
        'statusCode': 200,
        'body': json.dumps({"message": "Lambda Container image invoked!",
                            "random_number":random_number,
                            "event": event,
                            "secrets": secrets,
                            "newMessage":"adding pytest test lambda update 2"})
    }
