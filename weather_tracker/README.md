# WeatherTracker

An API server responsible for receiving weather data from nerves devices and storing the result in a PG Timescale DB.

Currently only endpoint is: `POST /api/weather-conditions` where the payload is valid JSON for the required fields.

## Containers
This project also holds the `docker-compose.yml` file which contains definitions for the API server, Postgres DB and Grafana containers.

To start there containers run `docker compose up`.

Access the services on the following ports:
  - API `:4000`
  - Grafana `:3000`
  - DB `:5432`