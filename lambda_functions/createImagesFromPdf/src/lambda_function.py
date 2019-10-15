import boto3
import json
import pdf2image


def lambda_handler(event, context):

    # Process upload event
    bucket = event['Records'][0]["s3"]["bucket"]["name"]
    key = event['Records'][0]["s3"]["object"]["key"]
    print("Received event. Bucket: [%s], Key: [%s]" % (bucket, key))

    # Construct s3 client
    s3 = boto3.client('s3')

    response = s3.get_object(
        Bucket=bucket,
        Key=key
    )

    # Get the object contents
    images = pdf2image.convert_from_bytes(response['Body'].read())
    print(images)

    # Apply transformations
    
    # TODO implement
    return {
        'statusCode': 200,
        'body': json.dumps('Passes for now!')
    }


# This is used for debugging, it will only execute when run locally
if __name__ == "__main__":

    # Local debugging, send a simulated event
    lambda_handler({
        "Records": [
            {
                "s3": {
                    "bucket": {
                        "name": "test-create-images-input-bucket"
                    },
                    "object": {
                        "key": "138322-007-001.pdf"
                    }
                }
            }
        ]
    }, [])
