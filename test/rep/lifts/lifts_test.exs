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

  describe "complectations" do
    alias Rep.Lifts.Complectation

    @valid_attrs %{doors: "some doors", floors: 42, notes: "some notes", station: "some station", underfloor: true}
    @update_attrs %{doors: "some updated doors", floors: 43, notes: "some updated notes", station: "some updated station", underfloor: false}
    @invalid_attrs %{doors: nil, floors: nil, notes: nil, station: nil, underfloor: nil}

    def complectation_fixture(attrs \\ %{}) do
      {:ok, complectation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Lifts.create_complectation()

      complectation
    end

    test "list_complectations/0 returns all complectations" do
      complectation = complectation_fixture()
      assert Lifts.list_complectations() == [complectation]
    end

    test "get_complectation!/1 returns the complectation with given id" do
      complectation = complectation_fixture()
      assert Lifts.get_complectation!(complectation.id) == complectation
    end

    test "create_complectation/1 with valid data creates a complectation" do
      assert {:ok, %Complectation{} = complectation} = Lifts.create_complectation(@valid_attrs)
      assert complectation.doors == "some doors"
      assert complectation.floors == 42
      assert complectation.notes == "some notes"
      assert complectation.station == "some station"
      assert complectation.underfloor == true
    end

    test "create_complectation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Lifts.create_complectation(@invalid_attrs)
    end

    test "update_complectation/2 with valid data updates the complectation" do
      complectation = complectation_fixture()
      assert {:ok, complectation} = Lifts.update_complectation(complectation, @update_attrs)
      assert %Complectation{} = complectation
      assert complectation.doors == "some updated doors"
      assert complectation.floors == 43
      assert complectation.notes == "some updated notes"
      assert complectation.station == "some updated station"
      assert complectation.underfloor == false
    end

    test "update_complectation/2 with invalid data returns error changeset" do
      complectation = complectation_fixture()
      assert {:error, %Ecto.Changeset{}} = Lifts.update_complectation(complectation, @invalid_attrs)
      assert complectation == Lifts.get_complectation!(complectation.id)
    end

    test "delete_complectation/1 deletes the complectation" do
      complectation = complectation_fixture()
      assert {:ok, %Complectation{}} = Lifts.delete_complectation(complectation)
      assert_raise Ecto.NoResultsError, fn -> Lifts.get_complectation!(complectation.id) end
    end

    test "change_complectation/1 returns a complectation changeset" do
      complectation = complectation_fixture()
      assert %Ecto.Changeset{} = Lifts.change_complectation(complectation)
    end
  end

  describe "breaks" do
    alias Rep.Lifts.Break

    @valid_attrs %{fixed: true, notes: "some notes", served: ~D[2010-04-17], started: true, stoped: true}
    @update_attrs %{fixed: false, notes: "some updated notes", served: ~D[2011-05-18], started: false, stoped: false}
    @invalid_attrs %{fixed: nil, notes: nil, served: nil, started: nil, stoped: nil}

    def break_fixture(attrs \\ %{}) do
      {:ok, break} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Lifts.create_break()

      break
    end

    test "list_breaks/0 returns all breaks" do
      break = break_fixture()
      assert Lifts.list_breaks() == [break]
    end

    test "get_break!/1 returns the break with given id" do
      break = break_fixture()
      assert Lifts.get_break!(break.id) == break
    end

    test "create_break/1 with valid data creates a break" do
      assert {:ok, %Break{} = break} = Lifts.create_break(@valid_attrs)
      assert break.fixed == true
      assert break.notes == "some notes"
      assert break.served == ~D[2010-04-17]
      assert break.started == true
      assert break.stoped == true
    end

    test "create_break/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Lifts.create_break(@invalid_attrs)
    end

    test "update_break/2 with valid data updates the break" do
      break = break_fixture()
      assert {:ok, break} = Lifts.update_break(break, @update_attrs)
      assert %Break{} = break
      assert break.fixed == false
      assert break.notes == "some updated notes"
      assert break.served == ~D[2011-05-18]
      assert break.started == false
      assert break.stoped == false
    end

    test "update_break/2 with invalid data returns error changeset" do
      break = break_fixture()
      assert {:error, %Ecto.Changeset{}} = Lifts.update_break(break, @invalid_attrs)
      assert break == Lifts.get_break!(break.id)
    end

    test "delete_break/1 deletes the break" do
      break = break_fixture()
      assert {:ok, %Break{}} = Lifts.delete_break(break)
      assert_raise Ecto.NoResultsError, fn -> Lifts.get_break!(break.id) end
    end

    test "change_break/1 returns a break changeset" do
      break = break_fixture()
      assert %Ecto.Changeset{} = Lifts.change_break(break)
    end
  end
end
