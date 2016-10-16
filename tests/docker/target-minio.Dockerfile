FROM minio/minio:latest

CMD [ "server", "/export" ]