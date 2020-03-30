#!/bin/bash
docker run --rm -d -v `pwd`/data:/data/ -p 8000:8000 --name ddb amazon/dynamodb-local -jar DynamoDBLocal.jar -sharedDb -dbPath /data
