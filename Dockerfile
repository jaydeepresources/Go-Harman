# Build stage
FROM golang:1.21-alpine AS builder
WORKDIR /app

COPY go.mod ./
RUN go mod download 

COPY . .
RUN go build -o hello_app 2_user_form_main.go

# Runtime stage
FROM alpine:latest
WORKDIR /root/

COPY --from=builder /app/hello_app .
COPY --from=builder /app/templates ./templates

EXPOSE 8081
CMD ["./hello_app"]
