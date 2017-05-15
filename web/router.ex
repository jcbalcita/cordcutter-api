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

    get "/movies/", MovieController, :search
    get "/movies/:id", MovieController, :detail

    get "/shows/", ShowController, :search
    get "/shows/:id", ShowController, :detail
    get "/shows/:id/season/:season_id", ShowController, :season
  end
end
