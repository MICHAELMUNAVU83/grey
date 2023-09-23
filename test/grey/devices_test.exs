defmodule Grey.DevicesTest do
  use Grey.DataCase

  alias Grey.Devices

  describe "device" do
    alias Grey.Devices.Device

    import Grey.DevicesFixtures

    @invalid_attrs %{active: nil, name: nil, description: nil, imei: nil}

    test "list_device/0 returns all device" do
      device = device_fixture()
      assert Devices.list_device() == [device]
    end

    test "get_device!/1 returns the device with given id" do
      device = device_fixture()
      assert Devices.get_device!(device.id) == device
    end

    test "create_device/1 with valid data creates a device" do
      valid_attrs = %{
        active: true,
        name: "some name",
        description: "some description",
        imei: "some imei"
      }

      assert {:ok, %Device{} = device} = Devices.create_device(valid_attrs)
      assert device.active == true
      assert device.name == "some name"
      assert device.description == "some description"
      assert device.imei == "some imei"
    end

    test "create_device/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Devices.create_device(@invalid_attrs)
    end

    test "update_device/2 with valid data updates the device" do
      device = device_fixture()

      update_attrs = %{
        active: false,
        name: "some updated name",
        description: "some updated description",
        imei: "some updated imei"
      }

      assert {:ok, %Device{} = device} = Devices.update_device(device, update_attrs)
      assert device.active == false
      assert device.name == "some updated name"
      assert device.description == "some updated description"
      assert device.imei == "some updated imei"
    end

    test "update_device/2 with invalid data returns error changeset" do
      device = device_fixture()
      assert {:error, %Ecto.Changeset{}} = Devices.update_device(device, @invalid_attrs)
      assert device == Devices.get_device!(device.id)
    end

    test "delete_device/1 deletes the device" do
      device = device_fixture()
      assert {:ok, %Device{}} = Devices.delete_device(device)
      assert_raise Ecto.NoResultsError, fn -> Devices.get_device!(device.id) end
    end

    test "change_device/1 returns a device changeset" do
      device = device_fixture()
      assert %Ecto.Changeset{} = Devices.change_device(device)
    end
  end
end
