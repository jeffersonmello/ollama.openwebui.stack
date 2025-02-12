# ollama.openwebui.stack
Ollama &amp; OpenWebUI - Docker Stack

## Description
This is a docker stack for Ollama and OpenWebUI.

## Usage
1. Clone this repository
2. Run `docker compose up -d` (the process can take a while)
3. Access Ollama at `http://localhost:8080`

## Configuration
* The stack is configured to use the default ports for Ollama and OpenWebUI. If you want to change the ports, you can do so by editing the `docker-compose.yml` file.
* If you need add models to Ollama, you can do so by adding the model files to the `models` directory, or add add name of models in environment variable `MODEL_LIST` in `docker-compose.yml` file, separated by comma.

## License
MIT
```
