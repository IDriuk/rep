defmodule RepWeb.AddressController do
  use RepWeb, :controller
  use Guardian.Phoenix.Controller

  alias Rep.Lifts
  alias Rep.Lifts.Address

  def index(conn, _params, user, _claims) do
    mechanic = Lifts.ensure_mechanic_exists(user)
    addresses = Lifts.list_addresses(mechanic)
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
    breaks = Lifts.list_breaks(address)
    complectations = Lifts.list_complectations(address)
    render(conn, "show.html", address: address, breaks: breaks, complectations: complectations)
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
