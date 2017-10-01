defmodule Rep.Lifts.Order do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rep.Lifts.{Order, Address}


  schema "orders" do
    field :ordered, :string
    field :received, :string
    field :sended, :date
    field :used, :string

    belongs_to :address, Address

    timestamps()
  end

  @doc false
  def changeset(%Order{} = order, attrs) do
    order
    |> cast(attrs, [:sended, :ordered, :received, :used])
    |> validate_required([:sended, :ordered])
  end
end
