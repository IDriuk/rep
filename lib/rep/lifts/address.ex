defmodule Rep.Lifts.Address do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rep.Lifts.{Address, Mechanic}

  schema "addresses" do
    field :entrance, :string
    field :house, :string
    field :street, :string
    field :notes, :string
    belongs_to :mechanic, Mechanic

    timestamps()
  end

  @doc false
  def changeset(%Address{} = address, attrs) do
    address
    |> cast(attrs, [:street, :house, :entrance, :notes])
    |> validate_required([:street, :house, :entrance])
  end
end
