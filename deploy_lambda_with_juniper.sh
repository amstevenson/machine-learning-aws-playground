#
# Creating zip files and deploying lambda functions
#
cd lambda_functions/createImagesFromPdf
make build
cd ../../

# Cleaning AWS function
aws lambda delete-function --function-name createImagesFromPdf --region eu-west-2

sleep 5

# Creating AWS function
# For reference, see: https://docs.aws.amazon.com/cli/latest/reference/lambda/create-function.html
aws lambda create-function --function-name createImagesFromPdf \
                           --runtime python3.7 \
                           --memory 128 \
                           --handler lambda_function.lambda_handler \
                           --description "Takes a PDF from an S3 bucket, extracts the pages, and saves to another S3 bucket" \
                           --timeout 30 \
                           --region eu-west-2 \
                           --role arn:aws:iam::035142533314:role/lambda_create_images_role \
                           --publish \
                           --zip-file fileb://lambda_functions/createImagesFromPdf/dist/router.zip

# Test it
aws lambda invoke --function-name createImagesFromPdf \
                  --region eu-west-2 \
                  --log-type Tail \
                  --payload '{"Records": [{"s3": {"object": {"key": "138322-007-001.pdf"}, "bucket": {"name": "test-create-images-bucket"}}}]}' \
                  output.json
