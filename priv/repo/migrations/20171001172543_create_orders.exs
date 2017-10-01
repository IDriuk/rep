defmodule Rep.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :sended, :date
      add :ordered, :text
      add :received, :text
      add :used, :text
      add :address_id, references(:addresses, on_delete: :nothing)

      timestamps()
    end

    create index(:orders, [:address_id])
  end
end
