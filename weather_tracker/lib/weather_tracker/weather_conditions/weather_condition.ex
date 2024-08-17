defmodule WeatherTracker.WeatherConditions.WeatherCondition do
  use Ecto.Schema
  import Ecto.Changeset

  @allowed_fields [
    :altitude_m,
    :pressure_pa,
    :temperature_c
  ]

  @derive {Jason.Encoder, only: @allowed_fields}
  @primary_key false
  schema "weather_conditions" do
    field :timestamps, :naive_datetime
    field :altitude_m, :decimal
    field :pressure_pa, :decimal
    field :temperature_c, :decimal
  end



  def create_changeset(weather_conditions = %__MODULE__{}, attrs) do
    timestamp = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

    weather_conditions
    |> cast(attrs, @allowed_fields)
    |> validate_required(@allowed_fields)
    |> put_change(:timestamp, timestamp)
  end
end
