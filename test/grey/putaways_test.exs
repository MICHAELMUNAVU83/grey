defmodule Grey.PutawaysTest do
  use Grey.DataCase

  alias Grey.Putaways

  describe "putaways" do
    alias Grey.Putaways.Putaway

    import Grey.PutawaysFixtures

    @invalid_attrs %{item: nil, rack: nil, status: nil}

    test "list_putaways/0 returns all putaways" do
      putaway = putaway_fixture()
      assert Putaways.list_putaways() == [putaway]
    end

    test "get_putaway!/1 returns the putaway with given id" do
      putaway = putaway_fixture()
      assert Putaways.get_putaway!(putaway.id) == putaway
    end

    test "create_putaway/1 with valid data creates a putaway" do
      valid_attrs = %{item: "some item", rack: "some rack", status: "some status"}

      assert {:ok, %Putaway{} = putaway} = Putaways.create_putaway(valid_attrs)
      assert putaway.item == "some item"
      assert putaway.rack == "some rack"
      assert putaway.status == "some status"
    end

    test "create_putaway/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Putaways.create_putaway(@invalid_attrs)
    end

    test "update_putaway/2 with valid data updates the putaway" do
      putaway = putaway_fixture()

      update_attrs = %{
        item: "some updated item",
        rack: "some updated rack",
        status: "some updated status"
      }

      assert {:ok, %Putaway{} = putaway} = Putaways.update_putaway(putaway, update_attrs)
      assert putaway.item == "some updated item"
      assert putaway.rack == "some updated rack"
      assert putaway.status == "some updated status"
    end

    test "update_putaway/2 with invalid data returns error changeset" do
      putaway = putaway_fixture()
      assert {:error, %Ecto.Changeset{}} = Putaways.update_putaway(putaway, @invalid_attrs)
      assert putaway == Putaways.get_putaway!(putaway.id)
    end

    test "delete_putaway/1 deletes the putaway" do
      putaway = putaway_fixture()
      assert {:ok, %Putaway{}} = Putaways.delete_putaway(putaway)
      assert_raise Ecto.NoResultsError, fn -> Putaways.get_putaway!(putaway.id) end
    end

    test "change_putaway/1 returns a putaway changeset" do
      putaway = putaway_fixture()
      assert %Ecto.Changeset{} = Putaways.change_putaway(putaway)
    end
  end
end
