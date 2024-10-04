# Usando uma imagem mínima do Ubuntu
FROM ubuntu:latest

# Atualiza o sistema e instala Python3, pip e suas dependências
RUN apt-get update && apt-get install -y python3 python3-pip

# Define o diretório de trabalho
WORKDIR /app

# Copia o arquivo requirements.txt para instalar as dependências
COPY requirements.txt requirements.txt

# Instala as dependências do Flask, adicionando a flag --no-cache-dir e evitando problemas de permissões
RUN pip3 install --no-cache-dir --break-system-packages -r requirements.txt

# Copia todo o código da aplicação Flask para o diretório /app
COPY . .

# Expõe a porta 5005
EXPOSE 5005

# Comando para iniciar a aplicação Flask na porta 5005
CMD ["python3", "app.py"]