defmodule RepWeb.OrderController do
  use RepWeb, :controller

  alias Rep.Lifts
  alias Rep.Lifts.Order

  plug :require_existing_mechanic
  plug :authorize_order when action in [:edit, :update, :delete]

  defp require_existing_mechanic(conn, _) do
    mechanic = Lifts.ensure_mechanic_exists(conn.assigns.current_user)
    assign(conn, :current_mechanic, mechanic)
  end

  defp authorize_order(conn, _) do
    address = Lifts.get_address!(conn.params["address_id"])
    order = Lifts.get_order!(conn.params["id"])

    if conn.assigns.current_mechanic.id == address.mechanic_id do
      assign(conn, :address, address)
      assign(conn, :order, order)
    else
      conn
      |> put_flash(:error, "You can't modify that order")
      |> redirect(to: address_path(conn, :index))
      |> halt()
    end
  end

  def recent_orders(conn, params) do
    case params do
      %{"offset" => offset} ->
        offset = String.to_integer(offset)
        orders = Lifts.list_orders(:recent_orders, conn.assigns.current_mechanic, offset)
        render(conn, "recent_orders.html", orders: orders, offset: offset)
      _ ->
        orders = Lifts.list_orders(:recent_orders, conn.assigns.current_mechanic)
        render(conn, "recent_orders.html", orders: orders, offset: 0)
    end
  end

  def index(conn, %{"address_id" => address_id}) do
    address = Lifts.get_address!(address_id)
    orders = Lifts.list_orders(address)
    render(conn, "index.html", address: address, orders: orders)
  end

  def new(conn, %{"address_id" => address_id}) do
    address = Lifts.get_address!(address_id)
    changeset = Lifts.change_order(%Order{})
    render(conn, "new.html", address: address, changeset: changeset)
  end

  def create(conn, %{"order" => order_params, "address_id" => address_id}) do
    address = Lifts.get_address!(address_id)
    case Lifts.create_order(address, order_params) do
      {:ok, _order} ->
        conn
        |> put_flash(:info, gettext("order created successfully."))
        |> redirect(to: address_path(conn, :show, address_id))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", address: address, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id, "address_id" => address_id}) do
    address = Lifts.get_address!(address_id)
    order = Lifts.get_order!(id)
    render(conn, "show.html", address: address, order: order)
  end

  def edit(conn, %{"id" => id, "address_id" => address_id}) do
    address = Lifts.get_address!(address_id)
    order = Lifts.get_order!(id)
    changeset = Lifts.change_order(order)
    render(conn, "edit.html", address: address, order: order, changeset: changeset)
  end

  def update(conn, %{"id" => id, "order" => order_params, "address_id" => address_id}) do
    address = Lifts.get_address!(address_id)
    order = Lifts.get_order!(id)

    case Lifts.update_order(order, order_params) do
      {:ok, _order} ->
        conn
        |> put_flash(:info, gettext("order updated successfully."))
        |> redirect(to: address_path(conn, :show, address))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", address: address, order: order, changeset: changeset)
    end
  end
  def delete(conn, %{"id" => id, "address_id" => address_id}) do
    address = Lifts.get_address!(address_id)
    order = Lifts.get_order!(id)
    {:ok, _order} = Lifts.delete_order(order)

    conn
    |> put_flash(:info, gettext("order deleted successfully."))
    |> redirect(to: address_path(conn, :show, address))
  end
end
