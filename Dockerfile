FROM golang:1.21.3 as builder

ARG TARGETOS
ARG TARGETARCH

ENV GOOS=$TARGETOS
ENV GOARCH=$TARGETARCH

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 go build -o go-bot ./src

# ----------------

FROM alpine:latest

COPY --from=builder /app/go-bot /go-bot

ENTRYPOINT ["/go-bot"]
