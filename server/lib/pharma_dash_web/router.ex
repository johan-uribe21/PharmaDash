defmodule PharmaDashWeb.Router do
  use PharmaDashWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", PharmaDashWeb do
    pipe_through(:api)
    resources("/users", UserController, except: [:new, :edit])
  end
end
