defmodule Rep.Repo.Migrations.CreateMechanics do
  use Ecto.Migration

  def change do
    create table(:mechanics) do
      add :district, :string
      add :user_id, references(:users, on_delete: :delete_all),
                    null: false

      timestamps()
    end

    create unique_index(:mechanics, [:user_id])
  end
end
