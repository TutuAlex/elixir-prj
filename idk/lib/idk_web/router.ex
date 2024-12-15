defmodule IdkWeb.Router do
#  import IdkWeb.Plugs.AuthenticateUser
  use IdkWeb, :router



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

  scope "/", IdkWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/about", PageController, :about
    get "/about/:input", PageController, :about

    get "/signup", UserController, :new
    post "/signup", UserController, :create

    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete
  end

  scope "/", IdkWeb do
    pipe_through [:browser, IdkWeb.Plugs.AuthenticateUser]  # Ensure user is logged in

    get "/dashboard", DashboardController, :index  # Dashboard route (protected)
  end


  # Other scopes may use custom stacks.
  # scope "/api", IdkWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: IdkWeb.Telemetry
    end
  end
end
