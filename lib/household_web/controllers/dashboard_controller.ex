defmodule HouseholdWeb.DashboardController do
  use HouseholdWeb, :controller

  def dashboard(conn, _params) do
    render(conn, "index.html")
  end


end
