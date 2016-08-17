defmodule RocketleaguePhoenix.Router do
  use RocketleaguePhoenix.Web, :router

  pipeline :api do
    plug :accepts, ["json-api"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  scope "/api", RocketleaguePhoenix do
    pipe_through :api

    resources "/players", PlayerController, except: [:new, :edit]
    resources "/teams", TeamController, except: [:new, :edit]
    resources "/matches", MatchController, except: [:new, :edit]
  end
end
