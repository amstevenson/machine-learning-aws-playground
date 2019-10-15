import boto3
import json
import pdf2image
import cv2
import os
import numpy as np
import io
from PIL import Image


def upload_image_to_s3(image, image_location, s3_object):

    # Turn into grayscale
    img = np.array(image)
    img = cv2.cvtColor(img, cv2.COLOR_RGB2GRAY)

    # Recreate the PpmImage
    img = Image.fromarray(img)

    in_mem_file = io.BytesIO()
    img.save(in_mem_file, 'PNG')
    in_mem_file.seek(0)

    s3_object.upload_fileobj(
        Fileobj=in_mem_file,
        Bucket='test-output-bucket',
        Key=image_location
    )


def get_pdf_images(bucket_name, key, s3_object):
    response = s3_object.get_object(
        Bucket=bucket_name,
        Key=key
    )

    # Get the object contents, and use pdf2image to get the images back
    return pdf2image.convert_from_bytes(response['Body'].read())


def lambda_handler(event, context):

    # Process upload event
    bucket = event['Records'][0]["s3"]["bucket"]["name"]
    key = event['Records'][0]["s3"]["object"]["key"]
    print("Received event. Bucket: [%s], Key: [%s]" % (bucket, key))

    # Construct s3 client
    s3 = boto3.client('s3')

    # Get images from pdf and determine filename
    images = get_pdf_images(bucket, key, s3)
    filename_without_ext = os.path.splitext(key)[0]

    for i in range(0, len(images)):
        page = 'page_{}.png'.format(i + 1)
        image_location = "{}/{}".format(filename_without_ext, page)

        # Apply transformation to image to make it grayscale, then upload to S3
        upload_image_to_s3(images[i], image_location, s3)

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
                        "name": "test-input-bucket"
                    },
                    "object": {
                        "key": "138322-007-001.pdf"
                    }
                }
            }
        ]
    }, [])
