# 📦 Sistema Controle de Estoque

🖥️ Sistema desktop para controle de estoque, desenvolvido em **Lazarus (Free Pascal)** com banco de dados **SQLite**.

---

## ✨ Funcionalidades

- Cadastro de Categorias  
- Cadastro de Cidades  
- Cadastro de Lojas  
- Cadastro de Fornecedores  
- Cadastro de Transportadoras  
- Cadastro de Produtos  
- Entradas de Estoque  
- Saídas de Estoque  
- Relacionamento entre entidades (produtos, fornecedores, categorias, etc)  
- Filtros e pesquisas em todos os cadastros  

---

## 🛠️ Tecnologias Utilizadas

- **Lazarus** (IDE e linguagem Free Pascal)  
- **SQLite** (banco de dados local)  
- **ZeosLib** (acesso a banco de dados)  

---

## 📋 Requisitos

- Lazarus IDE instalado
- ZeosLib instalado na IDE  
- Windows  
- Arquivo `sqlite3.dll` disponível na pasta do projeto  

---

## ▶️ Como rodar o projeto

1. Abra o **Lazarus** e carregue o arquivo `SistemaControleEstoque.lpi`.  
2. Certifique-se de que o arquivo `sqlite3.dll` está na mesma pasta do executável.  
3. Compile e execute o projeto.  
4. O banco de dados padrão é `BDEstoque.db`, já incluso no repositório.  

---

## 📑 Scripts SQL

- A pasta `ScriptsSQL` contém os scripts para:
  - Criação (`Tabelas.txt`)
  - Povoamento (`Povoamento.txt`) do banco de dados  

---

## 📜 Licença

Este projeto está licenciado sob a **licença MIT**. Veja o arquivo `LICENSE` para mais detalhes.

---

Desenvolvido por **Gabriel Alex Pinto Alves da Silva**