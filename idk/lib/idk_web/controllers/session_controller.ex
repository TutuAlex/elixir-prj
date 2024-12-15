defmodule IdkWeb.SessionController do
  use IdkWeb, :controller
  alias Idk.{Repo, User}

  def new(conn, _params) do
     render(conn, :login)
  end

  def create(conn, %{"email" => email, "password"=> password}) do
    case (Repo.get_by(User, email: email)) do
        nil -> conn
        |> put_flash(:error, "No user with email " <> email <> ". Try signup?")
        |> redirect(to: "/signup")
        user ->
          if Pbkdf2.verify_pass(password, user.password) do
            conn
            |> put_session(:user_id, user.id)
            |> put_flash(:info, "Logged in successfully")
            |> redirect(to: Routes.dashboard_path(conn, :index))
          else
            conn
            |> put_flash(:error, "Invalid email or password")
            |> render("login.html")
          end
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out successfully. ")
    |> clear_session()
    |> redirect(to: "/login")
  end
end
