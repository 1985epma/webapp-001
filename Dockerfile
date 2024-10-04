# Usando uma imagem mínima do Ubuntu
FROM ubuntu:latest

# Atualiza o sistema e instala Python3, pip e dependências de segurança
RUN apt-get update && apt-get install -y python3 python3-pip

# Instala o Bandit para análise de segurança
RUN pip3 install bandit

# Define o diretório de trabalho
WORKDIR /app

# Copia o arquivo requirements.txt para instalar as dependências da aplicação
COPY requirements.txt requirements.txt

# Instala as dependências do Flask
RUN pip3 install --no-cache-dir -r requirements.txt

# Copia todo o código da aplicação Flask para o diretório /app
COPY . .

# Realiza a análise estática de segurança com Bandit
RUN bandit -r . --exit-zero

# Expõe a porta 5005
EXPOSE 5005

# Comando para iniciar a aplicação Flask na porta 5005
CMD ["python3", "app.py"]