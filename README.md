#  Wind Farm Monitoring System

A backend-focused simulation of a wind farm monitoring platform.  
The system ingests turbine sensor data, 
stores it in a database, and 
generates alerts based on operational conditions.

---

##  Overview

This project simulates a real-world renewable energy monitoring system used in wind farm operations.

It demonstrates:

- REST API design;
- Time-series data ingestion;
- Backend business logic;
- Data persistence with PostgreSQL;
- System monitoring concepts.

---

##  Architecture

Simulator → Rails API → PostgreSQL → Dashboard

# Steps:
# PHASE 1 — Rails + PostgreSQL setup (do this first)
1. Create the project
	`rails new wind_monitor --api -d postgresql`
	`cd wind_monitor`

2. Setup database
	`rails db:create`

3. Generate models (ONLY 3)
	`rails g model Turbine name:string`
	`rails g model Reading turbine:references` `wind_speed:float power_output:float`
	`rails g model Alert turbine:references` `message:string resolved:boolean`
Add in the Turbine model: 
	has_many :readings
	has_many :alerts

4. Migrate database
	`rails db:migrate`

5. Seed turbines (!!!)
Open:
	`db/seeds.rb`
Paste:
    Turbine.create!(name: "WT-001")
    Turbine.create!(name: "WT-002")
    Turbine.create!(name: "WT-003")
    Turbine.create!(name: "WT-004")
    Turbine.create!(name: "WT-005")
Then run:
    `rails db:seed`

### CHECK - Confirm Seeding
Run:
    `rails console`
Then:
    `Turbine.all`
Should show the 5 WTs.

# PHASE 2 — First API endpoint: `POST/readings`:

6. Create controller
    `rails g controller Readings`

7. Implement controller `create` action
Open:
    `app/controllers/readings_controller.rb`

8. Add route
Open:
    config/routes.rb
Add:
    `post "/readings", to: "readings#create"`


# Second API endpoint: `GET/readings`:
9. Implement controller `index` action
Open:
    `app/controllers/readings_controller.rb`

10. Add route
Open:
    config/routes.rb
Add:
    `get "/readings", to: "readings#index"`

### Test endpoint with curl by creating a reading:
curl -X POST http://localhost:3000/readings \
  -H "Content-Type: application/json" \
  -d '{
    "reading": {
      "turbine_id": 1,
      "wind_speed": 8.2,
      "power_output": 1.4
    }
  }'

Confirm `reading` creation:
Run:
    `rails console`
Then:
    `Reading.all`
Should show the above [created reading](wind-monitor/images/json-wt-reading.png).

Then:
    `http://localhost:3000/readings`
Should show the [json reading]( wind-monitor/images/json-wt-reading.png.) on the browser.

# Second API endpoint: `GET/readings`:
9. Implement controller `index` action
Open:
    `app/controllers/readings_controller.rb`

10. Add route
Open:
    config/routes.rb
Add:
    `get "/readings", to: "readings#index"`

# PHASE 3 — Simulator
Now we create fake turbine data.

9. Create simulator script
Create file:
    `touch wt-data-simulator.rb`
Populate it simply to generate data for 5 wt every 5 sec.

10. Run simulator
In a NEW terminal:
    `ruby wt-data-simulator.rb`

# So far:
    Simulator → Rails API → PostgreSQL

[In Action Visualisation](images/json-wt-reading.png)
