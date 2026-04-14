FROM golang:1.21 AS builder
WORKDIR /build
COPY . .
RUN go build -o tgState .

FROM ubuntu:latest
WORKDIR /app
COPY --from=builder /build/tgState /app/tgState
RUN apt-get update && apt-get install -y ca-certificates
EXPOSE 8088
ENTRYPOINT ["/app/tgState"]
