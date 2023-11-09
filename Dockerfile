# First stage: build the application with a standard Go image
FROM golang:1.21 AS builder
WORKDIR /app
COPY . .
WORKDIR /app/catgpt
RUN go mod download
RUN CGO_ENABLED=0 go build -o /myapp

# Second stage: create the final image using a distroless base image
FROM gcr.io/distroless/static-debian12:latest-amd64
COPY --from=builder /myapp /myapp
EXPOSE 80
CMD ["/myapp"]
