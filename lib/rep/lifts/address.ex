defmodule Rep.Lifts.Address do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rep.Lifts.{Address, Mechanic, Break, Order, Complectation}

  schema "addresses" do
    field :entrance, :string
    field :house, :integer
    field :street, :string
    field :notes, :string

    has_one :complectations, Complectation
    has_many :breaks, Break
    has_many :orders, Order
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
