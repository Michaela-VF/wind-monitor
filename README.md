# 🌬️ Wind Monitor API

This is the Rails API backend for the Wind Monitor application. 
It receives turbine readings, 
evaluates alert conditions, and 
exposes JSON endpoints consumed by the React frontend.

---

## 🛠️ Tech Stack

- **Ruby** 3.3.1
- **Rails** 8.1.3 (API mode)
- **PostgreSQL**
- **No authentication** (open API — TODO for a future phase)

---

## 🏗️ Architecture

```
React Frontend (Vite)
       │
       │ HTTP Requests (JSON)
       ▼
Wind Monitor Rails API       ← We are here
       │
       ├── DashboardController   (metrics/counts)
       ├── ReadingsController    (create & list readings)
       └── AlertsController      (list & resolve alerts)
       │
       ▼
  PostgreSQL
       │
       ├── turbines
       ├── readings
       └── alerts
```

---

## 📁 Project Structure

```
app/
├── controllers/
│   ├── application_controller.rb
│   ├── dashboard_controller.rb
│   ├── readings_controller.rb
│   └── alerts_controller.rb
├── models/
│   ├── turbine.rb
│   ├── reading.rb
│   └── alert.rb
└── services/
    └── alert_service.rb
config/
└── routes.rb
db/
├── migrate/
└── seeds.rb
```

---

## 📐 Database Schema

### turbines
| Column | Type | Constraints |
|---|---|---|
| id | integer | primary key |
| name | string | not null |
| created_at | datetime | |
| updated_at | datetime | |

### readings
| Column | Type | Constraints |
|---|---|---|
| id | integer | primary key |
| turbine_id | integer | foreign key, not null |
| wind_speed | float | |
| power_output | float | |
| created_at | datetime | |
| updated_at | datetime | |

### alerts
| Column | Type | Constraints |
|---|---|---|
| id | integer | primary key |
| turbine_id | integer | foreign key, not null |
| message | string | |
| resolved | boolean | default: false |
| created_at | datetime | |
| updated_at | datetime | |

---

## 🔗 API Endpoints

### Dashboard

| Method | Path | Description |
|---|---|---|
| GET | `/dashboard` | Returns aggregate counts for the dashboard |

**Response:**
```json
{
  "turbine_count": 5,
  "reading_count": 527,
  "active_alerts": 1,
  "resolved_alerts": 1
}
```

---

### Readings

| Method | Path | Description |
|---|---|---|
| GET | `/readings` | Returns all readings |
| POST | `/readings` | Creates a new reading and checks for alerts |

**POST `/readings` — Request body:**
```json
{
  "reading": {
    "turbine_id": 1,
    "wind_speed": 12.5,
    "power_output": 3.2
  }
}
```

**POST `/readings` — Success response** `201 Created`:
```json
{
  "id": 1,
  "turbine_id": 1,
  "wind_speed": 12.5,
  "power_output": 3.2,
  "created_at": "...",
  "updated_at": "..."
}
```

**POST `/readings` — Error response** `422 Unprocessable Entity`:
```json
["Wind speed can't be blank"]
```

---

### Alerts

| Method | Path | Description |
|---|---|---|
| GET | `/alerts` | Returns all alerts, newest first |
| PATCH | `/alerts/:id` | Marks an alert as resolved |

**PATCH `/alerts/:id` — Response:**
```json
{
  "id": 1,
  "turbine_id": 2,
  "message": "High wind speed detected",
  "resolved": true,
  "created_at": "...",
  "updated_at": "..."
}
```

---

## 🚀 Getting Started

### Prerequisites

- Ruby 3.3.1
- Rails 8.1.3
- PostgreSQL running locally

### Setup

```bash
# Install dependencies
bundle install

# Create and migrate the database
rails db:create
rails db:migrate

# Seed the database with 5 turbines
rails db:seed

# Start the server
rails server
```

The API will be available at `http://localhost:3000`.

---

## 🌱 Seed Data

Running `rails db:seed` creates 5 turbines:

```
WT-001, WT-002, WT-003, WT-004, WT-005
```

---

## ⚙️ Services

### AlertService

Called automatically inside `ReadingsController#create` after every new reading is saved. 
Evaluates whether the reading warrants an alert (e.g. abnormal wind speed or power output) and creates an `Alert` record if so.

---

## 🔮 Planned/TODOs

- Authentication (JWT)
- Turbines CRUD endpoints
- Consistent error handling across all controllers
- Test suite
