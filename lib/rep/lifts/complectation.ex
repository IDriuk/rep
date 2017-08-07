defmodule Rep.Lifts.Complectation do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rep.Lifts.Complectation


  schema "complectations" do
    field :doors, :string
    field :floors, :integer
    field :notes, :string
    field :station, :string
    field :underfloor, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(%Complectation{} = complectation, attrs) do
    complectation
    |> cast(attrs, [:station, :floors, :underfloor, :doors])
    |> validate_required([:station, :floors, :underfloor, :doors])
  end
end
