import json
import requests
from module import random_generator
def handler(event, context):

    # TODO implementation
    random_number = random_generator()
    return {
        'headers': {'Content-Type' : 'application/json'},
        'statusCode': 200,
        'body': json.dumps({"message": "Lambda Container image invoked!",
                            "random_number":random_number,
                            "event": event})
    }
