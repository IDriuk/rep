defmodule RepWeb.ComplectationController do
  use RepWeb, :controller

  alias Rep.Lifts
  alias Rep.Lifts.Complectation

  def index(conn, %{"address_id" => address_id}) do
    address = Lifts.get_address!(address_id)
    complectations = Lifts.list_complectations(address)
    render(conn, "index.html", address: address, complectations: complectations)
  end

  def new(conn, %{"address_id" => address_id}) do
    address = Lifts.get_address!(address_id)
    changeset = Lifts.change_complectation(%Complectation{})
    render(conn, "new.html", address: address, changeset: changeset)
  end

  def create(conn, %{"complectation" => complectation_params, "address_id" => address_id}) do
    address = Lifts.get_address!(address_id)
    case Lifts.create_complectation(address, complectation_params) do
      {:ok, complectation} ->
        conn
        |> put_flash(:info, "Complectation created successfully.")
        |> redirect(to: address_path(conn, :show, address_id))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", address: address, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id, "address_id" => address_id}) do
    address = Lifts.get_address!(address_id)
    complectation = Lifts.get_complectation!(id)
    render(conn, "show.html", address: address, complectation: complectation)
  end

  def edit(conn, %{"id" => id, "address_id" => address_id}) do
    address = Lifts.get_address!(address_id)
    complectation = Lifts.get_complectation!(id)
    changeset = Lifts.change_complectation(complectation)
    render(conn, "edit.html", address: address, complectation: complectation, changeset: changeset)
  end

  def update(conn, %{"id" => id, "complectation" => complectation_params, "address_id" => address_id}) do
    address = Lifts.get_address!(address_id)
    complectation = Lifts.get_complectation!(id)

    case Lifts.update_complectation(complectation, complectation_params) do
      {:ok, complectation} ->
        conn
        |> put_flash(:info, "Complectation updated successfully.")
        |> redirect(to: address_path(conn, :show, address))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", address: address, complectation: complectation, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "address_id" => address_id}) do
    address = Lifts.get_address!(address_id)
    complectation = Lifts.get_complectation!(id)
    {:ok, _complectation} = Lifts.delete_complectation(complectation)

    conn
    |> put_flash(:info, "Complectation deleted successfully.")
    |> redirect(to: address_path(conn, :show, address))
  end
end
