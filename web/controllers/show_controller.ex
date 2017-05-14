defmodule CordcutterApi.ShowController do
  use CordcutterApi.Web, :controller

  alias CordcutterApi.Show

  def search(conn, %{"search_string" => search_string} = params) do
    Show.search(search_string)
    |> case do
        {:ok, results} ->  json conn, results
        {:error, reason} -> json conn, reason
    end
  end

  def detail(conn, %{"id" => id} = params) do
    show = Show.get_detail(id)
    json conn, show
  end

  def season(conn, %{"id" => id, "season_id" => season_id} = params) do
    IO.inspect(params)
    season_detail = Show.get_season_detail(id, season_id)
    json conn, season_detail
  end
end
