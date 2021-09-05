FROM openjdk:8-jre-slim-buster

ENV FTB_PACK="8"
ENV FTB_PACK_VER="142"
ENV MC_EULA="false"
ENV JVM_MEMORY="4096M"

# tini
ARG TINI_VER="v0.19.0"
ADD https://github.com/krallin/tini/releases/download/$TINI_VER/tini /sbin/tini
RUN chmod +x /sbin/tini

# runtime entrypoint
COPY entrypoint.sh /opt/setup/entrypoint.sh
RUN chmod +x /opt/setup/entrypoint.sh

# ftb installer
ADD https://api.modpacks.ch/public/modpack/"$FTB_PACK"/"$FTB_PACK_VER"/server/linux /opt/setup/serverinstall_"$FTB_PACK"_"$FTB_PACK_VER"
RUN chmod +x /opt/setup/serverinstall_"$FTB_PACK"_"$FTB_PACK_VER"

EXPOSE 25565
VOLUME /opt/server

ENTRYPOINT ["/sbin/tini", "--", "/opt/setup/entrypoint.sh"]
