defmodule RepWeb.BreakController do
  use RepWeb, :controller

  alias Rep.Lifts
  alias Rep.Lifts.Break

  def stops(conn, _params) do
    breaks = Lifts.list_breaks(:stops)
    render(conn, "stops.html", breaks: breaks)
  end

  def incomplete(conn, _params) do
    breaks = Lifts.list_breaks(:incomplete)
    render(conn, "incomplete.html", breaks: breaks)
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
      {:ok, break} ->
        conn
        |> put_flash(:info, "Break created successfully.")
        |> redirect(to: address_break_path(conn, :show, address_id, break))
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
      {:ok, break} ->
        conn
        |> put_flash(:info, "Break updated successfully.")
        |> redirect(to: address_break_path(conn, :show, address.id, break))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", address: address, break: break, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "address_id" => address_id}) do
    address = Lifts.get_address!(address_id)
    break = Lifts.get_break!(id)
    {:ok, _break} = Lifts.delete_break(break)

    conn
    |> put_flash(:info, "Break deleted successfully.")
    |> redirect(to: address_break_path(conn, :index, address))
  end
end
