  
FROM golang:1.15

RUN apt-get update
RUN apt-get install -y libdevmapper-dev libgpgme-dev libbtrfs-dev

# Set the Current Working Directory inside the container
WORKDIR /app/podman_prometheus_exporter

# Copy everything from the current directory to the PWD(Present Working Directory) inside the container
COPY . .

# Download all the dependencies
RUN go get -u golang.org/x/lint/golint

# Build the package
RUN GOOS=linux GOARCH=amd64 go build -o podman_prometheus_exporter ./main.go

# This container exposes port 8080 to the outside world
EXPOSE 9901

# Run the executable
CMD ["./podman_prometheus_exporter"]