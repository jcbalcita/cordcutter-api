defmodule CordcutterApi.Router do
  use CordcutterApi.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CordcutterApi do
    pipe_through :api

    get "/movie/", MovieController, :search
    get "/movie/:id", MovieController, :detail
    get "/show/", ShowController, :search
    get "/show/:id", ShowController, :detail
  end

  # Other scopes may use custom stacks.
  # scope "/api", CordcutterApi do
  #   pipe_through :api
  # end
end
