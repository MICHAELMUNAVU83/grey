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

  alias Grey.WareHouses
  alias Grey.Vehicles

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

      _ ->
        "nothing to update"
    end
  end

  defp update_status(context, schema) do
    case schema do
      "WareHouse" ->
        IO.inspect(schema)
        IO.write("im at warehouse again")

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
    end
  end
end
