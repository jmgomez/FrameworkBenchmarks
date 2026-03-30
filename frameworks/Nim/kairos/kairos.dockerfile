FROM ubuntu:22.04

RUN apt-get update && apt-get install -y gcc build-essential curl git

ENV CHOOSENIM_NO_ANALYTICS 1
ENV CHOOSENIM_CHOOSE_VERSION 2.2.8
RUN curl https://nim-lang.org/choosenim/init.sh -sSf | sh -s -- -y
ENV PATH $PATH:/root/.nimble/bin

ADD ./ /kairos
WORKDIR /kairos
RUN nimble install -y --depsOnly
RUN nimble c -d:danger --threads:on -y techempower.nim

EXPOSE 8080

CMD ./techempower
