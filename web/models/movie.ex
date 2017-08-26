defmodule CordcutterApi.Movie do
  use CordcutterApi.Web, :model

  alias CordcutterApi.Movie

  @url CordcutterApi.Url
  @requester CordcutterApi.Requester

  defstruct [id: nil, display: nil, sources: nil]

  defmodule MovieDisplay do
    defstruct [poster: nil, title: nil, release_year: nil, overview: nil]
  end

  defmodule MovieSources do
    defstruct [free: nil, tv_everywhere: nil, subscription: nil, purchase: nil]
  end

  @spec search(string, module, module) :: tuple
  def search(search_string, url \\ @url, requester \\ @requester) do
    search_string |> url.search_movie |> requester.get |> case do
      {:ok, body} -> {:ok, body["results"]}
    end
  end

  @spec get_detail(integer, module, module) :: struct
  def get_detail(id, url \\ @url, requester \\ @requester) do
    id |> url.movie |> requester.get |> case do
      {:ok, body} -> parse_results(id, body)
    end
  end

  @spec parse_results(integer, string) :: struct
  defp parse_results(id, body) do
    %Movie{id: id} |> parse_display(body) |> parse_sources(body)
  end

  @spec parse_display(struct, string) :: struct
  defp parse_display(movie, body) do
    %{
      "poster_240x342" => poster,
      "title" => title,
      "release_year" => release_year,
      "overview" => overview
    } = body
    %Movie{movie | display: %MovieDisplay{
        poster: poster,
        title: title,
        release_year: release_year,
        overview: overview
    }}
  end

  @spec parse_sources(struct, string) :: struct
  defp parse_sources(movie, body) do
    %{
      "free_web_sources" => free,
      "subscription_web_sources" => subscription,
      "tv_everywhere_web_sources" => tv_everywhere,
      "purchase_web_sources" => purchase
    } = body
    %Movie{movie | sources: %MovieSources{
      free: free,
      subscription: subscription,
      tv_everywhere: tv_everywhere,
      purchase: purchase
    }}
  end
end
