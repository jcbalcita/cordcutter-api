defmodule CordcutterApi.Show do
  use CordcutterApi.Web, :model

  alias CordcutterApi.Show

  @url CordcutterApi.Url
  @requester CordcutterApi.Requester

  defstruct [id: nil, display: nil, content: nil, seasons: nil]

  defmodule ShowDisplay do
    defstruct [:title, :artwork, :first_aired, :overview]
  end

  @spec search(string, module, module) :: tuple
  def   search(search_string, url \\ @url, requester \\ @requester) do
    url.search_show(search_string)
    |> requester.get
    |> case do
        {:ok, body} -> {:ok, body["results"]}
    end
  end

  @spec get_detail(integer) :: struct
  def   get_detail(id) do
    %Show{id: id}
    |> get_display
    |> get_content
    |> get_seasons
  end

  @spec get_season_detail(integer, integer, module, module) :: struct
  def   get_season_detail(id, season_id, url \\ @url, requester \\ @requester) do
    url.season_detail(id, season_id)
    |> requester.get
    |> case do
        {:ok, body} -> body["results"]
    end
  end

  @spec get_display(struct, module, module) :: struct
  defp  get_display(show, url \\ @url, requester \\ @requester) do
    url.show(show.id)
    |> requester.get
    |> case do
        {:ok, body} ->
          %{
            "title" => title,
            "artwork_304x171" => artwork,
            "first_aired" => first_aired,
            "overview" => overview
           } = body
          %Show{show | display: %ShowDisplay{
            title: title,
            artwork: artwork,
            first_aired: first_aired,
            overview: overview
          }}
    end
  end

  @spec get_content(struct, module, module) :: struct
  defp  get_content(show, url \\ @url, requester \\ @requester) do
    url.show_content(show.id)
    |> requester.get
    |> case do
        {:ok, body} ->
          web_sources = body["results"]["web"]["episodes"]["all_sources"]
          %Show{show | content: web_sources}
    end
  end

  @spec get_seasons(struct, module, module) :: struct
  defp  get_seasons(show, url \\ @url, requester \\ @request) do
    url.seasons(show.id)
    |> requester.get
    |> case do
        {:ok, body} ->
          seasons =
            body["results"]
            |> Enum.map(fn s -> s["season_number"] end)
          %Show{show | seasons: seasons}
     end
  end
end
