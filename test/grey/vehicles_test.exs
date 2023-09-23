defmodule Grey.VehiclesTest do
  use Grey.DataCase

  alias Grey.Vehicles

  describe "vehicle" do
    alias Grey.Vehicles.Vehicle

    import Grey.VehiclesFixtures

    @invalid_attrs %{active: nil, serial: nil, type: nil, description: nil, makeofcar: nil, reg: nil}

    test "list_vehicle/0 returns all vehicle" do
      vehicle = vehicle_fixture()
      assert Vehicles.list_vehicle() == [vehicle]
    end

    test "get_vehicle!/1 returns the vehicle with given id" do
      vehicle = vehicle_fixture()
      assert Vehicles.get_vehicle!(vehicle.id) == vehicle
    end

    test "create_vehicle/1 with valid data creates a vehicle" do
      valid_attrs = %{active: true, serial: "some serial", type: "some type", description: "some description", makeofcar: "some makeofcar", reg: "some reg"}

      assert {:ok, %Vehicle{} = vehicle} = Vehicles.create_vehicle(valid_attrs)
      assert vehicle.active == true
      assert vehicle.serial == "some serial"
      assert vehicle.type == "some type"
      assert vehicle.description == "some description"
      assert vehicle.makeofcar == "some makeofcar"
      assert vehicle.reg == "some reg"
    end

    test "create_vehicle/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Vehicles.create_vehicle(@invalid_attrs)
    end

    test "update_vehicle/2 with valid data updates the vehicle" do
      vehicle = vehicle_fixture()
      update_attrs = %{active: false, serial: "some updated serial", type: "some updated type", description: "some updated description", makeofcar: "some updated makeofcar", reg: "some updated reg"}

      assert {:ok, %Vehicle{} = vehicle} = Vehicles.update_vehicle(vehicle, update_attrs)
      assert vehicle.active == false
      assert vehicle.serial == "some updated serial"
      assert vehicle.type == "some updated type"
      assert vehicle.description == "some updated description"
      assert vehicle.makeofcar == "some updated makeofcar"
      assert vehicle.reg == "some updated reg"
    end

    test "update_vehicle/2 with invalid data returns error changeset" do
      vehicle = vehicle_fixture()
      assert {:error, %Ecto.Changeset{}} = Vehicles.update_vehicle(vehicle, @invalid_attrs)
      assert vehicle == Vehicles.get_vehicle!(vehicle.id)
    end

    test "delete_vehicle/1 deletes the vehicle" do
      vehicle = vehicle_fixture()
      assert {:ok, %Vehicle{}} = Vehicles.delete_vehicle(vehicle)
      assert_raise Ecto.NoResultsError, fn -> Vehicles.get_vehicle!(vehicle.id) end
    end

    test "change_vehicle/1 returns a vehicle changeset" do
      vehicle = vehicle_fixture()
      assert %Ecto.Changeset{} = Vehicles.change_vehicle(vehicle)
    end
  end
end
