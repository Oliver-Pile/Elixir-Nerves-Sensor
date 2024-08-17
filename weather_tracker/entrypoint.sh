#!/bin/bash
# Docker entrypoint script.

# Wait until Postgres is ready
# echo "Testing if Postgres is accepting connections. db postgres"
# while ! pg_isready -q -h db -p 5432 -U postgres
# do
#   echo "$(date) - waiting for database to start"
#   sleep 2
# done

sleep 10

echo "Database weather_tracker_dev does not exist. Creating..."
mix ecto.setup
echo "Database weather_tracker_dev created."


exec mix phx.server