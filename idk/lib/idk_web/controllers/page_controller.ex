defmodule IdkWeb.PageController do
  use IdkWeb, :controller

  def index(conn, _params) do
  #  Repo.insert(%User{email: "user1@example.com"})
  render(conn,"index.html")
  end

  def about(conn, _params) do
    conn
    |>assign(:sth, "sdsdfsdfsdf")
    |>render(:about)
  end




end
