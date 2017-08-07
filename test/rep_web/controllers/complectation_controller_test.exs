defmodule RepWeb.ComplectationControllerTest do
  use RepWeb.ConnCase

  alias Rep.Lifts

  @create_attrs %{doors: "some doors", floors: 42, notes: "some notes", station: "some station", underfloor: true}
  @update_attrs %{doors: "some updated doors", floors: 43, notes: "some updated notes", station: "some updated station", underfloor: false}
  @invalid_attrs %{doors: nil, floors: nil, notes: nil, station: nil, underfloor: nil}

  def fixture(:complectation) do
    {:ok, complectation} = Lifts.create_complectation(@create_attrs)
    complectation
  end

  describe "index" do
    test "lists all complectations", %{conn: conn} do
      conn = get conn, complectation_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Complectations"
    end
  end

  describe "new complectation" do
    test "renders form", %{conn: conn} do
      conn = get conn, complectation_path(conn, :new)
      assert html_response(conn, 200) =~ "New Complectation"
    end
  end

  describe "create complectation" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, complectation_path(conn, :create), complectation: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == complectation_path(conn, :show, id)

      conn = get conn, complectation_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Complectation"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, complectation_path(conn, :create), complectation: @invalid_attrs
      assert html_response(conn, 200) =~ "New Complectation"
    end
  end

  describe "edit complectation" do
    setup [:create_complectation]

    test "renders form for editing chosen complectation", %{conn: conn, complectation: complectation} do
      conn = get conn, complectation_path(conn, :edit, complectation)
      assert html_response(conn, 200) =~ "Edit Complectation"
    end
  end

  describe "update complectation" do
    setup [:create_complectation]

    test "redirects when data is valid", %{conn: conn, complectation: complectation} do
      conn = put conn, complectation_path(conn, :update, complectation), complectation: @update_attrs
      assert redirected_to(conn) == complectation_path(conn, :show, complectation)

      conn = get conn, complectation_path(conn, :show, complectation)
      assert html_response(conn, 200) =~ "some updated doors"
    end

    test "renders errors when data is invalid", %{conn: conn, complectation: complectation} do
      conn = put conn, complectation_path(conn, :update, complectation), complectation: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Complectation"
    end
  end

  describe "delete complectation" do
    setup [:create_complectation]

    test "deletes chosen complectation", %{conn: conn, complectation: complectation} do
      conn = delete conn, complectation_path(conn, :delete, complectation)
      assert redirected_to(conn) == complectation_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, complectation_path(conn, :show, complectation)
      end
    end
  end

  defp create_complectation(_) do
    complectation = fixture(:complectation)
    {:ok, complectation: complectation}
  end
end
