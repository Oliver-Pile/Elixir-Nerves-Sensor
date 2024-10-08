defmodule SensorHub.Sensor do
  defstruct [:name, :fields, :read, :convert]

  def measure(sensor) do
    sensor.read.()
    |> sensor.convert.()
  end

  def new(name) do
    %__MODULE__{
      read: read_fn(name),
      convert: convert_fn(name),
      fields: fields(name),
      name: name
    }
  end

  def fields(BMP280), do: [:altitude_m, :pressure_pa, :temperature_c]

  def read_fn(BMP280), do: fn -> BMP280.measure(BMP280) end

  def convert_fn(BMP280) do
    fn reading ->
      case reading do
        {:ok, measurement} ->
          Map.take(measurement, [:altitude_m, :pressure_pa, :temperature_c])
        _ ->
          %{}
      end
    end
  end

end
