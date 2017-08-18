defmodule Rep.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :street, :string
      add :house, :integer
      add :entrance, :string
      add :notes, :string

      timestamps()
    end

  end
end
