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

  pipeline :maybe_browser_auth do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  pipeline :ensure_authed_access do
    plug Guardian.Plug.EnsureAuthenticated, %{"typ" => "access", handler: RepWeb.HttpErrorHandler}
  end

  scope "/", RepWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete],
                                              singleton: true
  end

  scope "/addresses", RepWeb do
    pipe_through [:browser, :maybe_browser_auth, :ensure_authed_access]

    get "/stops", BreakController, :stops
    get "/incomplete", BreakController, :incomplete

    resources "/", AddressController do
      resources "/complectations", ComplectationController
      resources "/breaks", BreakController
    end

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

  # Other scopes may use custom stacks.
  # scope "/api", RepWeb do
  #   pipe_through :api
  # end
end
