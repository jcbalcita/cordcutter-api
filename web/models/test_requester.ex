defmodule CordcutterApi.StubRequester do
  use CordcutterApi.Web, :model

  def get(search_string) do
    map = %{"results" => search_string}
    {:ok, map}
  end
end
