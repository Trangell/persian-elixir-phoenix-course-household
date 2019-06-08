defmodule HouseholdWeb.Router do
  use HouseholdWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HouseholdWeb do
    pipe_through :browser
    get "/", DashboardController, :dashboard

    get "/divices", ServiceController, :divices
    get "/new-divice", ServiceController, :new_divice
    post "/add-divice", ServiceController, :add_divice
    delete "/delete-divice/:id", ServiceController, :delete_divice
    get "/edit-divice/:id", ServiceController, :edit_divice
    put "/update-divice", ServiceController, :update_divice

    get "/brands", ServiceController, :brands
    get "/new-brand", ServiceController, :new_brand
    post "/add-brand", ServiceController, :add_brand
    delete "/delete-brand/:id", ServiceController, :delete_brand
    get "/edit-brand/:id", ServiceController, :edit_brand
    put "/update-brand", ServiceController, :update_brand

    get "/invoice-statuses", ServiceController, :invoice_statuses
    get "/new-invoice-status", ServiceController, :new_invoice_status
    post "/add-invoice-status", ServiceController, :add_invoice_status
    delete "/delete-invoice-status/:id", ServiceController, :delete_invoice_status
    get "/edit-invoice-status/:id", ServiceController, :edit_invoice_status
    put "/update-invoice-status", ServiceController, :update_invoice_status

    get "/invoices", InvoiceController, :invoices
    get "/new-invoice", InvoiceController, :new_invoice
    post "/add-invoice", InvoiceController, :add_invoice
    delete "/delete-invoice/:id", InvoiceController, :delete_invoice
    get "/edit-invoice/:id", InvoiceController, :edit_invoice
    put "/update-invoice", InvoiceController, :update_invoice
  end

  # Other scopes may use custom stacks.
  # scope "/api", HouseholdWeb do
  #   pipe_through :api
  # end
end
