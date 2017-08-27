defmodule Rep.Repo.Migrations.AddPasswordAndPasswordHashToCredentials do
  use Ecto.Migration

  def change do
    alter table(:credentials) do
      add :password, :string
      add :password_hash, :string
    end

  end
end
