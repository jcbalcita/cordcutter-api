defmodule CordcutterApi.MovieController do
  use CordcutterApi.Web, :controller

  alias CordcutterApi.Movie

  def search(conn, %{"search_string" => search_string} = params) do
    search_string |> Movie.search |> case do
      {:ok, results} ->  json conn, results
      {:error, reason} -> json conn, reason
    end
  end

  def detail(conn, %{"id" => id} = params) do
    json conn, Movie.get_detail(id)
  end
end
