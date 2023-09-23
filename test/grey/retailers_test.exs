defmodule Grey.RetailersTest do
  use Grey.DataCase

  alias Grey.Retailers

  describe "retailers" do
    alias Grey.Retailers.Retailer

    import Grey.RetailersFixtures

    @invalid_attrs %{description: nil, location: nil, name: nil, status: nil}

    test "list_retailers/0 returns all retailers" do
      retailer = retailer_fixture()
      assert Retailers.list_retailers() == [retailer]
    end

    test "get_retailer!/1 returns the retailer with given id" do
      retailer = retailer_fixture()
      assert Retailers.get_retailer!(retailer.id) == retailer
    end

    test "create_retailer/1 with valid data creates a retailer" do
      valid_attrs = %{description: "some description", location: "some location", name: "some name", status: "some status"}

      assert {:ok, %Retailer{} = retailer} = Retailers.create_retailer(valid_attrs)
      assert retailer.description == "some description"
      assert retailer.location == "some location"
      assert retailer.name == "some name"
      assert retailer.status == "some status"
    end

    test "create_retailer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Retailers.create_retailer(@invalid_attrs)
    end

    test "update_retailer/2 with valid data updates the retailer" do
      retailer = retailer_fixture()
      update_attrs = %{description: "some updated description", location: "some updated location", name: "some updated name", status: "some updated status"}

      assert {:ok, %Retailer{} = retailer} = Retailers.update_retailer(retailer, update_attrs)
      assert retailer.description == "some updated description"
      assert retailer.location == "some updated location"
      assert retailer.name == "some updated name"
      assert retailer.status == "some updated status"
    end

    test "update_retailer/2 with invalid data returns error changeset" do
      retailer = retailer_fixture()
      assert {:error, %Ecto.Changeset{}} = Retailers.update_retailer(retailer, @invalid_attrs)
      assert retailer == Retailers.get_retailer!(retailer.id)
    end

    test "delete_retailer/1 deletes the retailer" do
      retailer = retailer_fixture()
      assert {:ok, %Retailer{}} = Retailers.delete_retailer(retailer)
      assert_raise Ecto.NoResultsError, fn -> Retailers.get_retailer!(retailer.id) end
    end

    test "change_retailer/1 returns a retailer changeset" do
      retailer = retailer_fixture()
      assert %Ecto.Changeset{} = Retailers.change_retailer(retailer)
    end
  end
end
