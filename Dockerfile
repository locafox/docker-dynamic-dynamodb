FROM alpine

MAINTAINER "Xavier Bruguera <xavier.bruguera@locafox.de>"

# Install packages
RUN apk update && \
    apk add \
         ca-certificates \
         python \
         py-pip && \
    mkdir -p /etc/dynamic-dynamodb && \
    echo "dynamic-dynamodb>=2.0.0,<3.0.0">/etc/dynamic-dynamodb/requirements.txt && \
    pip install --upgrade pip && \
    pip install -U -r /etc/dynamic-dynamodb/requirements.txt && \
    apk del \
         py-pip

# Copy scripts to init the container
ADD scripts /tmp/
ADD etc/dynamic-dynamodb/dynamic-dynamodb.conf /etc/dynamic-dynamodb/dynamic-dynamodb.conf

# Start dynamic-dynamodb daemon
ENTRYPOINT ["sh","/tmp/init.sh"]
CMD ["dryrun"]

