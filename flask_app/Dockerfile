# OBS: using latest for POC purposes since other Chainguard images are paid. Do not use latest in production.
FROM cgr.dev/chainguard/python:latest-dev AS builder 

WORKDIR /app

ARG BUSYBOX_VERSION=1.31.0-i686-uclibc
ADD https://busybox.net/downloads/binaries/$BUSYBOX_VERSION/busybox_WGET /wget

RUN pip install gunicorn --user

COPY shortly.py requirements.txt config.py boot.sh ./
COPY migrations ./migrations
COPY app ./app

RUN pip install -r requirements.txt --user

# ------------------------------------------------
FROM cgr.dev/chainguard/python:latest-dev AS final

WORKDIR /app

ENV PYTHONPATH=/home/nonroot/.local/lib/python3.12/site-packages

EXPOSE 5000

COPY --from=builder --chmod=555 /wget /usr/bin/wget
COPY --from=builder /home/nonroot/.local/bin /home/nonroot/.local/bin
COPY --from=builder /home/nonroot/.local/lib/python3.12/site-packages /home/nonroot/.local/lib/python3.12/site-packages

ENV PATH=/home/nonroot/.local/bin:$PATH

COPY --from=builder --chmod=555 /app/boot.sh ./
COPY --from=builder /app/shortly.py /app/config.py ./
COPY --from=builder /app/app /app/app
COPY --from=builder /app/migrations ./migrations

ENV FLASK_APP=/app/shortly.py

ENTRYPOINT ["./boot.sh"]

HEALTHCHECK --interval=30s --timeout=3s \
    CMD ["/usr/bin/wget", "--no-verbose", "--tries=1", "--spider", "http://localhost:5000/healthcheck"] || exit 1