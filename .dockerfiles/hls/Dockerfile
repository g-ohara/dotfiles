FROM genjiohara/cabal:9.8.2-buster

RUN apt update && apt install -y libicu-dev libncurses-dev libgmp-dev zlib1g-dev
RUN cabal install haskell-language-server
