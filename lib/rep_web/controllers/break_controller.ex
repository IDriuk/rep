defmodule RepWeb.BreakController do
  use RepWeb, :controller

  alias Rep.Lifts
  alias Rep.Lifts.Break

  def index(conn, _params) do
    breaks = Lifts.list_breaks()
    render(conn, "index.html", breaks: breaks)
  end

  def new(conn, _params) do
    changeset = Lifts.change_break(%Break{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"break" => break_params}) do
    case Lifts.create_break(break_params) do
      {:ok, break} ->
        conn
        |> put_flash(:info, "Break created successfully.")
        |> redirect(to: address_break_path(conn, :show, 0, break))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    break = Lifts.get_break!(id)
    render(conn, "show.html", break: break)
  end

  def edit(conn, %{"id" => id}) do
    break = Lifts.get_break!(id)
    changeset = Lifts.change_break(break)
    render(conn, "edit.html", break: break, changeset: changeset)
  end

  def update(conn, %{"id" => id, "break" => break_params}) do
    break = Lifts.get_break!(id)

    case Lifts.update_break(break, break_params) do
      {:ok, break} ->
        conn
        |> put_flash(:info, "Break updated successfully.")
        |> redirect(to: address_break_path(conn, :show, 0, break))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", break: break, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    break = Lifts.get_break!(id)
    {:ok, _break} = Lifts.delete_break(break)

    conn
    |> put_flash(:info, "Break deleted successfully.")
    |> redirect(to: address_break_path(conn, :index, 0))
  end
end
