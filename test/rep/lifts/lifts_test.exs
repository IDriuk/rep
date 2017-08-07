defmodule Rep.LiftsTest do
  use Rep.DataCase

  alias Rep.Lifts

  describe "addresses" do
    alias Rep.Lifts.Address

    @valid_attrs %{entrance: "some entrance", house: "some house", street: "some street"}
    @update_attrs %{entrance: "some updated entrance", house: "some updated house", street: "some updated street"}
    @invalid_attrs %{entrance: nil, house: nil, street: nil}

    def address_fixture(attrs \\ %{}) do
      {:ok, address} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Lifts.create_address()

      address
    end

    test "list_addresses/0 returns all addresses" do
      address = address_fixture()
      assert Lifts.list_addresses() == [address]
    end

    test "get_address!/1 returns the address with given id" do
      address = address_fixture()
      assert Lifts.get_address!(address.id) == address
    end

    test "create_address/1 with valid data creates a address" do
      assert {:ok, %Address{} = address} = Lifts.create_address(@valid_attrs)
      assert address.entrance == "some entrance"
      assert address.house == "some house"
      assert address.street == "some street"
    end

    test "create_address/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Lifts.create_address(@invalid_attrs)
    end

    test "update_address/2 with valid data updates the address" do
      address = address_fixture()
      assert {:ok, address} = Lifts.update_address(address, @update_attrs)
      assert %Address{} = address
      assert address.entrance == "some updated entrance"
      assert address.house == "some updated house"
      assert address.street == "some updated street"
    end

    test "update_address/2 with invalid data returns error changeset" do
      address = address_fixture()
      assert {:error, %Ecto.Changeset{}} = Lifts.update_address(address, @invalid_attrs)
      assert address == Lifts.get_address!(address.id)
    end

    test "delete_address/1 deletes the address" do
      address = address_fixture()
      assert {:ok, %Address{}} = Lifts.delete_address(address)
      assert_raise Ecto.NoResultsError, fn -> Lifts.get_address!(address.id) end
    end

    test "change_address/1 returns a address changeset" do
      address = address_fixture()
      assert %Ecto.Changeset{} = Lifts.change_address(address)
    end
  end
end
