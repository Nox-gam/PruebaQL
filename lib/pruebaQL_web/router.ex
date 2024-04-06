defmodule PruebaQLWeb.Router do
  use PruebaQLWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end


  scope "/api" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: PruebaQLWeb.Schema,
      socket: PruebaQLWeb.UserSocket

    forward "/", Absinthe.Plug,
      schema: PruebaQLWeb.Schema
  end
end
