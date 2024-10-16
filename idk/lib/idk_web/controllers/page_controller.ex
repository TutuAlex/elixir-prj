defmodule IdkWeb.PageController do
  use IdkWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
