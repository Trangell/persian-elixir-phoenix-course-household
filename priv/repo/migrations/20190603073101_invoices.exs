defmodule Household.Repo.Migrations.Invoices do
  use Ecto.Migration
  @disable_ddl_transaction true

  def change do
    create table(:invoices, primary_key: false) do
      add :id, :uuid, primary_key: false
      add :name, :string, null: false
      add :last_name, :string, null: false
      add :delivery_time, :utc_datetime, null: true
      add :price, :string, null: false
      add :mobile, :string, null: false
      add :description, :text, null: false
      add :code, :string, null: false

      add :invoice_status_id, references(:invoice_statuses, on_delete: :nothing, type: :uuid)
      add :brand_id, references(:brands, on_delete: :nothing, type: :uuid)
      add :device_id, references(:devices, on_delete: :nothing, type: :uuid)
      timestamps()
    end
    create(
      index(:invoices, [:code],
        concurrently: true,
        name: :unique_index_on_invoices_code,
        unique: true
      )
    )
  end
end
