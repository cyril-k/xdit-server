# xdit-server

- to build: 
    ```bash
    docker build -t xdit-server:latest .
    ```
- to run locally: 
    ```bash
    export HF_TOKEN=<hf_token>
    docker run --gpus all --ipc=host --ulimit memlock=-1 --ulimit stack=67108864 -p 6000:6000 -e HF_TOKEN=$HF_TOKEN xdit-server:latest
    ```