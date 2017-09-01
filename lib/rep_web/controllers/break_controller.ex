defmodule RepWeb.BreakController do
  use RepWeb, :controller

  alias Rep.Lifts
  alias Rep.Lifts.Break

  plug :require_existing_mechanic
  plug :authorize_break when action in [:edit, :update, :delete]

  defp require_existing_mechanic(conn, _) do
    mechanic = Lifts.ensure_mechanic_exists(conn.assigns.current_user)
    assign(conn, :current_mechanic, mechanic)
  end

  defp authorize_break(conn, _) do
    address = Lifts.get_address!(conn.params["address_id"])
    break = Lifts.get_break!(conn.params["id"])

    if conn.assigns.current_mechanic.id == address.mechanic_id do
      assign(conn, :address, address)
      assign(conn, :break, break)
    else
      conn
      |> put_flash(:error, "You can't modify that break")
      |> redirect(to: address_path(conn, :index))
      |> halt()
    end
  end

  def stops(conn, params) do
    case params do
      %{"offset" => offset} ->
        offset = String.to_integer(offset)
        breaks = Lifts.list_breaks(:stops, conn.assigns.current_mechanic, offset)
        render(conn, "stops.html", breaks: breaks, offset: offset)
      _ ->
        breaks = Lifts.list_breaks(:stops, conn.assigns.current_mechanic)
        render(conn, "stops.html", breaks: breaks, offset: 0)
    end
  end

  def incomplete(conn, params) do
    case params do
      %{"offset" => offset} ->
        offset = String.to_integer(offset)
        breaks = Lifts.list_breaks(:incomplete, conn.assigns.current_mechanic, offset)
        render(conn, "incomplete.html", breaks: breaks, offset: offset)
      _ ->
        breaks = Lifts.list_breaks(:incomplete, conn.assigns.current_mechanic)
        render(conn, "incomplete.html", breaks: breaks, offset: 0)
    end
  end

  def index(conn, %{"address_id" => address_id}) do
    address = Lifts.get_address!(address_id)
    breaks = Lifts.list_breaks(address)
    render(conn, "index.html", address: address, breaks: breaks)
  end

  def new(conn, %{"address_id" => address_id}) do
    address = Lifts.get_address!(address_id)
    changeset = Lifts.change_break(%Break{})
    render(conn, "new.html", address: address, changeset: changeset)
  end

  def create(conn, %{"break" => break_params, "address_id" => address_id}) do
    address = Lifts.get_address!(address_id)
    case Lifts.create_break(address, break_params) do
      {:ok, _break} ->
        conn
        |> put_flash(:info, gettext("Break created successfully."))
        |> redirect(to: address_path(conn, :show, address_id))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", address: address, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id, "address_id" => address_id}) do
    address = Lifts.get_address!(address_id)
    break = Lifts.get_break!(id)
    render(conn, "show.html", address: address, break: break)
  end

  def edit(conn, %{"id" => id, "address_id" => address_id}) do
    address = Lifts.get_address!(address_id)
    break = Lifts.get_break!(id)
    changeset = Lifts.change_break(break)
    render(conn, "edit.html", address: address, break: break, changeset: changeset)
  end

  def update(conn, %{"id" => id, "break" => break_params, "address_id" => address_id}) do
    address = Lifts.get_address!(address_id)
    break = Lifts.get_break!(id)

    case Lifts.update_break(break, break_params) do
      {:ok, _break} ->
        conn
        |> put_flash(:info, gettext("Break updated successfully."))
        |> redirect(to: address_path(conn, :show, address))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", address: address, break: break, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "address_id" => address_id}) do
    address = Lifts.get_address!(address_id)
    break = Lifts.get_break!(id)
    {:ok, _break} = Lifts.delete_break(break)

    conn
    |> put_flash(:info, gettext("Break deleted successfully."))
    |> redirect(to: address_path(conn, :show, address))
  end
end
