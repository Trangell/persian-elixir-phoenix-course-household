defmodule Household.HtmlApi.Device.InvoiceSchema do
  use Ecto.Schema

  import Ecto.Changeset
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id


  schema "invoices" do
    field :name, :string, size: 150, null: false
    field :last_name, :string, size: 150, null: false
    field :price, :string, size: 150, null: false
    field :mobile, :string, size: 11, null: false
    field :description, :string, null: false
    field :code, :string, size: 200, null: false

    field :persian_delivery_time, :string, virtual: true

    field :delivery_time, :utc_datetime, null: true

    belongs_to :invoice_statuses, Household.HtmlApi.Device.InvoiceStatusSchema, foreign_key: :invoice_status_id, type: :binary_id
    belongs_to :brands, Household.HtmlApi.Device.BrandSchema, foreign_key: :brand_id, type: :binary_id
    belongs_to :devices, Household.HtmlApi.Device.DeviceSchema, foreign_key: :device_id, type: :binary_id

    timestamps()
  end

  def changeset(invoice_status, params \\ %{}) do
    invoice_status
    |> cast(params, [:name, :last_name, :price, :mobile, :description, :code, :delivery_time, :invoice_status_id, :brand_id, :device_id, :persian_delivery_time])
    |> validate_required([:name, :last_name, :price, :mobile, :description, :code, :invoice_status_id, :brand_id, :device_id, :persian_delivery_time], message: "تمامی فیلد های مورد نظر باید وارد شود.")
    |> validate_length(:name, max: 150, message: "حداکثر مجاز 150 کاراکتر می باشد.")
    |> change_time()
    |> foreign_key_constraint(:invoice_status_id)
    |> foreign_key_constraint(:brand_id)
    |> foreign_key_constraint(:device_id)
    |> unique_constraint(:name, name: :unique_index_on_invoice_statuses_name, message: "تیتر وضعیت تحویل تکراری می باشد")
  end

  defp change_time(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{persian_delivery_time: persian_delivery_time}} ->
        put_change(changeset, :delivery_time, Household.Extera.CalendarConverter.jalali_string_to_miladi_english_number(persian_delivery_time))
      _ -> changeset
    end
  end

end
