defmodule PhxRtcWeb.PageController do
  use PhxRtcWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
