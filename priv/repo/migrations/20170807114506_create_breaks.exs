defmodule Rep.Repo.Migrations.CreateBreaks do
  use Ecto.Migration

  def change do
    create table(:breaks) do
      add :served, :date
      add :stoped, :boolean, default: false, null: false
      add :started, :boolean, default: false, null: false
      add :fixed, :boolean, default: false, null: false
      add :notes, :string

      timestamps()
    end

  end
end
