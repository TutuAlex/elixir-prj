defmodule IdkWeb.Plugs.AuthenticateUser do
  import Plug.Conn
  import Phoenix.Controller

  alias IdkWeb.Router.Helpers, as: Routes

  def init(default), do: default

  def call(conn, _opts) do
    case get_session(conn, :user_id) do
      nil ->
        conn
        |> put_flash(:error, "You must log in to access the dashboard.")
        |> redirect(to: Routes.session_path(conn, :new))
        |> halt()

      user_id ->
        assign(conn, :user_id, user_id) #add the user id to the connection and use it everywhere else to idk fetch the user wherever
    end
  end
end
