defmodule Rep.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :street, :string
      add :house, :string
      add :entrance, :string

      timestamps()
    end

  end
end
