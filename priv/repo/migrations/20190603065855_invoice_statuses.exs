defmodule Household.Repo.Migrations.InvoiceStatuses do
  use Ecto.Migration
  @disable_ddl_transaction true

  def change do
    create table(:invoice_statuses, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string, null: false
      timestamps()
    end
    create(
      index(:invoice_statuses, [:name],
        concurrently: true,
        name: :unique_index_on_invoice_statuses_name,
        unique: true
      )
    )
  end
end
