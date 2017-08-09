defmodule Rep.Repo.Migrations.AddMechanicIdToAddresses do
  use Ecto.Migration

  def change do
    alter table(:addresses) do
          add :mechanic_id, references(:mechanics, on_delete: :delete_all),
                          null: false
        end

    create index(:addresses, [:mechanic_id])
  end
end
