defmodule Rep.Lifts.Mechanic do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rep.Lifts.{Mechanic, Address}


  schema "mechanics" do
    field :district, :string

    has_many :addresses, Address
    belongs_to :user, Rep.Accounts.User

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
