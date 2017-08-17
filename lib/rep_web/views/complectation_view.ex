defmodule RepWeb.ComplectationView do
  use RepWeb, :view

  alias Rep.Lifts.Address

  def get_short_address address do
    %Address{street: street, house: house, entrance: entrance} = address
    street <> " " <> to_string(house) <> " " <> to_string(entrance)
  end
end
