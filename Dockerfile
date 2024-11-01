# First stage: setup conda environment
FROM condaforge/miniforge3:24.9.0-0 AS base

WORKDIR /app

COPY environment.yml .

RUN /opt/conda/bin/conda init bash && \
    conda env create --file environment.yml && \
    conda clean -afy && \
    rm -rf /opt/conda/pkgs/* /tmp/* /var/tmp/*

# Second stage: copy conda
FROM base AS conda
COPY --from=base /opt/conda /opt/conda

# Third stage: final runtime image
FROM conda AS host

# Create a non-root user and set ownership of the working directory
RUN useradd -m appuser && chown -R appuser /app

# Switch to the non-root user
USER appuser

ENV PORT=8080
EXPOSE $PORT

# Use health check to verify service availability
HEALTHCHECK CMD curl --fail http://localhost:$PORT || exit 1

ENTRYPOINT ["python", "-m", "panel", "serve", "--port=$PORT", "--address=0.0.0.0", "--allow-websocket-origin=*"]

CMD ["--num-procs=1", \
     "--num-threads=10", \
     "--websocket-max-message-size=100000000" \
    ]