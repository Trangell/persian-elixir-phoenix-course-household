defmodule Household.HtmlApi.Device.DeviceQuery do
  import Ecto.Query
  alias Household.HtmlApi.Device.DeviceSchema
  alias Household.Repo
  # CRUD
  def get_divice_with_id(id) do
    Repo.get!(DeviceSchema, id)
  end

  def add_divice(attrs) do
    %DeviceSchema{}
    |> DeviceSchema.changeset(attrs)
    |> Repo.insert()
  end

  def delete_divice(id) do
    get_divice_with_id(id)
    |> Repo.delete
  end

  def divices("select") do
    query = from u in DeviceSchema,
    order_by: [desc: u.inserted_at],
    select: {u.name, u.id}
    Repo.all(query)
  end

  def divices do
    query = from u in DeviceSchema,
    order_by: [desc: u.inserted_at],
    select: %{
      id: u.id,
      name: u.name,
      inserted_at: u.inserted_at,
      updated_at: u.updated_at
    }
    Repo.all(query)
  end

  def update_divice(divice, attrs) do
    DeviceSchema.changeset(divice, attrs)
    |> Repo.update
  end

  def eidt_divice(id, new_divice) do
    get_divice_with_id(id)
    |> update_divice(new_divice)
  end
end
