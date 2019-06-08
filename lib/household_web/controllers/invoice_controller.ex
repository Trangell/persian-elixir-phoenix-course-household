defmodule HouseholdWeb.InvoiceController do
  use HouseholdWeb, :controller
  alias Household.HtmlApi.Device.InvoiceSchema
  alias Household.HtmlApi.Device.InvoiceQuery

  def invoices(conn, %{"start" => start}) do
    invoices =  InvoiceQuery.invoices(start)
    render(conn, "invoices.html", invoices: invoices, page_number: invoices.page_number, total_pages: invoices.total_pages)
  end

  def invoices(conn, _params) do
    invoices =  InvoiceQuery.invoices(1)
    render(conn, "invoices.html", invoices: invoices, page_number: invoices.page_number, total_pages: invoices.total_pages)
  end

  def new_invoice(conn, _params) do
     changeset = InvoiceSchema.changeset(%InvoiceSchema{})
     render(conn,
            "new_invoice.html", changeset: changeset,
            brands: Household.HtmlApi.Device.BrandQuery.brands("select"),
            divices: Household.HtmlApi.Device.DeviceQuery.divices("select"),
            invoice_statuses: Household.HtmlApi.Device.InvoiceStatusQuery.invoice_statuses("select")
     )
  end

  def add_invoice(conn, %{"invoice_schema" => invoice}) do
    case InvoiceQuery.add_invoice(Map.merge(invoice, %{"code" => InvoiceQuery.create_uniq_invoice_id()})) do
      {:ok, _invoice_info} ->
        conn
        |> put_flash(:success, "ذخیره سازی شما با موفقیت انجام گردید.")
        |> redirect(to: "#{HouseholdWeb.Router.Helpers.invoice_path(conn, :invoices)}")
      {:error, changeset} ->
        conn
        |> put_flash(:danger, "مشکلی در فرم شما وجود دارد.")
        |> render("new_invoice.html", changeset: changeset,
                                      brands: Household.HtmlApi.Device.BrandQuery.brands("select"),
                                      divices: Household.HtmlApi.Device.DeviceQuery.divices("select"),
                                      invoice_statuses: Household.HtmlApi.Device.InvoiceStatusQuery.invoice_statuses("select"))
    end
  end

  def delete_invoice(conn, %{"id" => id}) do
    with {:ok, invoice_id} <- Ecto.UUID.cast(id),
         {:ok, _invoice_info} <- InvoiceQuery.delete_invoice(invoice_id) do
         conn
         |> put_flash(:success, "دستگاه مورد نظر شما حذف گردید.")
         |> redirect(to: "#{HouseholdWeb.Router.Helpers.invoice_path(conn, :invoices)}")
    else
      _ ->
        conn
        |> put_flash(:danger, "مشکلی در حذف اتفاق افتاده است.")
        |> redirect(to: "#{HouseholdWeb.Router.Helpers.invoice_path(conn, :invoices)}")
    end
  end

  def edit_invoice(conn, %{"id" => id}) do
    case InvoiceQuery.get_invoice_with_id(id) do
      nil ->
        conn
        |> put_flash(:danger, "چنین صفحه ای وجود ندارد.")
        |> redirect(to: "#{HouseholdWeb.Router.Helpers.invoice_path(conn, :invoices)}")
      invoice_info ->
        changeset = InvoiceSchema.changeset(invoice_info)
        render(conn, "edit_invoice.html", changeset: changeset,
                                          brands: Household.HtmlApi.Device.BrandQuery.brands("select"),
                                          divices: Household.HtmlApi.Device.DeviceQuery.divices("select"),
                                          invoice_statuses: Household.HtmlApi.Device.InvoiceStatusQuery.invoice_statuses("select")
        )
    end
  end

  def update_invoice(conn, %{"invoice_schema" => invoice}) do
    case InvoiceQuery.eidt_invoice(invoice["id"], invoice) do
      {:ok, _invoice_info} ->
        conn
        |> put_flash(:success, "دستگاه مورد نظر به روز رسانی شد")
        |> redirect(to: "#{HouseholdWeb.Router.Helpers.invoice_path(conn, :invoices)}")

      {:error, changeset} ->
        conn
        |> put_flash(:danger, "مشکلی در فرم شما وجود دارد.")
        |> render("edit_invoice.html", changeset: changeset,
                                                  brands: Household.HtmlApi.Device.BrandQuery.brands("select"),
                                                  divices: Household.HtmlApi.Device.DeviceQuery.divices("select"),
                                                  invoice_statuses: Household.HtmlApi.Device.InvoiceStatusQuery.invoice_statuses("select")
        )
    end
  end
end
