defmodule WeatherTracker.WeatherConditions do
  alias WeatherTracker.{Repo, WeatherConditions.WeatherCondition}


  def create_entry(attr) do
    %WeatherCondition{}
    |> WeatherCondition.create_changeset(attr)
    |> Repo.insert()
  end
end
