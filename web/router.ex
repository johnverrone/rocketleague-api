defmodule RocketleaguePhoenix.Router do
  use RocketleaguePhoenix.Web, :router

  pipeline :api do
    plug :accepts, ["json-api"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  pipeline :api_auth do
    plug :accepts, ["json-api"]
    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.LoadResource
  end

  scope "/api", RocketleaguePhoenix do
    pipe_through :api

    post "/register", RegistrationController, :create
    post "/token", SessionController, :create, as: :login

    resources "/matches", MatchController, except: [:new, :edit]
    resources "/players", PlayerController, except: [:new, :edit]
    resources "/session", SessionController, only: [:index]
    resources "/teams", TeamController, except: [:new, :edit]
  end

  scope "/api", RocketleaguePhoenix do
    pipe_through :api_auth

    get "/user/current", UserController, :current
  end
end
