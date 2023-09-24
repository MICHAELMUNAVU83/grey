defmodule Grey.StoragesTest do
  use Grey.DataCase

  alias Grey.Storages

  describe "storages" do
    alias Grey.Storages.Storage

    import Grey.StoragesFixtures

    @invalid_attrs %{active: nil, name: nil, description: nil, item: nil, gln: nil}

    test "list_storages/0 returns all storages" do
      storage = storage_fixture()
      assert Storages.list_storages() == [storage]
    end

    test "get_storage!/1 returns the storage with given id" do
      storage = storage_fixture()
      assert Storages.get_storage!(storage.id) == storage
    end

    test "create_storage/1 with valid data creates a storage" do
      valid_attrs = %{
        active: "some active",
        name: "some name",
        description: "some description",
        item: "some item",
        gln: "some gln"
      }

      assert {:ok, %Storage{} = storage} = Storages.create_storage(valid_attrs)
      assert storage.active == "some active"
      assert storage.name == "some name"
      assert storage.description == "some description"
      assert storage.item == "some item"
      assert storage.gln == "some gln"
    end

    test "create_storage/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Storages.create_storage(@invalid_attrs)
    end

    test "update_storage/2 with valid data updates the storage" do
      storage = storage_fixture()

      update_attrs = %{
        active: "some updated active",
        name: "some updated name",
        description: "some updated description",
        item: "some updated item",
        gln: "some updated gln"
      }

      assert {:ok, %Storage{} = storage} = Storages.update_storage(storage, update_attrs)
      assert storage.active == "some updated active"
      assert storage.name == "some updated name"
      assert storage.description == "some updated description"
      assert storage.item == "some updated item"
      assert storage.gln == "some updated gln"
    end

    test "update_storage/2 with invalid data returns error changeset" do
      storage = storage_fixture()
      assert {:error, %Ecto.Changeset{}} = Storages.update_storage(storage, @invalid_attrs)
      assert storage == Storages.get_storage!(storage.id)
    end

    test "delete_storage/1 deletes the storage" do
      storage = storage_fixture()
      assert {:ok, %Storage{}} = Storages.delete_storage(storage)
      assert_raise Ecto.NoResultsError, fn -> Storages.get_storage!(storage.id) end
    end

    test "change_storage/1 returns a storage changeset" do
      storage = storage_fixture()
      assert %Ecto.Changeset{} = Storages.change_storage(storage)
    end
  end
end
