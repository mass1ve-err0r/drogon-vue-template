# Stage 1: Build
FROM ubuntu:24.04 AS builder

# Install GCC 13 (with full C++20 support)
RUN apt-get update && apt-get install -y software-properties-common && \
    add-apt-repository ppa:ubuntu-toolchain-r/test -y && \
    apt-get update && apt-get install -y g++-13 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-13 100

# Install build tools and deps
RUN apt-get update && apt-get install -y \
    git \
    cmake \
    libjsoncpp-dev \
    uuid-dev \
    zlib1g-dev \
    openssl \
    libssl-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install NVM, Node.js 22, and npm
ENV NVM_DIR=/root/.nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash && \
    . $NVM_DIR/nvm.sh && \
    nvm install 22 && \
    nvm use 22 && \
    echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc && \
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc && \
    echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> ~/.bashrc && \
    echo 'export PATH="$NVM_DIR/versions/node/$(nvm version)/bin:$PATH"' >> /root/.bashrc && \
    npm install -g npm@latest

# Set working directory
WORKDIR /app

# Clone and install Drogon, copied from the wiki
RUN git clone https://github.com/drogonframework/drogon.git && \
    cd drogon && \
    git submodule update --init && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j$(nproc) && \
    make install

# Copy project source code
COPY . .

# Ensure npm is available in the build process
ENV PATH="/root/.nvm/versions/node/v22.13.1/bin:$PATH"

# Build frontend
WORKDIR /app/frontend
RUN . $NVM_DIR/nvm.sh && nvm use 22 && npm install && npm run build

# Build backend
WORKDIR /app/build
RUN cmake .. && make -j$(nproc)

# Stage 2: Runtime
FROM ubuntu:24.04

# Install runtime dependencies
RUN apt-get update && apt-get install -y \
    curl \
    libjsoncpp-dev \
    openssl \
    libssl-dev \
    uuid-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy built application and assets from builder
COPY --from=builder /app/build/dv3 /app/dv3
COPY --from=builder /app/build/public /app/public

# Expose the application's port
EXPOSE 10420

# Set the entry point
CMD ["./dv3"]
