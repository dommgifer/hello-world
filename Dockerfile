FROM golang:1.11
EXPOSE 80
COPY ./main.go /go
RUN go build -o ./bin/hello-server && \
    mv ./bin/hello-server /usr/local/bin/
CMD ["hello-server"]
