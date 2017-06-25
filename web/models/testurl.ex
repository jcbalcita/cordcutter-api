defmodule CordcutterApi.StubUrl do
  use CordcutterApi.Web, :model

  def search_movie(search_string) do
    search_string
  end
end
