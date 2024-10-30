# Use the NVIDIA PyTorch base image
FROM nvcr.io/nvidia/pytorch:24.07-py3

# Install git
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Update pip to the latest version
RUN pip install --no-cache-dir --upgrade pip

# Uninstall apex first
RUN pip uninstall -y apex

# # Install flash_attn separately with --use-pep517 flag
RUN pip install --no-cache-dir --use-pep517 flash-attn==2.6.3 --no-build-isolation

# RUN pip install packaging wheel
RUN pip install xfuser==0.3.2
RUN pip install imageio imageio-ffmpeg
RUN pip install fastapi["standard"]

# ENV PYTHONUNBUFFERED 1

# COPY poetry.lock pyproject.toml ./
# RUN pip install --upgrade pip && \
#     pip install poetry && \
#     poetry config virtualenvs.create false    

# ARG DEV=false
# RUN if [ "$DEV" = "true" ] ; then poetry install --with dev --no-root ; else poetry install --only main --no-root ; fi

# ENV PYTHONPATH "${PYTHONPATH}:/app" 

COPY ./app /app
COPY ./config /config
RUN mkdir /results

WORKDIR /app

ENTRYPOINT ["python", "launch_app.py"]
CMD ["--config", "/config/config.json"]