defmodule Household.HtmlApi.Device.BrandSchema do
  use Ecto.Schema

  import Ecto.Changeset
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id


  schema "brands" do
    field :name, :string, size: 150, null: false

    has_many :invoices, Household.HtmlApi.Device.InvoiceSchema ,  foreign_key: :brand_id, on_delete: :nothing

    timestamps()
  end

  def changeset(brand, params \\ %{}) do
    brand
    |> cast(params, [:name])
    |> validate_required([:name], message: "تمامی فیلد های مورد نظر باید وارد شود.")
    |> validate_length(:name, max: 150, message: "حداکثر مجاز 150 کاراکتر می باشد.")
    |> unique_constraint(:name, name: :unique_index_on_brands_name, message: "تیتر برند تکراری می باشد")
  end
end
