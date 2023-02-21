FROM ubuntu as sslCreation
RUN apt update -y
RUN apt install openssl -y
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh
WORKDIR /app
CMD ["/app/run.sh"]
