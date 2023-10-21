defmodule Grey.Status do
  import Ecto.Query, warn: false
  alias Grey.Repo
  alias Grey.WareHouses.WareHouse
  alias Grey.Vehicles.Vehicle
  alias Grey.Staffs.Staff
  alias Grey.Transfers.Transfer
  alias Grey.Returns.Return
  alias Grey.Breakbulks.Breakbulk
  alias Grey.Devices.Device
  alias Grey.Dispatches.Dispatch
  alias Grey.Retailers.Retailer
  alias Grey.Suppliers.Supplier
  alias Grey.Putaways.Putaway
  alias Grey.Storages.Storage

  alias Grey.WareHouses
  alias Grey.Vehicles
  alias Grey.Staffs
  alias Grey.Devices
  alias Grey.Storages
  alias Grey.Returns
  alias Grey.Breakbulks
  alias Grey.Dispatches

  def change_status(id, schema) do
    case schema do
      "WareHouse" ->
        IO.write("im at warehouse")
        items = Repo.one(from x in WareHouse, where: x.id == ^id)
        update_status(items, "WareHouse")

      "Vehicle" ->
        IO.write("im at vehicle")
        items = Repo.one(from x in Vehicle, where: x.id == ^id)
        update_status(items, "Vehicle")

      "staff" ->
        IO.write("im at staff")
        items = Repo.one(from x in Staff, where: x.id == ^id)
        update_status(items, "staff")

      "device" ->
        IO.write("im at device")
        items = Repo.one(from x in Device, where: x.id == ^id)
        update_status(items, "device")

      "storage" ->
        items = Repo.one(from x in Storage, where: x.id == ^id)

        update_status(items, "storage")

      "return" ->
        items = Repo.one(from x in Return, where: x.id == ^id)

        update_status(items, "return")

      "breakbulk" ->
        items = Repo.one(from x in Breakbulk, where: x.id == ^id)

        update_status(items, "breakbulk")

      "dispatch" ->
        items = Repo.one(from x in Dispatch, where: x.id == ^id)

        update_status(items, "dispatch")

      _ ->
        "nothing to update"
    end
  end

  defp update_status(context, schema) do
    case schema do
      "WareHouse" ->
        if context.active == true do
          WareHouses.update_ware_house(context, %{"active" => false})
        else
          WareHouses.update_ware_house(context, %{"active" => true})
        end

      "Vehicle" ->
        if context.active == true do
          Vehicles.update_vehicle(context, %{"active" => false})
        else
          Vehicles.update_vehicle(context, %{"active" => true})
        end

      "staff" ->
        if context.active == true do
          Staffs.update_staff(context, %{"active" => false})
        else
          Staffs.update_staff(context, %{"active" => true})
        end

      "device" ->
        if context.active == true do
          Devices.update_device(context, %{"active" => false})
        else
          Devices.update_device(context, %{"active" => true})
        end

      "storage" ->
        if context.active == true do
          Storages.update_storage(context, %{"active" => false})
        else
          Storages.update_storage(context, %{"active" => true})
        end

      "return" ->
        if context.active == true do
          Returns.update_return(context, %{"active" => false})
        else
          Returns.update_return(context, %{"active" => true})
        end

      "breakbulk" ->
        if context.active == true do
          Breakbulks.update_breakbulk(context, %{"active" => false})
        else
          Breakbulks.update_breakbulk(context, %{"active" => true})
        end

      "dispatch" ->
        if context.active == true do
          Dispatches.update_dispatch(context, %{"active" => false})
        else
          Dispatches.update_dispatch(context, %{"active" => true})
        end
    end
  end
end
