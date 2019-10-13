# Machine Learning AWS

At present, only contains a method of uploading lambda functions to AWS using
CLI commands, which is combined with juniper to make it fairly easy to do...once you
get your head around how it works.

## Quick Start

1) Go to directory where `deploy_lambda_with_juniper.sh` is located.
2) Make sure that `aws configure` is...configured.
3) Run the shell file: `./deploy_lambda_with_juniper.sh`.

You may need to replace the names of the functions if they are different,
or if they need to change, as well as the ARN for the role policy.

## Lambda Functions Info

Lambda functions are built using the [juniper](https://github.com/eabglobal/juniper) library.

To build a zip file for a lambda function, it's as simple as going into the
`lambda_function/<function>` directory and running the `juni build` command.

Afterwards, a zip file will be created in the `dist` folder for that lambda function
which can uploaded on AWS either manually via the console, or using the CLI tools.

### When to choose to use a custom Dockerfile

The default one that is used for a `manifest.yml` file is `lambci/lambda:build-python3.7`. Which
seems to work in most cases. However, if binaries are needed, then another Dockerfile will need
to be used.

A complete list can be found [here](https://github.com/lambci/docker-lambda)

## More info on the shell script

Run `./deploy_lambda_with_juniper.sh` to create and upload the zip file to AWS, then test.
The output will be saved to `output.json`.

