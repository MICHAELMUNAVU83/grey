defmodule GreyWeb.PageController do
  use GreyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
