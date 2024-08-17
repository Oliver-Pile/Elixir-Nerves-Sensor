defmodule WeatherTrackerWeb.WeatherConditionsController do
  use WeatherTrackerWeb, :controller

  require Logger

  alias WeatherTracker.{WeatherConditions, WeatherConditions.WeatherCondition}

  def create(conn, params) do
    IO.inspect(params)

    case WeatherConditions.create_entry(params) do
      {:ok, weather_condition} ->
        Logger.debug("Sucessfully created entry")

        conn |> put_status(:created) |> json(weather_condition)

      error ->
        Logger.warn("Failed to create entry: #{inspect(error)}")

        conn |> put_status(:unprocessable_entity) |> json(%{message: "Poorly formatted payload"})
    end
  end
end
