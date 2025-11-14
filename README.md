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
- `GET /tasks/:id` - Mostra uma tarefa específica
- `POST /tasks` - Cria uma nova tarefa
- `POST /tasks/:id` - Atualiza uma tarefa existente
- `DELETE /tasks/:id` - Deleta uma tarefa (se não tiver filhos)

## Exemplos de Requisições

### 1. Criar tarefa "Reboco"
```bash
curl -X POST http://localhost:3000/tasks \
  -H "Content-Type: application/json" \
  -d '{
    "task": {
      "title": "Reboco",
      "description": "Aplicar reboco na parede",
      "due_date": "2025-11-20"
    }
  }'
```

**Resposta:**
```json
{
  "id": 1,
  "title": "Reboco",
  "description": "Aplicar reboco na parede",
  "due_date": "2025-11-20",
  "parent_id": null,
  "created_at": "2025-11-14T10:00:00.000Z",
  "updated_at": "2025-11-14T10:00:00.000Z"
}
```

### 2. Criar tarefa "Pintura" com pai "Reboco"
```bash
curl -X POST http://localhost:3000/tasks \
  -H "Content-Type: application/json" \
  -d '{
    "task": {
      "title": "Pintura",
      "description": "Pintar a parede",
      "due_date": "2025-11-25",
      "parent_id": 1
    }
  }'
```

### 3. Alterar data de vencimento do "Reboco"
```bash
curl -X POST http://localhost:3000/tasks/1 \
  -H "Content-Type: application/json" \
  -d '{
    "task": {
      "due_date": "2025-11-22"
    }
  }'
```

**Resultado:** A data da tarefa "Pintura" será automaticamente ajustada para `2025-11-27` (mantendo a diferença de 5 dias).

### 4. Consultar uma tarefa com suas filhas
```bash
curl http://localhost:3000/tasks/1
```

**Resposta:**
```json
{
  "id": 1,
  "title": "Reboco",
  "description": "Aplicar reboco na parede",
  "due_date": "2025-11-22",
  "parent_id": null,
  "children": [
    {
      "id": 2,
      "title": "Pintura",
      "due_date": "2025-11-27",
      "parent_id": 1
    }
  ]
}
```

### 5. Listar todas as tarefas
```bash
curl http://localhost:3000/tasks
```

### 6. Tentar deletar tarefa com filhas (erro esperado)
```bash
curl -X DELETE http://localhost:3000/tasks/1
```

**Resposta:**
```json
{
  "errors": ["Cannot delete task with children"]
}
```

## Funcionalidades

- Tarefas podem ter tarefas pai (hierarquia)
- Data de vencimento da tarefa filha deve ser >= data da tarefa pai
- Ao alterar a data de uma tarefa pai, as datas das filhas são propagadas automaticamente
- Não é possível deletar tarefas que possuem filhas
- Validação contra dependências circulares

---

*README gerado com auxílio de IA*
