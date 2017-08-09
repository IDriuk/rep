defmodule Rep.Lifts.Address do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rep.Lifts.{Address, Mechanic, Break, Complectation}

  schema "addresses" do
    field :entrance, :string
    field :house, :string
    field :street, :string
    field :notes, :string

    has_many :breaks, Break
    has_many :complectations, Complectation
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
