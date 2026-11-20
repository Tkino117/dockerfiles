FROM nvidia/cuda:12.8.1-cudnn-devel-ubuntu24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo

RUN apt-get update && apt-get install -y --no-install-recommends \
    # 基本
    sudo ca-certificates curl wget git unzip zip xz-utils 7zip \
    rsync tree less file \
    # シェル・端末
    zsh tmux vim locales tzdata ncurses-term \
    # ビルド
    build-essential pkg-config cmake ninja-build ccache python3-dev \
    # Python ビルド用 (uv / pyenv)
    libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
    libncurses-dev tk-dev libffi-dev liblzma-dev \
    # CLI ツール
    jq ripgrep fd-find stow htop btop nvtop ffmpeg imagemagick poppler-utils \
    # ネットワーク・デバッグ
    iputils-ping dnsutils net-tools iproute2 pciutils procps lsof strace \
    && rm -rf /var/lib/apt/lists/*

# fd-find を fd で起動
RUN ln -s /usr/bin/fdfind /usr/local/bin/fd

# ロケールとタイムゾーン
RUN locale-gen en_US.UTF-8 ja_JP.UTF-8 \
    && ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone
ENV LANG=en_US.UTF-8

# rootless docker ではコンテナ内 root = ホストの自分なので，root のまま使用する
RUN chsh -s /bin/zsh root

WORKDIR /root

# mise
ENV PATH=/root/.local/bin:/root/.local/share/mise/shims:${PATH}
RUN curl -fsSL https://mise.run | sh \
    && mise use -g node@lts uv starship sheldon lazygit yazi fzf zoxide github-cli \
    && mise use -g npm:@openai/codex

# dotfiles
RUN git clone --depth 1 https://github.com/tkino117/.dotfiles.git \
    && .dotfiles/sync.sh \
    && sheldon lock

# Claude Code
RUN curl -fsSL https://claude.ai/install.sh | bash
