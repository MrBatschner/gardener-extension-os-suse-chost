############# builder
FROM golang:1.17.13 AS builder

WORKDIR /go/src/github.com/gardener/gardener-extension-os-suse-chost
COPY . .
RUN make install-requirements && make generate && make install

############# gardener-extension-os-suse-chost
FROM gcr.io/distroless/static-debian11:nonroot AS gardener-extension-os-suse-chost
WORKDIR /

COPY --from=builder /go/bin/gardener-extension-os-suse-chost /gardener-extension-os-suse-chost
ENTRYPOINT ["/gardener-extension-os-suse-chost"]
