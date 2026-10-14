# CPU-first development image for the project; see phases/00-setup-and-tooling/07-docker-for-ai/docs/en.md.
FROM python:3.12-slim

COPY --from=ghcr.io/astral-sh/uv:0.12.22 /uv /uvx /bin/

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    UV_COMPILE_BYTECODE=1 \
    UV_LINK_MODE=copy \
    UV_PROJECT_ENVIRONMENT=/opt/venv

WORKDIR /workspace

# Install locked dependencies first so Docker can reuse this layer when only code changes.
COPY pyproject.toml uv.lock README.md ./
COPY src ./src
RUN uv sync --frozen --no-dev \
    --no-install-package torch \
    --no-install-package cuda-bindings \
    --no-install-package cuda-pathfinder \
    --no-install-package cuda-toolkit \
    --no-install-package nvidia-cublas \
    --no-install-package nvidia-cuda-cupti \
    --no-install-package nvidia-cuda-nvrtc \
    --no-install-package nvidia-cuda-runtime \
    --no-install-package nvidia-cudnn-cu13 \
    --no-install-package nvidia-cufft \
    --no-install-package nvidia-cufile \
    --no-install-package nvidia-curand \
    --no-install-package nvidia-cusolver \
    --no-install-package nvidia-cusparse \
    --no-install-package nvidia-cusparselt-cu13 \
    --no-install-package nvidia-nccl-cu13 \
    --no-install-package nvidia-nvjitlink \
    --no-install-package nvidia-nvshmem-cu13 \
    --no-install-package nvidia-nvtx \
    --no-install-package triton

# The lock resolves PyPI's CUDA build on Linux; use the official CPU wheel index here.
RUN uv pip install --python /opt/venv/bin/python \
    --index-url https://download.pytorch.org/whl/cpu \
    --no-deps \
    "torch==2.14.1+cpu"

ENV PATH="/opt/venv/bin:${PATH}"

COPY . .

VOLUME ["/models"]

CMD ["ai-engineering-from-scratch"]
