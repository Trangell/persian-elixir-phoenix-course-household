defmodule Household.HtmlApi.Device.InvoiceStatusSchema do
  use Ecto.Schema

  import Ecto.Changeset
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id


  schema "invoice_statuses" do
    field :name, :string, size: 150, null: false

    has_many :invoices, Household.HtmlApi.Device.InvoiceSchema ,  foreign_key: :invoice_status_id, on_delete: :nothing

    timestamps()
  end

  def changeset(invoice_status, params \\ %{}) do
    invoice_status
    |> cast(params, [:name])
    |> validate_required([:name], message: "تمامی فیلد های مورد نظر باید وارد شود.")
    |> validate_length(:name, max: 150, message: "حداکثر مجاز 150 کاراکتر می باشد.")
    |> unique_constraint(:name, name: :unique_index_on_invoice_statuses_name, message: "تیتر وضعیت تحویل تکراری می باشد")
  end
end
