defmodule Rep.Lifts.Break do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rep.Lifts.{Break, Address}


  schema "breaks" do
    field :fixed, :boolean, default: false
    field :notes, :string
    field :served, :date
    field :started, :boolean, default: false
    field :stoped, :boolean, default: false

    belongs_to :address, Address

    timestamps()
  end

  @doc false
  def changeset(%Break{} = break, attrs) do
    break
    |> cast(attrs, [:served, :stoped, :started, :fixed, :notes])
    |> validate_required([:served, :stoped, :started, :fixed])
  end
end
