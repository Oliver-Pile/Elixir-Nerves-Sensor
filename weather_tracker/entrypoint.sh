#!/bin/sh

# Wait for the DB
echo "Waiting for DB to be ready..."
while ! pg_isready -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER"; do
  sleep 1
done

# Run migrations
echo "Running Ecto migrations..."
/app/bin/migrate

# Start the app
echo "Starting Phoenix server..."
exec /app/bin/server