defmodule Household.HtmlApi.Device.BrandQuery do
  import Ecto.Query
  alias Household.HtmlApi.Device.BrandSchema
  alias Household.Repo
  # CRUD
  def get_brand_with_id(id) do
    Repo.get!(BrandSchema, id)
  end

  def add_brand(attrs) do
    %BrandSchema{}
    |> BrandSchema.changeset(attrs)
    |> Repo.insert()
  end

  def delete_brand(id) do
    get_brand_with_id(id)
    |> Repo.delete
  end

  def brands("select") do
    query = from u in BrandSchema,
    order_by: [desc: u.inserted_at],
    select: {u.name, u.id}
    Repo.all(query)
  end

  def brands do
    query = from u in BrandSchema,
    order_by: [desc: u.inserted_at],
    select: %{
      id: u.id,
      name: u.name,
      inserted_at: u.inserted_at,
      updated_at: u.updated_at
    }
    Repo.all(query)
  end

  def update_brand(brand, attrs) do
    BrandSchema.changeset(brand, attrs)
    |> Repo.update
  end

  def eidt_brand(id, new_brand) do
    get_brand_with_id(id)
    |> update_brand(new_brand)
  end
end
