defmodule RepWeb.AddressView do
  use RepWeb, :view

  def to_date dt do
    dt
    |> Date.to_string
    |> String.split("-")
    |> Enum.reverse
    |> Enum.join("/")
  end
end
