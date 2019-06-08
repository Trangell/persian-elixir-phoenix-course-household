defmodule Household.Extera.Paginate do

  def blog_navigation(page_router_number, json_number_db) do
    start_number = compare_with_pagenumber(page_router_number, json_number_db)
    start_number..start_number+5
    |> Enum.to_list
    |> Enum.filter(fn(x) -> x <= json_number_db end)
  end

  def compare_with_pagenumber(page_router_number, json_number_db) when page_router_number <= json_number_db do
    page_router_number
    |> integer_geter
  end

  def compare_with_pagenumber(_page_router_number, _json_number_db), do: 1

  def integer_geter(string) do
    output = "#{string}"
    |> String.replace(~r/[^\d]/, "")

    case output do
      ""  ->
        1
      n   ->
        String.to_integer(n)
    end
  end
end
