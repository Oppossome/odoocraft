FROM nixos/nix:latest AS pack-builder
WORKDIR /src

COPY . .
RUN nix-shell --run "packwiz mr export -o /tmp/odoocraft.mrpack"

FROM itzg/minecraft-server:latest
COPY --from=pack-builder /tmp/odoocraft.mrpack /modpacks/odoocraft.mrpack

ENV MODPACK_PLATFORM=MODRINTH \
    MODRINTH_MODPACK=/modpacks/odoocraft.mrpack