# Todo API

API Rails para gerenciamento de tarefas com hierarquia (tarefas pai/filho).

## Como Rodar

### Pré-requisitos
- Ruby 3.x
- Rails 8.1
- SQLite3

### Instalação e Execução

```bash
# Instalar dependências
bundle install

# Criar e configurar o banco de dados
rails db:create db:migrate

# Rodar os testes
bundle exec rspec

# Iniciar o servidor
rails server
```

A API estará disponível em `http://localhost:3000`

## Endpoints Principais

- `GET /tasks` - Lista todas as tarefas
- `POST /tasks` - Cria uma nova tarefa
- `POST /tasks/:id` - Atualiza uma tarefa existente
- `DELETE /tasks/:id` - Deleta uma tarefa (se não tiver filhos)

## Funcionalidades

- Tarefas podem ter tarefas pai (hierarquia)
- Data de vencimento da tarefa filha deve ser >= data da tarefa pai
- Ao alterar a data de uma tarefa pai, as datas das filhas são propagadas automaticamente
- Não é possível deletar tarefas que possuem filhas
- Validação contra dependências circulares

---

*README gerado com auxílio de IA*
