defmodule RepWeb.PageController do
  use RepWeb, :controller

  def index(conn, _params) do
    redirect(conn, to: session_path(conn, :new))
  end
end
