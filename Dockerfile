FROM projectserum/build:v0.26.0

RUN curl https://sh.rustup.rs -y -sSf | sh
RUN echo 'source $HOME/.cargo/env' >> $HOME/.bashrc
RUN rustup install nightly
RUN rustup default nightly 

RUN sh -c "$(curl -sSfL https://release.solana.com/v1.14.12/install)"

RUN rustup toolchain list
