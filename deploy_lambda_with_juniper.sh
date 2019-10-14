#
# Creating zip files and deploying lambda functions
#
cd lambda_functions/createImagesFromPdf
make build
make deploy
cd ../../
