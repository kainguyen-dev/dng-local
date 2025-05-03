# Local Development Environment

This project includes a Docker Compose setup for local development with PostgreSQL, Redis, and RabbitMQ. The environment is pre-configured and easy to spin up with a single command.

## 🚀 Getting Started

### Prerequisites

* [Docker](https://www.docker.com/products/docker-desktop)
* [Docker Compose](https://docs.docker.com/compose/install/)

### 🔧 Services

| Service  | Version              | Port(s)     | Description               |
| -------- | -------------------- | ----------- | ------------------------- |
| Postgres | `17beta2-alpine3.19` | 8432 → 5432 | Relational database       |
| Redis    | `7.2.4`              | 6379        | In-memory key-value store |
| RabbitMQ | `4.1.0-management`   | 5672, 15672 | Message broker w/ UI      |

### 📦 Start the Environment

```bash
docker-compose up --build
```

This will start the following containers:

* `dng_db`
* `dng_redis`
* `dng_rabbitmq`

### 📁 Project Structure

```
.
├── docker-compose.yml       # Docker services configuration
├── init/                    # SQL scripts to initialize the Postgres DB
└── README.md                # This file
```

### 🗃️ Database Initialization

The `./init` directory contains SQL scripts that are automatically run when the Postgres container is initialized.

### 📊 RabbitMQ Management UI

Access the management interface at:
👉 [http://localhost:15672](http://localhost:15672)

* **Username:** `rabbit`
* **Password:** `rabbit`

## 🛑 Shut Down

To stop and remove all containers, volumes, and networks:

```bash
docker-compose down -v
```

---
