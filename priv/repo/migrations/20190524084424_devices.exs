defmodule Household.Repo.Migrations.Devices do
  use Ecto.Migration
  @disable_ddl_transaction true

  def change do
    create table(:devices, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string, null: false
      timestamps()
    end
    create(
      index(:devices, [:name],
        concurrently: true,
        name: :unique_index_on_devices_name,
        unique: true
      )
    )
  end
end
