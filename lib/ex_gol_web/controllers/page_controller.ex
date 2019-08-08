defmodule ExGolWeb.PageController do
  use ExGolWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
