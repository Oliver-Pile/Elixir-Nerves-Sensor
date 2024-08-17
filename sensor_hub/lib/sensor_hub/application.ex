defmodule SensorHub.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias SensorHub.Sensor

  @impl true
  def start(_type, _args) do
    children =
      [
        # Children for all targets
        # Starts a worker by calling: SensorHub.Worker.start_link(arg)
        # {SensorHub.Worker, arg},
      ] ++ children(Nerves.Runtime.mix_target())

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SensorHub.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # List all child processes to be supervised
  defp children(:host) do
    [
      # Children that only run on the host
      # Starts a worker by calling: SensorHub.Worker.start_link(arg)
      # {SensorHub.Worker, arg},
    ]
  end

  defp children(_target) do
    [
      # Children for all targets except host
      # Starts a worker by calling: SensorHub.Worker.start_link(arg)
      # {SensorHub.Worker, arg},
      {BMP280, [i2c_address: 0x77, name: BMP280]},
      {Finch, name: WeatherTrackerClient},
      {Publisher, %{sensors: sensors(), weather_tracker_url: weather_tracker_url()}}
    ]
  end

  defp sensors() do
    [Sensor.new(BMP280)]
  end

  defp weather_tracker_url() do
    Application.get_env(:sensor_hub, :weather_tracker_url)
  end
end
