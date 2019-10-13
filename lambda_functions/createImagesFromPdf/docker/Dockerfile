FROM lambci/lambda:build-python3.7

# Upgrade packages & repo
RUN yum -y update
RUN yum -y install poppler-utils

RUN mkdir -p /var/task/lambda_lib/
RUN cp /usr/lib64/libpoppler.so.46 /var/task/lambda_lib/
RUN cp /usr/lib64/libpoppler.so.46.0.0 /var/task/lambda_lib/