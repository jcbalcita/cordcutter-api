defmodule CordcutterApi.Movie do
  use CordcutterApi.Web, :model

  alias CordcutterApi.Endpoint
  @base_url Application.get_env(:cordcutter_api, Endpoint)[:base_url]
  @movie_query Application.get_env(:cordcutter_api, Endpoint)[:movie_query]
  @api_key Application.get_env(:cordcutter_api, Endpoint)[:api_key]

  def search_url(search_string) do
    "#{@base_url}#{@movie_query}#{search_string}&#{@api_key}"
  end

  def movie_url(id) do
    "#{@base_url}/movies/#{id}?#{@api_key}";
  end
end
