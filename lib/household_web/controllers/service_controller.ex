defmodule HouseholdWeb.ServiceController do
  use HouseholdWeb, :controller
  alias Household.HtmlApi.Device.DeviceSchema
  alias Household.HtmlApi.Device.DeviceQuery

  alias Household.HtmlApi.Device.BrandSchema
  alias Household.HtmlApi.Device.BrandQuery

  alias Household.HtmlApi.Device.InvoiceStatusSchema
  alias Household.HtmlApi.Device.InvoiceStatusQuery

  def divices(conn, _params) do
    render(conn, "divices.html", divices: DeviceQuery.divices())
  end

  def new_divice(conn, _params) do
     changeset = DeviceSchema.changeset(%DeviceSchema{})
     render(conn, "new_divice.html", changeset: changeset)
  end

  def add_divice(conn, %{"device_schema" => device}) do
    case DeviceQuery.add_divice(device) do
      {:ok, _divice_info} ->
        conn
        |> put_flash(:success, "ذخیره سازی شما با موفقیت انجام گردید.")
        |> redirect(to: "#{HouseholdWeb.Router.Helpers.service_path(conn, :divices)}")
      {:error, changeset} ->
        conn
        |> put_flash(:danger, "مشکلی در فرم شما وجود دارد.")
        |> render("new_divice.html", changeset: changeset)
    end
  end

  def delete_divice(conn, %{"id" => id}) do
    with {:ok, divice_id} <- Ecto.UUID.cast(id),
         {:ok, _divice_info} <- DeviceQuery.delete_divice(divice_id) do
         conn
         |> put_flash(:success, "دستگاه مورد نظر شما حذف گردید.")
         |> redirect(to: "#{HouseholdWeb.Router.Helpers.service_path(conn, :divices)}")
    else
      _ ->
        conn
        |> put_flash(:danger, "مشکلی در حذف اتفاق افتاده است.")
        |> redirect(to: "#{HouseholdWeb.Router.Helpers.service_path(conn, :divices)}")
    end
  end

  def edit_divice(conn, %{"id" => id}) do
    case DeviceQuery.get_divice_with_id(id) do
      nil ->
        conn
        |> put_flash(:danger, "چنین صفحه ای وجود ندارد.")
        |> redirect(to: "#{HouseholdWeb.Router.Helpers.service_path(conn, :divices)}")
      divice_info ->
        changeset = DeviceSchema.changeset(divice_info)
        render(conn, "edit_divice.html", changeset: changeset)
    end
  end

  def update_divice(conn, %{"device_schema" => device}) do
    case DeviceQuery.eidt_divice(device["id"], device) do
      {:ok, _divice_info} ->
        conn
        |> put_flash(:success, "دستگاه مورد نظر به روز رسانی شد")
        |> redirect(to: "#{HouseholdWeb.Router.Helpers.service_path(conn, :divices)}")

      {:error, changeset} ->
        conn
        |> put_flash(:danger, "مشکلی در فرم شما وجود دارد.")
        |> render("edit_divice.html", changeset: changeset)
    end
  end





  #Brand
  def brands(conn, _params) do
    render(conn, "brands.html", brands: BrandQuery.brands())
  end

  def new_brand(conn, _params) do
     changeset = BrandSchema.changeset(%BrandSchema{})
     render(conn, "new_brand.html", changeset: changeset)
  end

  def add_brand(conn, %{"brand_schema" => brand}) do
    case BrandQuery.add_brand(brand) do
      {:ok, _brand_info} ->
        conn
        |> put_flash(:success, "ذخیره سازی شما با موفقیت انجام گردید.")
        |> redirect(to: "#{HouseholdWeb.Router.Helpers.service_path(conn, :brands)}")
      {:error, changeset} ->
        conn
        |> put_flash(:danger, "مشکلی در فرم شما وجود دارد.")
        |> render("new_brand.html", changeset: changeset)
    end
  end

  def delete_brand(conn, %{"id" => id}) do
    with {:ok, brand_id} <- Ecto.UUID.cast(id),
         {:ok, _brand_info} <- BrandQuery.delete_brand(brand_id) do
         conn
         |> put_flash(:success, "دستگاه مورد نظر حذف شد.")
         |> redirect(to: "#{HouseholdWeb.Router.Helpers.service_path(conn, :brands)}")
    else
      _ ->
        conn
        |> put_flash(:danger, "مشکلی در حذف اتفاق افتاده است.")
        |> redirect(to: "#{HouseholdWeb.Router.Helpers.service_path(conn, :brands)}")
    end
  end

  def edit_brand(conn, %{"id" => id}) do
    case BrandQuery.get_brand_with_id(id) do
      nil ->
        conn
        |> put_flash(:danger, "چنین صفحه ای وجود ندارد.")
        |> redirect(to: "#{HouseholdWeb.Router.Helpers.service_path(conn, :brands)}")
      brand_info ->
        changeset = BrandSchema.changeset(brand_info)
        render(conn, "edit_brand.html", changeset: changeset)
    end
  end

  def update_brand(conn, %{"brand_schema" => brand}) do
    case BrandQuery.eidt_brand(brand["id"], brand) do
      {:ok, _brand_info} ->
        conn
        |> put_flash(:success, "برند مورد نظر به روز رسانی شد.")
        |> redirect(to: "#{HouseholdWeb.Router.Helpers.service_path(conn, :brands)}")

      {:error, changeset} ->
        conn
        |> put_flash(:danger, "مشکلی در فرم شما وجود دارد.")
        |> render("edit_divice.html", changeset: changeset)
    end
  end






  #InvoiceStatus
  def invoice_statuses(conn, _params) do
    render(conn, "invoice_statuses.html", invoice_statuses: InvoiceStatusQuery.invoice_statuses())
  end

  def new_invoice_status(conn, _params) do
     changeset = InvoiceStatusSchema.changeset(%InvoiceStatusSchema{})
     render(conn, "new_invoice_status.html", changeset: changeset)
  end

  def add_invoice_status(conn, %{"invoice_status_schema" => invoice_status}) do
    case InvoiceStatusQuery.add_invoice_status(invoice_status) do
      {:ok, _invoice_status_info} ->
        conn
        |> put_flash(:success, "ذخیره سازی شما با موفقیت انجام گردید.")
        |> redirect(to: "#{HouseholdWeb.Router.Helpers.service_path(conn, :invoice_statuses)}")
      {:error, changeset} ->
        conn
        |> put_flash(:danger, "مشکلی در فرم شما وجود دارد.")
        |> render("new_invoice_status.html", changeset: changeset)
    end
  end

  def delete_invoice_status(conn, %{"id" => id}) do
    with {:ok, invoice_status_id} <- Ecto.UUID.cast(id),
         {:ok, _invoice_status_info} <- InvoiceStatusQuery.delete_invoice_status(invoice_status_id) do
         conn
         |> put_flash(:success, "وضعیت مورد نظر حذف گردید.")
         |> redirect(to: "#{HouseholdWeb.Router.Helpers.service_path(conn, :invoice_statuses)}")
    else
      _ ->
        conn
        |> put_flash(:danger, "مشکلی در حذف اتفاق افتاده است.")
        |> redirect(to: "#{HouseholdWeb.Router.Helpers.service_path(conn, :invoice_statuses)}")
    end
  end

  def edit_invoice_status(conn, %{"id" => id}) do
    case InvoiceStatusQuery.get_invoice_status_with_id(id) do
      nil ->
        conn
        |> put_flash(:danger, "چنین صفحه ای وجود ندارد.")
        |> redirect(to: "#{HouseholdWeb.Router.Helpers.service_path(conn, :invoice_statuses)}")
      invoice_status_info ->
        changeset = InvoiceStatusSchema.changeset(invoice_status_info)
        render(conn, "edit_invoice_status.html", changeset: changeset)
    end
  end

  def update_invoice_status(conn, %{"invoice_status_schema" => invoice_status}) do
    case InvoiceStatusQuery.eidt_invoice_status(invoice_status["id"], invoice_status) do
      {:ok, _invoice_status_info} ->
        conn
        |> put_flash(:success, "وضعیت مورد نظر به روز رسانی شد.")
        |> redirect(to: "#{HouseholdWeb.Router.Helpers.service_path(conn, :invoice_statuses)}")

      {:error, changeset} ->
        conn
        |> put_flash(:danger, "مشکلی در فرم شما وجود دارد.")
        |> render("edit_divice.html", changeset: changeset)
    end
  end
end
