From golang:1.19.6-alpine3.17
RUN mkdir /app
COPY . /app
WORKDIR /app
## Add this go mod download command to pull in any dependencies
RUN go mod download
## Our project will now successfully build with the necessary go libraries included.
RUN go build -o main .
CMD ["/app/main"]
