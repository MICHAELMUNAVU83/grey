defmodule Grey.WareHousesTest do
  use Grey.DataCase

  alias Grey.WareHouses

  describe "warehouse" do
    alias Grey.WareHouses.WareHouse

    import Grey.WareHousesFixtures

    @invalid_attrs %{active: nil, name: nil, description: nil, location: nil, category: nil}

    test "list_warehouse/0 returns all warehouse" do
      ware_house = ware_house_fixture()
      assert WareHouses.list_warehouse() == [ware_house]
    end

    test "get_ware_house!/1 returns the ware_house with given id" do
      ware_house = ware_house_fixture()
      assert WareHouses.get_ware_house!(ware_house.id) == ware_house
    end

    test "create_ware_house/1 with valid data creates a ware_house" do
      valid_attrs = %{
        active: true,
        name: "some name",
        description: "some description",
        location: "some location",
        category: "some category"
      }

      assert {:ok, %WareHouse{} = ware_house} = WareHouses.create_ware_house(valid_attrs)
      assert ware_house.active == true
      assert ware_house.name == "some name"
      assert ware_house.description == "some description"
      assert ware_house.location == "some location"
      assert ware_house.category == "some category"
    end

    test "create_ware_house/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = WareHouses.create_ware_house(@invalid_attrs)
    end

    test "update_ware_house/2 with valid data updates the ware_house" do
      ware_house = ware_house_fixture()

      update_attrs = %{
        active: false,
        name: "some updated name",
        description: "some updated description",
        location: "some updated location",
        category: "some updated category"
      }

      assert {:ok, %WareHouse{} = ware_house} =
               WareHouses.update_ware_house(ware_house, update_attrs)

      assert ware_house.active == false
      assert ware_house.name == "some updated name"
      assert ware_house.description == "some updated description"
      assert ware_house.location == "some updated location"
      assert ware_house.category == "some updated category"
    end

    test "update_ware_house/2 with invalid data returns error changeset" do
      ware_house = ware_house_fixture()

      assert {:error, %Ecto.Changeset{}} =
               WareHouses.update_ware_house(ware_house, @invalid_attrs)

      assert ware_house == WareHouses.get_ware_house!(ware_house.id)
    end

    test "delete_ware_house/1 deletes the ware_house" do
      ware_house = ware_house_fixture()
      assert {:ok, %WareHouse{}} = WareHouses.delete_ware_house(ware_house)
      assert_raise Ecto.NoResultsError, fn -> WareHouses.get_ware_house!(ware_house.id) end
    end

    test "change_ware_house/1 returns a ware_house changeset" do
      ware_house = ware_house_fixture()
      assert %Ecto.Changeset{} = WareHouses.change_ware_house(ware_house)
    end
  end
end
