defmodule Rep.Repo.Migrations.CreateComplectations do
  use Ecto.Migration

  def change do
    create table(:complectations) do
      add :station, :string
      add :floors, :integer
      add :underfloor, :boolean, default: false, null: false
      add :doors, :string
      add :notes, :string

      timestamps()
    end

  end
end
