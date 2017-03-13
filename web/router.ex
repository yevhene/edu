defmodule Edu.Router do
  use Edu.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug Edu.Plugs.Authenticate
  end

  #@crud [:index, :show, :create, :update, :delete]

  scope "/auth", Edu.Auth, as: :auth do
    scope "/" do
      pipe_through :api

      resources "/session", SessionController,
        only: [:create], singleton: true
      resources "/registration", RegistrationController,
        only: [:create], singleton: true
    end

    scope "/" do
      pipe_through [:api, :auth]

      resources "/session", SessionController,
        only: [:show, :delete], singleton: true
      resources "/registration", RegistrationController,
        only: [:show, :update, :delete], singleton: true
    end
  end

  #scope "/", Edu do
  #  pipe_through [:api, :auth]
  #end
end
