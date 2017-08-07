defmodule RepWeb.ComplectationController do
  use RepWeb, :controller

  alias Rep.Lifts
  alias Rep.Lifts.Complectation

  def index(conn, _params) do
    complectations = Lifts.list_complectations()
    render(conn, "index.html", complectations: complectations)
  end

  def new(conn, _params) do
    changeset = Lifts.change_complectation(%Complectation{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"complectation" => complectation_params}) do
    case Lifts.create_complectation(complectation_params) do
      {:ok, complectation} ->
        conn
        |> put_flash(:info, "Complectation created successfully.")
        |> redirect(to: complectation_path(conn, :show, complectation))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    complectation = Lifts.get_complectation!(id)
    render(conn, "show.html", complectation: complectation)
  end

  def edit(conn, %{"id" => id}) do
    complectation = Lifts.get_complectation!(id)
    changeset = Lifts.change_complectation(complectation)
    render(conn, "edit.html", complectation: complectation, changeset: changeset)
  end

  def update(conn, %{"id" => id, "complectation" => complectation_params}) do
    complectation = Lifts.get_complectation!(id)

    case Lifts.update_complectation(complectation, complectation_params) do
      {:ok, complectation} ->
        conn
        |> put_flash(:info, "Complectation updated successfully.")
        |> redirect(to: complectation_path(conn, :show, complectation))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", complectation: complectation, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    complectation = Lifts.get_complectation!(id)
    {:ok, _complectation} = Lifts.delete_complectation(complectation)

    conn
    |> put_flash(:info, "Complectation deleted successfully.")
    |> redirect(to: complectation_path(conn, :index))
  end
end
