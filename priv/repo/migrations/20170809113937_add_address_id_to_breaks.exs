defmodule Rep.Repo.Migrations.AddAddressIdToBreaks do
  use Ecto.Migration

  def change do
    alter table(:breaks) do
          add :address_id, references(:addresses, on_delete: :delete_all),
                          null: false
        end

    create index(:breaks, [:address_id])
  end
end
