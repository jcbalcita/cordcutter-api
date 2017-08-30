defmodule CordcutterApi.StubUrl do
  use CordcutterApi.Web, :model

  def movie_search(search_string) do
    search_string
  end

  def movie(id) do
    Integer.to_string(id)
  end
end
