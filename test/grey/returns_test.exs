defmodule Grey.ReturnsTest do
  use Grey.DataCase

  alias Grey.Returns

  describe "returns" do
    alias Grey.Returns.Return

    import Grey.ReturnsFixtures

    @invalid_attrs %{item: nil, name: nil, phone: nil, quantity: nil, reason: nil, status: nil}

    test "list_returns/0 returns all returns" do
      return = return_fixture()
      assert Returns.list_returns() == [return]
    end

    test "get_return!/1 returns the return with given id" do
      return = return_fixture()
      assert Returns.get_return!(return.id) == return
    end

    test "create_return/1 with valid data creates a return" do
      valid_attrs = %{
        item: "some item",
        name: "some name",
        phone: "some phone",
        quantity: "some quantity",
        reason: "some reason",
        status: "some status"
      }

      assert {:ok, %Return{} = return} = Returns.create_return(valid_attrs)
      assert return.item == "some item"
      assert return.name == "some name"
      assert return.phone == "some phone"
      assert return.quantity == "some quantity"
      assert return.reason == "some reason"
      assert return.status == "some status"
    end

    test "create_return/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Returns.create_return(@invalid_attrs)
    end

    test "update_return/2 with valid data updates the return" do
      return = return_fixture()

      update_attrs = %{
        item: "some updated item",
        name: "some updated name",
        phone: "some updated phone",
        quantity: "some updated quantity",
        reason: "some updated reason",
        status: "some updated status"
      }

      assert {:ok, %Return{} = return} = Returns.update_return(return, update_attrs)
      assert return.item == "some updated item"
      assert return.name == "some updated name"
      assert return.phone == "some updated phone"
      assert return.quantity == "some updated quantity"
      assert return.reason == "some updated reason"
      assert return.status == "some updated status"
    end

    test "update_return/2 with invalid data returns error changeset" do
      return = return_fixture()
      assert {:error, %Ecto.Changeset{}} = Returns.update_return(return, @invalid_attrs)
      assert return == Returns.get_return!(return.id)
    end

    test "delete_return/1 deletes the return" do
      return = return_fixture()
      assert {:ok, %Return{}} = Returns.delete_return(return)
      assert_raise Ecto.NoResultsError, fn -> Returns.get_return!(return.id) end
    end

    test "change_return/1 returns a return changeset" do
      return = return_fixture()
      assert %Ecto.Changeset{} = Returns.change_return(return)
    end
  end
end
