defmodule CordcutterApi.Movie do
  use CordcutterApi.Web, :model

  alias CordcutterApi.Url

  def search(search_string) do
    Url.search_movie(search_string)
    |> HTTPoison.get
    |> case do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          Poison.decode(body)
          |> case do
            {:ok, body} -> {:ok, body["results"]}
          end
        {:error, %HTTPoison.Error{reason: reason}} ->
          {:error, reason}
        end
  end

  def get_detail(id) do
    Url.movie(id)
    |> HTTPoison.get
    |> case do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Poison.decode(body)
        |> case do
            {:ok, body} -> {:ok, body}
           end
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
