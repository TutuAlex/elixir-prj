defmodule IdkWeb.UserController do
  use IdkWeb, :controller
  alias Idk.Repo
  alias Idk.User


  def new(conn, _params) do
    conn
    |>assign(:changeset, User.changeset(%User{}, %{})) #with assign we can pass stuff in the eex.html. we pass in an empty changeset for resistration.
    |>render(:signup)
  end

  #Phoenix generates the form fields nested under the key of the changeset module name (user in this case).
  #By default, the changeset name (User) gets converted to a lowercase key (user).
  #this is why we match with the keyword 'user'
  def create(conn, %{"user" => user_params}) do
   changeset =  User.changeset(%User{}, user_params)

   case Repo.insert(changeset) do
     {:ok, _user} -> conn
      |> put_flash(:info, "User created!")
      |> redirect(to: "/")
     {:error, changeset} -> conn
      |> put_flash(:error, "User failed!")
      |> render("signup.html", changeset: changeset)
   end
  end

end
