defmodule Household.HtmlApi.Device.InvoiceStatusQuery do
  import Ecto.Query
  alias Household.HtmlApi.Device.InvoiceStatusSchema
  alias Household.Repo
  # CRUD
  def get_invoice_status_with_id(id) do
    Repo.get!(InvoiceStatusSchema, id)
  end

  def add_invoice_status(attrs) do
    %InvoiceStatusSchema{}
    |> InvoiceStatusSchema.changeset(attrs)
    |> Repo.insert()
  end

  def delete_invoice_status(id) do
    get_invoice_status_with_id(id)
    |> Repo.delete
  end

  def invoice_statuses("select") do
    query = from u in InvoiceStatusSchema,
    order_by: [desc: u.inserted_at],
    select: {u.name, u.id}
    Repo.all(query)
  end

  def invoice_statuses do
    query = from u in InvoiceStatusSchema,
    order_by: [desc: u.inserted_at],
    select: %{
      id: u.id,
      name: u.name,
      inserted_at: u.inserted_at,
      updated_at: u.updated_at
    }
    Repo.all(query)
  end

  def update_invoice_status(invoice_status, attrs) do
    InvoiceStatusSchema.changeset(invoice_status, attrs)
    |> Repo.update
  end

  def eidt_invoice_status(id, new_invoice_status) do
    get_invoice_status_with_id(id)
    |> update_invoice_status(new_invoice_status)
  end
end
