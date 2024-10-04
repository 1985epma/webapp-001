# Flask Application Deployment with Docker and CI/CD

Este repositório contém uma aplicação Flask simples, conteinerizada usando Docker e integrada com um pipeline CI/CD usando GitHub Actions. O pipeline inclui a construção da imagem Docker, execução de testes de segurança estática (SAST) com o Bandit, e envio da imagem Docker para o Docker Hub.

## Sumário

- [Requisitos](#requisitos)
- [Estrutura de Pastas](#estrutura-de-pastas)
- [Instruções de Configuração](#instruções-de-configuração)
- [Pipeline de CI/CD no GitHub Actions](#pipeline-de-cicd-no-github-actions)
  - [Etapas no Workflow](#etapas-no-workflow)
- [Dockerfile Explicado](#dockerfile-explicado)
- [Segurança com Bandit](#segurança-com-bandit)
- [Executando Localmente](#executando-localmente)

## Requisitos

Antes de configurar e implantar a aplicação, certifique-se de que você tem os seguintes requisitos:

- Docker instalado na sua máquina local
- Repositório GitHub com permissões para criar pipelines CI/CD
- Conta no Docker Hub para armazenar as imagens Docker
- Acesso ao GitHub Secrets para armazenar as credenciais do Docker Hub
