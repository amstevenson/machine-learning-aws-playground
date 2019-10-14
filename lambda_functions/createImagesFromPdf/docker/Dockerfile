FROM lambci/lambda:build-python3.7

# Upgrade packages & repo
RUN yum -y update
RUN yum -y install poppler-utils libopenjp2-7

RUN mkdir -p /var/task/lambda_lib/
RUN mkdir -p /var/task/lambda_bin/

RUN cp /usr/lib64/libpoppler.so.46 /var/task/lambda_lib/
RUN cp /usr/lib64/libpoppler.so.46.0.0 /var/task/lambda_lib/

RUN cp /usr/lib64/libpng12.so /var/task/lambda_lib/
RUN cp /usr/lib64/libpng12.so.0 /var/task/lambda_lib/
RUN cp /usr/lib64/libpng12.so.0.49.0 /var/task/lambda_lib/
RUN cp /usr/lib64/libpng.so /var/task/lambda_lib/
RUN cp /usr/lib64/libpng.so.3 /var/task/lambda_lib/
RUN cp /usr/lib64/libpng.so.3.49.0 /var/task/lambda_lib/

RUN cp /usr/lib64/libOpenGL.so /var/task/lambda_lib/
RUN cp /usr/lib64/libOpenGL.so.0 /var/task/lambda_lib/
RUN cp /usr/lib64/libOpenGL.so.0.0.0 /var/task/lambda_lib/
RUN cp /usr/lib64/libopenjpeg.so.2 /var/task/lambda_lib/
RUN cp /usr/lib64/libopenjpeg.so.2.1.3.0 /var/task/lambda_lib/

RUN cp /usr/lib64/libz.so /var/task/lambda_lib/

RUN cp /usr/lib64/libopenjpeg.so.2.1.3.0 /var/task/lambda_lib/
RUN cp /usr/lib64/libopenjpeg.so.2.1.3.0 /var/task/lambda_lib/

RUN cp /usr/bin/pdftoppm /var/task/lambda_bin/
RUN cp /usr/bin/pdfinfo /var/task/lambda_bin/
RUN cp /usr/bin/pdftocairo /var/task/lambda_bin/
