defmodule IdkWeb.DashboardController do
  use IdkWeb, :controller
  alias Idk.{Repo, User}

    # The index page for the dashboard
    def index(conn, _params) do
      user = Repo.get(User, conn.assigns[:user_id])
      render(conn, "index.html", user: user)
    end
end
