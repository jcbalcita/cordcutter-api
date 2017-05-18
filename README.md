# Cordcutter API

Simple API endpoint for Cordcutter Search. 

Hosted at www.cordcutter.io

Not really for public consumption as the responses to the API calls are narrowly tailored to my extension's needs, but here are the routes nevertheless.

```
scope "/api", CordcutterApi do
  pipe_through :api

  # use param `search_string` for searches

  get "/movies/", MovieController, :search 
  get "/movies/:id", MovieController, :detail

  get "/shows/", ShowController, :search
  get "/shows/:id", ShowController, :detail
  get "/shows/:id/season/:season_id", ShowController, :season
end
```
