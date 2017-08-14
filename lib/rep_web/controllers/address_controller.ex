defmodule RepWeb.AddressController do
  use RepWeb, :controller

  alias Rep.Lifts
  alias Rep.Lifts.Address

  plug :require_existing_mechanic
  plug :authorize_address when action in [:edit, :update, :delete]

  defp require_existing_mechanic(conn, _) do
    mechanic = Lifts.ensure_mechanic_exists(conn.assigns.current_user)
    assign(conn, :current_mechanic, mechanic)
  end

  defp authorize_address(conn, _) do
    address = Lifts.get_address!(conn.params["id"])

    if conn.assigns.current_mechanic.id == address.mechanic_id do
      assign(conn, :address, address)
    else
      conn
      |> put_flash(:error, "You can't modify that address")
      |> redirect(to: address_path(conn, :index))
      |> halt()
    end
  end

  def index(conn, _params) do
    addresses = Lifts.list_addresses(conn.assigns.current_mechanic)
    render(conn, "index.html", addresses: addresses)
  end

  def new(conn, _params) do
    changeset = Lifts.change_address(%Address{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"address" => address_params}) do
    case Lifts.create_address(conn.assigns.current_mechanic, address_params) do
      {:ok, address} ->
        conn
        |> put_flash(:info, "Address created successfully.")
        |> redirect(to: address_path(conn, :show, address))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    address = Lifts.get_address!(id)
    render(conn, "show.html", address: address)
  end

  def edit(conn, %{"id" => id}) do
    address = Lifts.get_address!(id)
    changeset = Lifts.change_address(address)
    render(conn, "edit.html", address: address, changeset: changeset)
  end

  def update(conn, %{"address" => address_params}) do
    case Lifts.update_address(conn.assigns.address, address_params) do
      {:ok, address} ->
        conn
        |> put_flash(:info, "Address updated successfully.")
        |> redirect(to: address_path(conn, :show, address))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end

  def delete(conn, _) do
    {:ok, _address} = Lifts.delete_address(conn.assigns.address)

    conn
    |> put_flash(:info, "Address deleted successfully.")
    |> redirect(to: address_path(conn, :index))
  end

end
