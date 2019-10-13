# Clean up before starting
rm -rf env/
rm -rf package/
rm function.zip
rm output.json

# Build poppler
rm -rf poppler_binaries/
./build_poppler.sh

# Make a virtualenv
virtualenv --python python3 env/
source env/bin/activate

# Creating the package and getting past TLS 1.0 issues
mkdir -p package

yum install gcc python python-devel libffi-devel openssl-devel
curl https://bootstrap.pypa.io/get-pip.py | python
pip3 install pyOpenSSL backports.ssl requests
pip3 install pdf2image --target package/
pip3 install boto3 --target package/

# Moving the poppler libraries in the package
cp -r poppler_binaries/ package/

# Moving the function in the package
cp amazon/lambda_function.py package/

# Zipping the package
cd package
zip -r9 ../function.zip *
cd ..

# Add the lambda function
zip -g function.zip lambda_function.py

# Deleting package artifacts
rm -rf package/

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
                           --zip-file fileb://function.zip

# Test it
aws lambda invoke --function-name createImagesFromPdf \
                  --region eu-west-2 \
                  --log-type Tail \
                  --payload '{"Records": [{"s3": {"object": {"key": "138322-007-001.png"}, "bucket": {"name": "test-create-images-bucket"}}}]}' \
                  output.json
