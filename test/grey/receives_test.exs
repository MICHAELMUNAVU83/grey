defmodule Grey.ReceivesTest do
  use Grey.DataCase

  alias Grey.Receives

  describe "receives" do
    alias Grey.Receives.Receive

    import Grey.ReceivesFixtures

    @invalid_attrs %{
      active: nil,
      batch: nil,
      description: nil,
      expiry: nil,
      gtin: nil,
      name: nil,
      production: nil,
      qty: nil,
      uom: nil,
      weight: nil
    }

    test "list_receives/0 returns all receives" do
      receive = receive_fixture()
      assert Receives.list_receives() == [receive]
    end

    test "get_receive!/1 returns the receive with given id" do
      receive = receive_fixture()
      assert Receives.get_receive!(receive.id) == receive
    end

    test "create_receive/1 with valid data creates a receive" do
      valid_attrs = %{
        active: "some active",
        batch: "some batch",
        description: "some description",
        expiry: ~D[2023-10-21],
        gtin: 42,
        name: "some name",
        production: ~D[2023-10-21],
        qty: 120.5,
        uom: "some uom",
        weight: 120.5
      }

      assert {:ok, %Receive{} = receive} = Receives.create_receive(valid_attrs)
      assert receive.active == "some active"
      assert receive.batch == "some batch"
      assert receive.description == "some description"
      assert receive.expiry == ~D[2023-10-21]
      assert receive.gtin == 42
      assert receive.name == "some name"
      assert receive.production == ~D[2023-10-21]
      assert receive.qty == 120.5
      assert receive.uom == "some uom"
      assert receive.weight == 120.5
    end

    test "create_receive/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Receives.create_receive(@invalid_attrs)
    end

    test "update_receive/2 with valid data updates the receive" do
      receive = receive_fixture()

      update_attrs = %{
        active: "some updated active",
        batch: "some updated batch",
        description: "some updated description",
        expiry: ~D[2023-10-22],
        gtin: 43,
        name: "some updated name",
        production: ~D[2023-10-22],
        qty: 456.7,
        uom: "some updated uom",
        weight: 456.7
      }

      assert {:ok, %Receive{} = receive} = Receives.update_receive(receive, update_attrs)
      assert receive.active == "some updated active"
      assert receive.batch == "some updated batch"
      assert receive.description == "some updated description"
      assert receive.expiry == ~D[2023-10-22]
      assert receive.gtin == 43
      assert receive.name == "some updated name"
      assert receive.production == ~D[2023-10-22]
      assert receive.qty == 456.7
      assert receive.uom == "some updated uom"
      assert receive.weight == 456.7
    end

    test "update_receive/2 with invalid data returns error changeset" do
      receive = receive_fixture()
      assert {:error, %Ecto.Changeset{}} = Receives.update_receive(receive, @invalid_attrs)
      assert receive == Receives.get_receive!(receive.id)
    end

    test "delete_receive/1 deletes the receive" do
      receive = receive_fixture()
      assert {:ok, %Receive{}} = Receives.delete_receive(receive)
      assert_raise Ecto.NoResultsError, fn -> Receives.get_receive!(receive.id) end
    end

    test "change_receive/1 returns a receive changeset" do
      receive = receive_fixture()
      assert %Ecto.Changeset{} = Receives.change_receive(receive)
    end
  end
end
