FROM gcc:11.2-bullseye as builder

RUN apt-get update \
    && apt-get install -y --no-install-recommends cmake
WORKDIR /open62541
COPY open62541 ./
WORKDIR /open62541/build
RUN cmake -DUA_BUILD_EXAMPLES=ON .. \
    && make

FROM debian:bullseye-slim

COPY --from=builder /open62541/build/bin/examples/tutorial_server_firststeps /
EXPOSE 4840/tcp
CMD [ "/tutorial_server_firststeps" ]
