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

  def change_status(id, schema) do
    case schema do
      "WareHouse" ->
        IO.write("im here ")
        items = Repo.one(from x in WareHouse, where: x.id == ^id)
        update_status(items, "WareHouse")

      _ ->
        "nothing to update"
    end
  end

  defp update_status(context, schema) do
    cond do
      schema ->
        "WareHouse"
        WareHouses.update_ware_house(context, %{"active" => false})
    end
  end
end
