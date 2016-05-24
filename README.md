# docker-dynamic-dynamodb
Dynamic DynamoDB Docker container provides auto scaling for AWS DynamoDB.
Python sources come from https://github.com/sebdah/dynamic-dynamodb

# How to create the container

 ~~~bash
 $ docker build -t dynamic-dynamodb .
 ~~~
 NOTE: Change the etc/dynamic-dynamodb/dynamic-dynamodb.conf before to build in order to load your config file into the container.
       Also, you can mount as a volume (explained in the point 1 of How to run the container)

# How to run the container

1. Running:

 ~~~bash
 $ docker run -d --restart=on-failure:10 --name dynamic-dynamodb dynamic-dynamodb nodryrun
 ~~~
 >NOTE: If you want stop the container, you can execute the following command:
 ~~~bash
 $ docker stop dynamic-dynamodb
 $ docker rm dynamic-dynamodb
 ~~~

 If you want to execute in dry-run mode, just execute:

 ~~~bash
 $ docker run -d --restart=on-failure:10 --name dynamic-dynamodb dynamic-dynamodb
 ~~~
 >NOTE: In this mode it will check the tables and make scaling decisions based on the configuration information,
        but it will not actually make any changes to the provisioned throughput.

 To run your config file you can do:

  a. Download repository and modify etc/dynamic-dynamodb/dynamic-dynamodb.conf

  b. Mount your config file:
     ~~~bash
     $ docker run -d --restart=on-failure:10 -v "my-config-file.conf:/etc/dynamic-dynamodb/dynamic-dynamodb.conf" --name dynamic-dynamodb dynamic-dynamodb nodryrun
     ~~~

2. Check the logs

 ~~~bash
 $ docker logs dynamic-dynamodb
 ~~~


