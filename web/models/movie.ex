defmodule CordcutterApi.Movie do
  use CordcutterApi.Web, :model

  alias CordcutterApi.Url
  alias CordcutterApi.Requester

  def search(search_string) do
    Url.search_movie(search_string)
    |> Requester.get
    |> case do
        {:ok, body} -> {:ok, body["results"]}
    end
  end

  def get_detail(id) do
    Url.movie(id)
    |> Requester.get
  end

end
