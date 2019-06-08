defmodule Household.HtmlApi.Device.InvoiceQuery do
  import Ecto.Query
  alias Household.HtmlApi.Device.InvoiceSchema
  alias Household.Repo
  # CRUD
  def get_invoice_with_id(id) do
    Repo.get!(InvoiceSchema, id)
  end

  def add_invoice(attrs) do
    %InvoiceSchema{}
    |> InvoiceSchema.changeset(attrs)
    |> Repo.insert()
  end

  def delete_invoice(id) do
    get_invoice_with_id(id)
    |> Repo.delete
  end

  def invoices(pagenumber) do
    query = from u in InvoiceSchema,
    join: c in assoc(u, :brands),
    join: g in assoc(u, :devices),
    join: j in assoc(u, :invoice_statuses),
    order_by: [desc: u.inserted_at],
    select: %{
      id: u.id,
      name: u.name,
      last_name: u.last_name,
      inserted_at: u.inserted_at,
      updated_at: u.updated_at,
      brand_name: c.name,
      devices_name: g.name,
      invoice_status_name: j.name,
    }
    # Repo.all(query)
    # Repo.paginate(query)
    Repo.paginate(query, %{page: pagenumber, page_size: 30})
  end

  def update_invoice(invoice, attrs) do
    InvoiceSchema.changeset(invoice, attrs)
    |> Repo.update
  end

  def eidt_invoice(id, new_invoice) do
    get_invoice_with_id(id)
    |> update_invoice(new_invoice)
  end

  def create_uniq_invoice_id() do
    now_jalaali_time = Household.Extera.CalendarConverter.jalali_create(DateTime.utc_now, "number")
    "bkb-#{now_jalaali_time.year_number}-#{now_jalaali_time.month_name}-#{Household.random_string(8)}"
  end
end
