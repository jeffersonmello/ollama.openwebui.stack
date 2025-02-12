#!/bin/bash
set -e

# Função para aguardar o servidor ficar disponível
wait_for_ollama() {
  echo "Aguardando o servidor Ollama ficar disponível..."
  # Tenta verificar o status do Ollama (ajuste o comando se houver outro método para checar)
  for i in {1..100}; do
    if ollama -v > /dev/null 2>&1; then
      echo "Servidor Ollama está disponível."
      return 0
    fi
    sleep 1
  done
  echo "Timeout: o servidor Ollama não ficou disponível."
  return 1
}

echo "Iniciando o Ollama em background..."
# Inicia o Ollama em background
ollama start &
OLLAMA_PID=$!

# Aguarda o Ollama ficar disponível (o comando 'ollama status' pode variar; veja a documentação)
if ! wait_for_ollama; then
  echo "Erro: Não foi possível conectar ao Ollama."
  exit 1
fi

echo "Verificando se a pasta de modelos está vazia..."
if [ ! -d "/data/ollama/models" ] || [ -z "$(ls -A /data/ollama/models 2>/dev/null)" ]; then
  echo "Pasta de modelos vazia."

  if [ -n "$MODEL_LIST" ]; then
    echo "Baixando modelos definidos em MODEL_LIST: $MODEL_LIST"
    IFS=',' read -ra MODELS <<< "$MODEL_LIST"
    for model in "${MODELS[@]}"; do
      echo "Baixando o modelo: $model"
      ollama pull "$model" || echo "Falha ao baixar o modelo: $model"
    done
  else
    echo "Nenhum modelo definido em MODEL_LIST. Usando modelos padrão..."

    sleep 5

    echo "Baixando o modelo padrão: llama3.1"

    ollama pull llama3.1 || echo "Falha ao baixar o modelo padrão: llama3.1"    
  fi
else
  echo "Modelos já presentes. Pulando o download."
fi

# Traz o processo do Ollama para o primeiro plano e repassa sinais para ele
echo "Mantendo o processo do Ollama ativo..."
wait $OLLAMA_PID