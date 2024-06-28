FROM cgr.dev/chainguard/go:latest as builder

WORKDIR /work

ADD . .

RUN set -euxo pipefail \
 && go mod download \
 && CGO_ENABLED=0 go build -ldflags "-s -w" -o tsns .

FROM cgr.dev/chainguard/static:latest

COPY --from=builder /work/tsns /opt

RUN mkdir -p /usr/share/typesense

ENTRYPOINT ["/opt/tsns"]
