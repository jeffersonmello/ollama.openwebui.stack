# ollama/Dockerfile
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Instala dependências necessárias
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Cria o diretório para os dados do Ollama
RUN mkdir -p /data/ollama

# Executa o script de instalação oficial do Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

# Copia o entrypoint script para o container
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Exponha a porta utilizada pelo Ollama (confirme a porta na documentação oficial)
EXPOSE 8000

# Define o entrypoint do container
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]