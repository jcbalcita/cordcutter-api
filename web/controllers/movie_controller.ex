defmodule CordcutterApi.MovieController do
  use CordcutterApi.Web, :controller

  alias CordcutterApi.Movie

  def search(conn, %{"search_string" => search_string} = params) do
    Movie.search(search_string)
    |> case do
        {:ok, results} ->  json conn, results
        {:error, reason} -> json conn, reason
    end
  end

  def detail(conn, %{"id" => id} = params) do
    Movie.get_detail(id)
    |> case do
        {:ok, results} -> json conn, results
        {:error, reason} -> json conn, reason
    end
  end
end
