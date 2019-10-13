s3_bucket=test-create-images-bucket
stack_name ?= create-images-from-pdf
sam_template_base=sam
sam_template=$(sam_template_base).yml
sam_output=$(sam_template_base)-new.yml


build:
	docker build -t ml/poppler-utils -f docker/Dockerfile .
	juni build

package:
	sam package \
	    --s3-bucket $(s3_bucket) \
	    --template-file $(sam_template) \
	    --output-template-file ./dist/$(sam_output)

deploy: package
	sam deploy \
	    --template-file ./dist/$(sam_output) \
	    --stack-name $(stack_name) \
	    --capabilities CAPABILITY_IAM \
	    --region eu-west-2
