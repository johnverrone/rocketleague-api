defmodule RocketleaguePhoenix.Router do
  use RocketleaguePhoenix.Web, :router

  pipeline :api do
    plug :accepts, ["json", "json-api"]
  end

  pipeline :api_auth do
    plug :accepts, ["json-api"]
    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.LoadResource
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  scope "/api", RocketleaguePhoenix do
    pipe_through :api

    post "/register", RegistrationController, :create
    post "/token", SessionController, :create, as: :login

  end

  scope "/api", RocketleaguePhoenix do
    pipe_through :api_auth

    get "/user/current", UserController, :current
    resources "/matches", MatchController, except: [:new, :edit]
    resources "/players", PlayerController, except: [:new, :edit]
    resources "/session", SessionController, only: [:index]
    resources "/teams", TeamController, except: [:new, :edit]
  end
end
