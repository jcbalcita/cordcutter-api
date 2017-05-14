defmodule CordcutterApi.Url do
  use CordcutterApi.Web, :model

  alias CordcutterApi.Endpoint
  @base_url Application.get_env(:cordcutter_api, Endpoint)[:base_url]
  @movie_query Application.get_env(:cordcutter_api, Endpoint)[:movie_query]
  @show_query Application.get_env(:cordcutter_api, Endpoint)[:show_query]
  @api_key Application.get_env(:cordcutter_api, Endpoint)[:api_key]

  def search_movie(search_string) do
    "#{@base_url}#{@movie_query}#{search_string}&#{@api_key}"
  end

  def movie(id) do
    "#{@base_url}/movies/#{id}?#{@api_key}";
  end

  def search_show(search_string) do
    "#{@base_url}#{@show_query}#{search_string}&#{@api_key}"
  end

  def show(id) do
    "#{@base_url}/shows/#{id}?#{@api_key}"
  end

  def show_content(id) do
    "#{@base_url}/shows/#{id}/available_content?#{@api_key}"
  end

  def seasons(id) do
    "#{@base_url}/shows/#{id}/seasons?#{@api_key}"
  end

  def season_detail(show_id, season_id) do
    "#{@base_url}/shows/#{show_id}/episodes?season=#{season_id}&#{@api_key}"
  end
end
