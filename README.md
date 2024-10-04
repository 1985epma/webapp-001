Flask Application Deployment with Docker and CI/CD
Este repositório contém uma aplicação Flask simples, conteinerizada usando Docker e integrada com um pipeline CI/CD usando GitHub Actions. O pipeline inclui a construção da imagem Docker, execução de testes de segurança estática (SAST) com o Bandit, e envio da imagem Docker para o Docker Hub.

Sumário
Requisitos
Estrutura de Pastas
Instruções de Configuração
Pipeline de CI/CD no GitHub Actions
Etapas no Workflow
Dockerfile Explicado
Segurança com Bandit
Executando Localmente
Requisitos
Antes de configurar e implantar a aplicação, certifique-se de que você tem os seguintes requisitos:

Docker instalado na sua máquina local
Repositório GitHub com permissões para criar pipelines CI/CD
Conta no Docker Hub para armazenar as imagens Docker
Acesso ao GitHub Secrets para armazenar as credenciais do Docker Hub
Estrutura de Pastas
Aqui está a estrutura básica de pastas deste projeto:

graphql
Copy code
.
├── app.py                # A aplicação Flask principal
├── requirements.txt      # Dependências Python para o app
├── Dockerfile            # Dockerfile para construir o container
├── .github
│   └── workflows
│       └── docker-publish.yml  # Workflow do GitHub Actions para CI/CD
├── README.md             # Este arquivo README
└── templates
    └── home.html         # Exemplo de HTML para a aplicação Flask
Instruções de Configuração
Clone o Repositório: No VS Code, abra um terminal integrado e clone o repositório com o comando:

bash
Copy code
git clone https://github.com/SEU_GITHUB_USERNAME/SEU_REPOSITORIO.git
cd SEU_REPOSITORIO
Configurar Segredos no GitHub:

No GitHub, vá para o seu repositório.
Navegue até Settings > Secrets and Variables > Actions.
Adicione os seguintes segredos:
DOCKER_USERNAME: Seu nome de usuário do Docker Hub.
DOCKER_PASSWORD: Sua senha do Docker Hub (ou um Access Token se estiver usando autenticação de dois fatores).
Configurar o Dockerfile: Certifique-se de que o Dockerfile está corretamente configurado para construir a aplicação Flask e executar a análise de segurança.

Pipeline de CI/CD no GitHub Actions
O pipeline de CI/CD está definido no arquivo docker-publish.yml dentro do diretório .github/workflows/. Este pipeline é acionado sempre que há mudanças na branch main ou quando um pull request é aberto.

Etapas no Workflow
Checkout do Código: O repositório é clonado no ambiente do GitHub Actions para que o código seja acessado:

yaml
Copy code
- name: Checkout repository
  uses: actions/checkout@v3
Configuração do Ambiente Python: Instalamos python3-venv e criamos um ambiente virtual para executar os testes de segurança com Bandit:

yaml
Copy code
- name: Set up Python environment
  run: |
    sudo apt-get install python3-venv
    python3 -m venv venv
    source venv/bin/activate
Executar Teste de Segurança (Bandit): Instalamos e executamos o Bandit para verificar vulnerabilidades no código Python:

yaml
Copy code
- name: Run SAST with Bandit
  run: |
    venv/bin/pip install bandit
    venv/bin/bandit -r . --exit-zero
Construção e Envio da Imagem Docker: A imagem Docker é construída usando docker/build-push-action e enviada para o Docker Hub:

yaml
Copy code
- name: Build and push Docker image
  uses: docker/build-push-action@v3
  with:
    context: .
    file: ./Dockerfile
    push: true
    tags: SEU_DOCKER_USERNAME/seu-nome-da-imagem:latest
Dockerfile Explicado
O Dockerfile define como construir o container para a aplicação Flask e executar a verificação de segurança com Bandit.

Principais etapas incluem:

Criação de um ambiente virtual para as dependências do Python:

dockerfile
Copy code
RUN python3 -m venv /opt/venv
Instalação das dependências dentro do ambiente virtual:

dockerfile
Copy code
RUN /opt/venv/bin/pip install bandit
Execução do Bandit para análise de segurança:

dockerfile
Copy code
RUN /opt/venv/bin/bandit -r . --exit-zero
Início da aplicação Flask após a construção:

dockerfile
Copy code
CMD ["/opt/venv/bin/python", "app.py"]
Segurança com Bandit
O Bandit é usado para realizar análise estática no código Python e verificar problemas de segurança comuns, como:

Uso de funções inseguras (e.g., eval())
Credenciais hardcoded
Vulnerabilidades potenciais na lógica do código
O Bandit é executado automaticamente como parte do processo de build do Docker e também no pipeline do GitHub Actions.

Executando Localmente
Para executar a aplicação Flask localmente usando Docker:

Construa a imagem Docker: No terminal do VS Code, execute:

bash
Copy code
docker build -t nome-da-imagem .
Execute o container Docker: Rode o container com o comando:

bash
Copy code
docker run -p 5005:5005 nome-da-imagem
Acesse a aplicação Flask: Abra o navegador e vá para http://localhost:5005.

Agora, basta adicionar esse README.md ao repositório, e ele estará pronto para ser visualizado no GitHub.

Subindo o arquivo README.md para o GitHub
Adicione o README ao controle de versão: No terminal do VS Code, use os comandos:

bash
Copy code
git add README.md
git commit -m "Adicionando README de Deploy"
git push origin main
Verifique no GitHub: Vá ao seu repositório no GitHub e verifique se o arquivo README.md foi carregado corretamente.