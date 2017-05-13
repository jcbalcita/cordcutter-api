defmodule CordcutterApi.MovieController do
  use CordcutterApi.Web, :controller

  alias CordcutterApi.Movie

  def search(conn, %{"search_string" => search_string} = params) do
    Movie.search_url(search_string)
    |> HTTPoison.get
    |> case do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          Poison.decode(body)
          |> case do
              {:ok, body} -> json conn, body["results"]
            end
        {:error, %HTTPoison.Error{reason: reason}} ->
          json conn, %{error: reason}
      end
  end

  def detail(conn, %{"id" => id} = params) do
    Movie.movie_url(id)
    |> HTTPoison.get
    |> case do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          Poison.decode(body)
          |> case do
              {:ok, body} -> json conn, body
            end
        {:error, %HTTPoison.Error{reason: reason}} ->
          json conn, %{error: reason}
      end
  end
end
