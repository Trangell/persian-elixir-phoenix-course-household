defmodule Household.Repo.Migrations.Brands do
  use Ecto.Migration
  @disable_ddl_transaction true

  def change do
    create table(:brands, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string, null: false
      timestamps()
    end
    create(
      index(:brands, [:name],
        concurrently: true,
        name: :unique_index_on_brands_name,
        unique: true
      )
    )
  end
end
