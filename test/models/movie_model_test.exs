defmodule CordcutterApi.MovieModelTest do
  use ExUnit.Case

  alias CordcutterApi.Movie

  test "Movie.search/3 passes search string to depedencies" do
    #given
    passed_string = "boofar"

    #when
    actual = Movie.search(passed_string, CordcutterApi.StubUrl, CordcutterApi.StubRequester)

    #then
    assert actual == {:ok, passed_string}
  end

  test "Movie.get_detail/3 parses JSON response correctly" do
    #given
    poster_240x342 = "poster.jpg"
    title = "Cool Runnings"
    release_year = "2017"
    overview = "Cool Runnings is awesome."
    free_web_sources = 1
    subscription_web_sources = 2
    tv_everywhere_web_sources = 3
    purchase_web_sources = 4

    #when
    actual = Movie.get_detail(6969, CordcutterApi.StubUrl, CordcutterApi.FakeRequester)

    #then
    assert actual.id == 6969
    assert actual.display.poster == poster_240x342
    assert actual.display.title ==  title
    assert actual.display.release_year == release_year
    assert actual.display.overview == overview
    assert actual.sources.free == free_web_sources
    assert actual.sources.subscription == subscription_web_sources
    assert actual.sources.tv_everywhere == tv_everywhere_web_sources
    assert actual.sources.purchase == purchase_web_sources
  end
end
