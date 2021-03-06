FROM golang:1.14

# Install beego bee tool
RUN go get -u github.com/beego/bee

# Enable module management
ENV GO111MODULE=on
ENV GOFLAGS=-mod=vendor

# IDs should match the user's
ARG GROUP_ID
ARG USER_ID

# Create matching user in container
RUN groupadd --gid $GROUP_ID app \
    && useradd --uid $USER_ID --gid $GROUP_ID app \
    && mkdir -p /home/app \
    && mkdir -p /go/src/mathapp \
    && chown -R app:app /home/app \
    && chown -R app:app /go

USER app
WORKDIR /go/src/mathapp

EXPOSE 8080

CMD ["bee", "run"]
