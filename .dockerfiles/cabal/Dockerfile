FROM haskell:9.8.2-buster

ENV CABAL_CONFIG=/cabal/.cabal/config
RUN cabal user-config init && \
    cabal user-config update \
    --augment="remote-repo-cache: /cabal/.cache/cabal/packages" \
    --augment="build-summary: /cabal/.cache/cabal/logs/build.log" \
    --augment="installdir: /cabal/.local/bin"
RUN cabal update
RUN chmod -R 777 /cabal
