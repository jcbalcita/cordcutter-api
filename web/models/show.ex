defmodule CordcutterApi.Show do
  use CordcutterApi.Web, :model

  alias CordcutterApi.Show
  alias CordcutterApi.Url

  defstruct [id: nil, display: nil, content: nil, seasons: nil]

  defmodule Display do
    defstruct [:title, :artwork, :first_aired, :overview]
  end

  def search(search_string) do
    Url.search_show(search_string)
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

  def get_display(show) do
    Url.show(show.id)
    |> HTTPoison.get
    |> case do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        case Poison.decode(body) do
          {:ok, body} ->
            %{
              "title" => title,
              "artwork_304x171" => artwork,
              "first_aired" => first_aired,
              "overview" => overview
             } = body
            %Show{show | display: %Display{
              title: title,
              artwork: artwork,
              first_aired: first_aired,
              overview: overview
            }}
      end
    end
  end

  def get_content(show) do
    Url.show_content(show.id)
    |> HTTPoison.get
    |> case do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        case Poison.decode(body) do
          {:ok, body} ->
            web_sources = body["results"]["web"]["episodes"]["all_sources"]
            %Show{show | content: web_sources}
        end
     end
  end

  def get_seasons(show) do
    Url.seasons(show.id)
    |> HTTPoison.get
    |> case do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        case Poison.decode(body) do
          {:ok, body} ->
            seasons =
              body["results"]
              |> Enum.map(fn s -> s["season_number"] end)
            %Show{show | seasons: seasons}
        end
     end
  end

  def get_detail(id) do
    %Show{id: id}
    |> get_display
    |> get_content
    |> get_seasons
  end

  def get_season_detail(id, season_id) do
    Url.season_detail(id, season_id)
    |> HTTPoison.get
    |> case do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          IO.inspect("PRETTY FAR")
          case Poison.decode(body) do
            {:ok, body} -> body["results"]
          end
    end
  end
end
