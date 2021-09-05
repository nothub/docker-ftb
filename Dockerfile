FROM openjdk:8-jre-slim-bullseye

ENV FTB_PACK=""
ENV FTB_PACK_VER=""
ENV MC_EULA="false"

# dependencies
RUN apt-get update                                                   \
 && apt-get install    --quiet --yes --no-install-recommends curl jq \
 && apt-get clean      --quiet --yes                                 \
 && apt-get autoremove --quiet --yes                                 \
 && rm -rf /var/lib/apt/lists/*

# tini
ARG TINI_VER="v0.19.0"
ADD https://github.com/krallin/tini/releases/download/$TINI_VER/tini /sbin/tini
RUN chmod +x /sbin/tini

# runtime entrypoint
COPY entrypoint.sh /opt/setup/entrypoint.sh
RUN chmod +x /opt/setup/entrypoint.sh

EXPOSE 25565
VOLUME /opt/server

ENTRYPOINT ["/sbin/tini", "--", "/opt/setup/entrypoint.sh"]
