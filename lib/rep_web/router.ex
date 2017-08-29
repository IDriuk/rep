defmodule RepWeb.Router do
  use RepWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RepWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/sessions", SessionController, only: [:new, :create, :delete],
                                              singleton: true
  end

  scope "/addresses", RepWeb do
    pipe_through [:browser, :authenticate_user]

    get "/stops", BreakController, :stops
    get "/incomplete", BreakController, :incomplete

    resources "/", AddressController do
      resources "/complectations", ComplectationController
      resources "/breaks", BreakController
    end

  end

  scope "/admin", RepWeb, as: :admin do
    pipe_through [:browser, :authenticate_user, :authenticate_admin]

    resources "/users", UserController
  end

  scope "/cms", RepWeb.CMS, as: :cms do
    pipe_through [:browser, :authenticate_user]

    resources "/pages", PageController
  end

  defp authenticate_user(conn, _) do
    case get_session(conn, :user_id) do
      nil ->
        conn
        |> Phoenix.Controller.put_flash(:error, gettext("Login required"))
        |> Phoenix.Controller.redirect(to: "/")
        |> halt()
      user_id ->
        assign(conn, :current_user, Rep.Accounts.get_user!(user_id))
    end
  end

  defp authenticate_admin(conn, _) do
    case conn.assigns.current_user.credential.is_admin do
      false ->
        conn
        |> Phoenix.Controller.put_flash(:error, gettext("Admin required"))
        |> Phoenix.Controller.redirect(to: "/")
        |> halt()
      true -> conn
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", RepWeb do
  #   pipe_through :api
  # end
end
