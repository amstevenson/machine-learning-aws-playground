# Machine Learning AWS

At present, only contains a method of uploading lambda functions to AWS using
CLI commands, which is combined with juniper to make it fairly easy to do...once you
get your head around how it works.

## Quick Start

1) Go to directory where `deploy_lambda_with_juniper.sh` is located.
2) Make sure that `aws configure` is...configured.
3) Run the shell file: `./deploy_lambda_with_juniper.sh`.

This will build the zip files required for the lambda function and layer, and
upload them with a specific name based on the lambda_function folder that is being used.

For example `createImagesFromPdf` will create a lambda function called...`create-images-from-pdf`...and so on,
along with the layer that is associated to it.

## Lambda Functions/Layers Info

Lambda functions are built using the [juniper](https://github.com/eabglobal/juniper) library and
uses [SAM](https://github.com/awslabs/serverless-application-model/blob/master/versions/2016-10-31.md)
to define serverless application models on AWS.

To build a zip file for a lambda function, it's as simple as going into the
`lambda_function/<function>` directory and running the `juni build` command.

This however assumes that you have run a `make build` first using the Makefile.

Afterwards, zip files will be created in the `dist` folder for that lambda function
which can uploaded on AWS either manually via the console (function.zip being the lambda function,
and %-requirements.zip being for the function) or by running `make deploy`.

### When to choose to use a custom Dockerfile

The default image that is used for a `manifest.yml` file is `lambci/lambda:build-python3.7`.
This is usually enough to specify in the manifest file in order to create a zip file
that includes requirements.

A case where this does not seems to work however, is if binaries are needed.
In that case another Dockerfile will need to be used in order to save `.so` and `executables`
to the `/bin` and `/lib` locations that are required by juniper for the final file.

In this case, a list of [images](https://github.com/lambci/docker-lambda) can be used as a basis for the Dockerfile, and it can be
expanded upon to copy these files to the right locations.

## More info on the shell script

Run `./deploy_lambda_with_juniper.sh` to create and upload the zip file to AWS, then test.
The output will be saved to `output.json`.

## Docker Debugging

`docker build -t <image_name> .` to build the image.

`docker run -it --entrypoint bash <image_name>` to get a command line in the container.
