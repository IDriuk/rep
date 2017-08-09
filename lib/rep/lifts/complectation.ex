defmodule Rep.Lifts.Complectation do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rep.Lifts.{Complectation, Address}


  schema "complectations" do
    field :doors, :string
    field :floors, :integer
    field :notes, :string
    field :station, :string
    field :underfloor, :boolean, default: false

    belongs_to :address, Address

    timestamps()
  end

  @doc false
  def changeset(%Complectation{} = complectation, attrs) do
    complectation
    |> cast(attrs, [:station, :floors, :underfloor, :doors, :notes])
    |> validate_required([:station])
  end
end
