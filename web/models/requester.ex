defmodule CordcutterApi.Requester do

  def get(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> decode(body)
    end
  end

defp decode(body): Poison.decode(body)

end
