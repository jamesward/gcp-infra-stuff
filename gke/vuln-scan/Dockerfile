FROM golang:1.8 asbuild

WORKDIR go/src/app
COPY . .
RUN get -d -v ./...
RUN CGO_ENABLED=0 GOOS=linux go install -v ./...

#FROM apline
FROM debian
COPY --from=build /go/bin/app /app

CMD ["/app"]