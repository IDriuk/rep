defmodule Rep.Lifts.Address do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rep.Lifts.Address


  schema "addresses" do
    field :entrance, :string
    field :house, :string
    field :street, :string

    timestamps()
  end

  @doc false
  def changeset(%Address{} = address, attrs) do
    address
    |> cast(attrs, [:street, :house, :entrance])
    |> validate_required([:street, :house, :entrance])
  end
end
