defmodule CordcutterApi.StubRequester do
  use CordcutterApi.Web, :model

  def get(search_string) do
    map = %{"results" => search_string}
    {:ok, map}
  end
end

defmodule CordcutterApi.FakeRequester do
  def get(id) do
    poster_240x342 = "poster.jpg"
    title = "Cool Runnings"
    release_year = "2017"
    overview = "Cool Runnings is awesome."
    free_web_sources = 1
    subscription_web_sources = 2
    tv_everywhere_web_sources = 3
    purchase_web_sources = 4

    body = %{
      "poster_240x342" => poster_240x342, "title" => title, "release_year" => release_year,
      "overview" => overview, "free_web_sources" => free_web_sources,
      "subscription_web_sources" => subscription_web_sources,
      "tv_everywhere_web_sources" => tv_everywhere_web_sources,
      "purchase_web_sources" => purchase_web_sources
    }

    {:ok, body}
  end
end
