defmodule Rep.Lifts.Mechanic do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rep.Lifts.Mechanic


  schema "mechanics" do
    field :district, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Mechanic{} = mechanic, attrs) do
    mechanic
    |> cast(attrs, [:district])
    |> validate_required([:district])
    |> unique_constraint(:user_id)
  end
end
