defmodule Grey.TransfersTest do
  use Grey.DataCase

  alias Grey.Transfers

  describe "transfers" do
    alias Grey.Transfers.Transfer

    import Grey.TransfersFixtures

    @invalid_attrs %{item: nil, rack_from: nil, rack_to: nil, status: nil}

    test "list_transfers/0 returns all transfers" do
      transfer = transfer_fixture()
      assert Transfers.list_transfers() == [transfer]
    end

    test "get_transfer!/1 returns the transfer with given id" do
      transfer = transfer_fixture()
      assert Transfers.get_transfer!(transfer.id) == transfer
    end

    test "create_transfer/1 with valid data creates a transfer" do
      valid_attrs = %{
        item: "some item",
        rack_from: "some rack_from",
        rack_to: "some rack_to",
        status: "some status"
      }

      assert {:ok, %Transfer{} = transfer} = Transfers.create_transfer(valid_attrs)
      assert transfer.item == "some item"
      assert transfer.rack_from == "some rack_from"
      assert transfer.rack_to == "some rack_to"
      assert transfer.status == "some status"
    end

    test "create_transfer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transfers.create_transfer(@invalid_attrs)
    end

    test "update_transfer/2 with valid data updates the transfer" do
      transfer = transfer_fixture()

      update_attrs = %{
        item: "some updated item",
        rack_from: "some updated rack_from",
        rack_to: "some updated rack_to",
        status: "some updated status"
      }

      assert {:ok, %Transfer{} = transfer} = Transfers.update_transfer(transfer, update_attrs)
      assert transfer.item == "some updated item"
      assert transfer.rack_from == "some updated rack_from"
      assert transfer.rack_to == "some updated rack_to"
      assert transfer.status == "some updated status"
    end

    test "update_transfer/2 with invalid data returns error changeset" do
      transfer = transfer_fixture()
      assert {:error, %Ecto.Changeset{}} = Transfers.update_transfer(transfer, @invalid_attrs)
      assert transfer == Transfers.get_transfer!(transfer.id)
    end

    test "delete_transfer/1 deletes the transfer" do
      transfer = transfer_fixture()
      assert {:ok, %Transfer{}} = Transfers.delete_transfer(transfer)
      assert_raise Ecto.NoResultsError, fn -> Transfers.get_transfer!(transfer.id) end
    end

    test "change_transfer/1 returns a transfer changeset" do
      transfer = transfer_fixture()
      assert %Ecto.Changeset{} = Transfers.change_transfer(transfer)
    end
  end
end
