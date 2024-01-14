# 使用 Ubuntu 20.04 基础镜像
FROM ubuntu:20.04

# 避免在安装过程中出现任何交互提示
ARG DEBIAN_FRONTEND=noninteractive

# 更新软件包列表并安装依赖项
RUN apt-get update && apt-get install -y \
    software-properties-common \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3-dev \
    python3-pip \
    curl \
    lsb-release \
    git
    

# 添加 Deadsnakes PPA，这个 PPA 提供了多个 Python 版本
RUN add-apt-repository ppa:deadsnakes/ppa

# 安装 Python 3.9 和 pip
RUN apt-get update && apt-get install -y python3.9 python3.9-venv python3.9-dev
RUN python3.9 -m pip install --upgrade pip

# 安装 Rust 编译器
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# 将 Cargo 的 bin 目录添加到 PATH
ENV PATH="/root/.cargo/bin:${PATH}"

# 安装 Mythril
RUN python3.9 -m pip install mythril

# 清理缓存以减小镜像大小
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /workspace

