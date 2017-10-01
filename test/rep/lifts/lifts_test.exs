defmodule Rep.LiftsTest do
  use Rep.DataCase

  alias Rep.Lifts

  describe "orders" do
    alias Rep.Lifts.Order

    @valid_attrs %{ordered: "some ordered", received: "some received", sended: ~D[2010-04-17], used: "some used"}
    @update_attrs %{ordered: "some updated ordered", received: "some updated received", sended: ~D[2011-05-18], used: "some updated used"}
    @invalid_attrs %{ordered: nil, received: nil, sended: nil, used: nil}

    def order_fixture(attrs \\ %{}) do
      {:ok, order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Lifts.create_order()

      order
    end

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Lifts.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Lifts.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      assert {:ok, %Order{} = order} = Lifts.create_order(@valid_attrs)
      assert order.ordered == "some ordered"
      assert order.received == "some received"
      assert order.sended == ~D[2010-04-17]
      assert order.used == "some used"
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Lifts.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      assert {:ok, order} = Lifts.update_order(order, @update_attrs)
      assert %Order{} = order
      assert order.ordered == "some updated ordered"
      assert order.received == "some updated received"
      assert order.sended == ~D[2011-05-18]
      assert order.used == "some updated used"
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Lifts.update_order(order, @invalid_attrs)
      assert order == Lifts.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Lifts.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Lifts.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Lifts.change_order(order)
    end
  end
end
