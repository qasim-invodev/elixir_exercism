defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:battery_percentage, :distance_driven_in_meters, :nickname]

  def new(nickname \\ "none") when is_binary(nickname) do
    car = %RemoteControlCar{nickname: nickname}
    %{car | battery_percentage: 100, distance_driven_in_meters: 0}
  end

  def display_distance(remote_car) when remote_car.__struct__ == RemoteControlCar do
    "#{remote_car.distance_driven_in_meters} meters"
  end

  def display_battery(remote_car) when remote_car.__struct__ == RemoteControlCar do
    if remote_car.battery_percentage > 0 do
      "Battery at #{remote_car.battery_percentage}%"
    else
      "Battery empty"
    end
  end

  def drive(remote_car) when remote_car.__struct__ == RemoteControlCar do
    if display_battery(remote_car) == "Battery empty" do
      remote_car
    else
      %{remote_car | battery_percentage: remote_car.battery_percentage - 1, distance_driven_in_meters: remote_car.distance_driven_in_meters + 20}
    end
  end
end
