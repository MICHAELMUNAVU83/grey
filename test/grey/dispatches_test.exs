defmodule Grey.DispatchesTest do
  use Grey.DataCase

  alias Grey.Dispatches

  describe "dispatches" do
    alias Grey.Dispatches.Dispatch

    import Grey.DispatchesFixtures

    @invalid_attrs %{batch: nil, companies: nil, description: nil, expiry: nil, gtin: nil, image: nil, name: nil, production: nil, quantity: nil, rack: nil, status: nil, transporter: nil, transporterid: nil, uom: nil, weight: nil}

    test "list_dispatches/0 returns all dispatches" do
      dispatch = dispatch_fixture()
      assert Dispatches.list_dispatches() == [dispatch]
    end

    test "get_dispatch!/1 returns the dispatch with given id" do
      dispatch = dispatch_fixture()
      assert Dispatches.get_dispatch!(dispatch.id) == dispatch
    end

    test "create_dispatch/1 with valid data creates a dispatch" do
      valid_attrs = %{batch: "some batch", companies: "some companies", description: "some description", expiry: "some expiry", gtin: "some gtin", image: "some image", name: "some name", production: "some production", quantity: "some quantity", rack: "some rack", status: "some status", transporter: "some transporter", transporterid: "some transporterid", uom: "some uom", weight: "some weight"}

      assert {:ok, %Dispatch{} = dispatch} = Dispatches.create_dispatch(valid_attrs)
      assert dispatch.batch == "some batch"
      assert dispatch.companies == "some companies"
      assert dispatch.description == "some description"
      assert dispatch.expiry == "some expiry"
      assert dispatch.gtin == "some gtin"
      assert dispatch.image == "some image"
      assert dispatch.name == "some name"
      assert dispatch.production == "some production"
      assert dispatch.quantity == "some quantity"
      assert dispatch.rack == "some rack"
      assert dispatch.status == "some status"
      assert dispatch.transporter == "some transporter"
      assert dispatch.transporterid == "some transporterid"
      assert dispatch.uom == "some uom"
      assert dispatch.weight == "some weight"
    end

    test "create_dispatch/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dispatches.create_dispatch(@invalid_attrs)
    end

    test "update_dispatch/2 with valid data updates the dispatch" do
      dispatch = dispatch_fixture()
      update_attrs = %{batch: "some updated batch", companies: "some updated companies", description: "some updated description", expiry: "some updated expiry", gtin: "some updated gtin", image: "some updated image", name: "some updated name", production: "some updated production", quantity: "some updated quantity", rack: "some updated rack", status: "some updated status", transporter: "some updated transporter", transporterid: "some updated transporterid", uom: "some updated uom", weight: "some updated weight"}

      assert {:ok, %Dispatch{} = dispatch} = Dispatches.update_dispatch(dispatch, update_attrs)
      assert dispatch.batch == "some updated batch"
      assert dispatch.companies == "some updated companies"
      assert dispatch.description == "some updated description"
      assert dispatch.expiry == "some updated expiry"
      assert dispatch.gtin == "some updated gtin"
      assert dispatch.image == "some updated image"
      assert dispatch.name == "some updated name"
      assert dispatch.production == "some updated production"
      assert dispatch.quantity == "some updated quantity"
      assert dispatch.rack == "some updated rack"
      assert dispatch.status == "some updated status"
      assert dispatch.transporter == "some updated transporter"
      assert dispatch.transporterid == "some updated transporterid"
      assert dispatch.uom == "some updated uom"
      assert dispatch.weight == "some updated weight"
    end

    test "update_dispatch/2 with invalid data returns error changeset" do
      dispatch = dispatch_fixture()
      assert {:error, %Ecto.Changeset{}} = Dispatches.update_dispatch(dispatch, @invalid_attrs)
      assert dispatch == Dispatches.get_dispatch!(dispatch.id)
    end

    test "delete_dispatch/1 deletes the dispatch" do
      dispatch = dispatch_fixture()
      assert {:ok, %Dispatch{}} = Dispatches.delete_dispatch(dispatch)
      assert_raise Ecto.NoResultsError, fn -> Dispatches.get_dispatch!(dispatch.id) end
    end

    test "change_dispatch/1 returns a dispatch changeset" do
      dispatch = dispatch_fixture()
      assert %Ecto.Changeset{} = Dispatches.change_dispatch(dispatch)
    end
  end
end
