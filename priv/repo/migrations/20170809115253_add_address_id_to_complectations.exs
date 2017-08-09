defmodule Rep.Repo.Migrations.AddAddressIdToComplectations do
  use Ecto.Migration

  def change do
    alter table(:complectations) do
          add :address_id, references(:addresses, on_delete: :delete_all),
                          null: false
        end

    create index(:complectations, [:address_id])
  end
end
