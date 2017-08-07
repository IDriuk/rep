defmodule RepWeb.BreakControllerTest do
  use RepWeb.ConnCase

  alias Rep.Lifts

  @create_attrs %{fixed: true, notes: "some notes", served: ~D[2010-04-17], started: true, stoped: true}
  @update_attrs %{fixed: false, notes: "some updated notes", served: ~D[2011-05-18], started: false, stoped: false}
  @invalid_attrs %{fixed: nil, notes: nil, served: nil, started: nil, stoped: nil}

  def fixture(:break) do
    {:ok, break} = Lifts.create_break(@create_attrs)
    break
  end

  describe "index" do
    test "lists all breaks", %{conn: conn} do
      conn = get conn, break_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Breaks"
    end
  end

  describe "new break" do
    test "renders form", %{conn: conn} do
      conn = get conn, break_path(conn, :new)
      assert html_response(conn, 200) =~ "New Break"
    end
  end

  describe "create break" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, break_path(conn, :create), break: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == break_path(conn, :show, id)

      conn = get conn, break_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Break"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, break_path(conn, :create), break: @invalid_attrs
      assert html_response(conn, 200) =~ "New Break"
    end
  end

  describe "edit break" do
    setup [:create_break]

    test "renders form for editing chosen break", %{conn: conn, break: break} do
      conn = get conn, break_path(conn, :edit, break)
      assert html_response(conn, 200) =~ "Edit Break"
    end
  end

  describe "update break" do
    setup [:create_break]

    test "redirects when data is valid", %{conn: conn, break: break} do
      conn = put conn, break_path(conn, :update, break), break: @update_attrs
      assert redirected_to(conn) == break_path(conn, :show, break)

      conn = get conn, break_path(conn, :show, break)
      assert html_response(conn, 200) =~ "some updated notes"
    end

    test "renders errors when data is invalid", %{conn: conn, break: break} do
      conn = put conn, break_path(conn, :update, break), break: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Break"
    end
  end

  describe "delete break" do
    setup [:create_break]

    test "deletes chosen break", %{conn: conn, break: break} do
      conn = delete conn, break_path(conn, :delete, break)
      assert redirected_to(conn) == break_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, break_path(conn, :show, break)
      end
    end
  end

  defp create_break(_) do
    break = fixture(:break)
    {:ok, break: break}
  end
end
