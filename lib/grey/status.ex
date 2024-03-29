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
  alias Grey.Receives.Receive
  alias Grey.Receives
  alias Grey.WareHouses
  alias Grey.Vehicles
  alias Grey.Staffs
  alias Grey.Devices
  alias Grey.Storages
  alias Grey.Returns
  alias Grey.Breakbulks
  alias Grey.Dispatches
  alias Grey.Retailers
  alias Grey.Suppliers
  alias Grey.Putaways
  alias Grey.Transfers

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

      "retailer" ->
        items = Repo.one(from x in Retailer, where: x.id == ^id)

        update_status(items, "retailer")

      "supplier" ->
        items = Repo.one(from x in Supplier, where: x.id == ^id)

        update_status(items, "supplier")

      "putaway" ->
        items = Repo.one(from x in Putaway, where: x.id == ^id)

        update_status(items, "putaway")

      "transfer" ->
        IO.write("im at transfer")
        items = Repo.one(from x in Transfer, where: x.id == ^id)
        update_status(items, "transfer")

      "recieve" ->
        IO.write("im at recieve")
        items = Repo.one(from x in Receive, where: x.id == ^id)
        update_status(items, "recieve")

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

      "retailer" ->
        if context.active == true do
          Retailers.update_retailer(context, %{"active" => false})
        else
          Retailers.update_retailer(context, %{"active" => true})
        end

      "supplier" ->
        if context.active == true do
          Suppliers.update_supplier(context, %{"active" => false})
        else
          Suppliers.update_supplier(context, %{"active" => true})
        end

      "putaway" ->
        if context.active == true do
          Putaways.update_putaway(context, %{"active" => false})
        else
          Putaways.update_putaway(context, %{"active" => true})
        end

      "transfer" ->
        if context.active == true do
          Transfers.update_transfer(context, %{"active" => false})
        else
          Transfers.update_transfer(context, %{"active" => true})
        end

      "receive" ->
        if context.active == true do
          Receives.update_receive(context, %{"active" => false})
        else
          Receives.update_receive(context, %{"active" => true})
        end
    end
  end
end
