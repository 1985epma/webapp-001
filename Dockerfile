# Usando uma imagem mínima do Ubuntu
FROM ubuntu:latest

# Atualiza o sistema e instala Python3, pip e venv
RUN apt-get update && apt-get install -y python3 python3-pip python3-venv

# Cria um ambiente virtual
RUN python3 -m venv /opt/venv

# Ativa o ambiente virtual e instala o Bandit
RUN /opt/venv/bin/pip install bandit

# Define o diretório de trabalho
WORKDIR /app

# Copia o arquivo requirements.txt para instalar as dependências da aplicação
COPY requirements.txt requirements.txt

# Ativa o ambiente virtual e instala as dependências da aplicação
RUN /opt/venv/bin/pip install --no-cache-dir -r requirements.txt

# Copia todo o código da aplicação Flask para o diretório /app
COPY . .

# Realiza a análise estática de segurança com Bandit
RUN /opt/venv/bin/bandit -r . --exit-zero

# Expõe a porta 5005
EXPOSE 5005

# Ativa o ambiente virtual e inicia a aplicação Flask
CMD ["/opt/venv/bin/python", "app.py"]
