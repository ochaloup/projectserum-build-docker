FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y curl cargo pkg-config build-essential libudev-dev libssl-dev wget openssl && \
    wget http://nz2.archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.19_amd64.deb && \
    dpkg -i libssl1.1_1.1.1f-1ubuntu2.19_amd64.deb

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain none -y

ENV PATH="${PATH}:/root/.cargo/bin"
RUN echo 'source $HOME/.cargo/env' >> $HOME/.bashrc

RUN rustup toolchain install nightly --allow-downgrade --profile minimal --component clippy && \
    rustup install nightly && \
    rustup default nightly && \
    rustup toolchain list

RUN sh -c "$(curl -sSfL https://release.solana.com/v1.16.4/install)"

RUN cargo install --git https://github.com/project-serum/anchor avm --locked --force && \
    avm install 0.28.0 && \
    avm use 0.28.0

RUN  /root/.local/share/solana/install/active_release/bin/solana-keygen new --no-bip39-passphrase && \
     /root/.local/share/solana/install/active_release/bin/solana config set --url http:localhost:8899

RUN chmod uog+rwx -R /root/.avm
RUN chmod uog+rwx -R /root/.config/solana

ENV PATH="${PATH}:/root/.cargo/bin:/root/.avm/bin:/root/.local/share/solana/install/active_release/bin"

ENV HOME=/root
USER root
