defmodule Rep.Repo.Migrations.AddIsAdminToCredentials do
  use Ecto.Migration

  def change do
    alter table(:credentials) do
      add :is_admin, :boolean, default: false, null: false
    end
  end
end
