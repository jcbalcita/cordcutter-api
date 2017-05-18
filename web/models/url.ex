defmodule CordcutterApi.Url do
  @api_key Application.get_env(:cordcutter_api, CordcutterApi.Endpoint)[:api_key]
  @base_url Application.get_env(:cordcutter_api, CordcutterApi.Endpoint)[:base_url]
  @movie_query "/search?type=movie&field=title&query="
  @show_query "/search?type=show&field=title&query="

  def search_movie(search_string) do
    URI.encode("#{@base_url}#{@movie_query}#{search_string}&#{@api_key}")
  end

  def movie(id) do
    URI.encode("#{@base_url}/movies/#{id}?#{@api_key}")
  end

  def search_show(search_string) do
    URI.encode("#{@base_url}#{@show_query}#{search_string}&#{@api_key}")
  end

  def show(id) do
    URI.encode("#{@base_url}/shows/#{id}?#{@api_key}")
  end

  def show_content(id) do
    URI.encode("#{@base_url}/shows/#{id}/available_content?#{@api_key}")
  end

  def seasons(id) do
    URI.encode("#{@base_url}/shows/#{id}/seasons?#{@api_key}")
  end

  def season_detail(show_id, season_id) do
    URI.encode("#{@base_url}/shows/#{show_id}/episodes?season=#{season_id}&#{@api_key}&include_links=true")
  end
end
