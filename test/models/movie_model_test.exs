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

  
end
