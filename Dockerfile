FROM projectserum/build:v0.27.0

RUN curl https://sh.rustup.rs -y -sSf | sh
RUN echo 'source $HOME/.cargo/env' >> $HOME/.bashrc
RUN rustup install nightly
RUN rustup default nightly 
RUN rustup toolchain list

RUN sh -c "$(curl -sSfL https://release.solana.com/v1.14.16/install)"

RUN apt-get install -y pkg-config build-essential libudev-dev
RUN cargo install --git https://github.com/project-serum/anchor avm --locked --force
RUN avm install 0.27.0

RUN chmod uog+rwx -R /root/.avm

