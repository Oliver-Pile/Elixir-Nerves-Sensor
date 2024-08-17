defmodule Publisher do
  use GenServer
  require Logger

  def start_link(opts \\ %{}) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl true
  def init(opts) do
    state = %{
      interval: opts[:interval] || 10_000,
      weather_tracker_url: opts[:weather_tracker_url],
      sensors: opts[:sensors],
      mesurements: :no_mesurements
    }

    schedule_next_publish(state.interval)

    {:ok, state}
  end

  defp schedule_next_publish(interval) do
    Process.send_after(self(), :publish_data, interval)
  end

  @impl true
  def handle_info(:publish_data, state) do
    {:noreply, state |> measure() |> publish()}
  end

  defp measure(state) do
    measurements =
      Enum.reduce(state.sensors, %{}, fn sensor, acc ->
        sensor_data = sensor.read.() |> sensor.convert.()
        Map.merge(acc, sensor_data)
      end)

    %{state | measurements: measurements}
  end

  defp publish(state) do
    result =
      :post
      |> Finch.build(
        state.weather_tracker_url,
        [{"Content-Type", "application/json"}],
        Jason.encode!(state.measurements)
      )
      |> Finch.request(WeatherTrackerClient)

    Logger.debug("Server response: #{inspect(result)}")
    schedule_next_publish(state.interval)
    state
  end
end
