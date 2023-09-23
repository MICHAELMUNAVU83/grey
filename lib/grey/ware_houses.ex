defmodule Grey.WareHouses do
  @moduledoc """
  The WareHouses context.
  """

  import Ecto.Query, warn: false
  alias Grey.Repo

  alias Grey.WareHouses.WareHouse

  @doc """
  Returns the list of warehouse.

  ## Examples

      iex> list_warehouse()
      [%WareHouse{}, ...]

  """
  def list_warehouse do
    Repo.all(WareHouse)
  end

  @doc """
  Gets a single ware_house.

  Raises `Ecto.NoResultsError` if the Ware house does not exist.

  ## Examples

      iex> get_ware_house!(123)
      %WareHouse{}

      iex> get_ware_house!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ware_house!(id), do: Repo.get!(WareHouse, id)

  @doc """
  Creates a ware_house.

  ## Examples

      iex> create_ware_house(%{field: value})
      {:ok, %WareHouse{}}

      iex> create_ware_house(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ware_house(attrs \\ %{}) do
    %WareHouse{}
    |> WareHouse.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ware_house.

  ## Examples

      iex> update_ware_house(ware_house, %{field: new_value})
      {:ok, %WareHouse{}}

      iex> update_ware_house(ware_house, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ware_house(%WareHouse{} = ware_house, attrs) do
    ware_house
    |> WareHouse.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ware_house.

  ## Examples

      iex> delete_ware_house(ware_house)
      {:ok, %WareHouse{}}

      iex> delete_ware_house(ware_house)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ware_house(%WareHouse{} = ware_house) do
    Repo.delete(ware_house)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ware_house changes.

  ## Examples

      iex> change_ware_house(ware_house)
      %Ecto.Changeset{data: %WareHouse{}}

  """
  def change_ware_house(%WareHouse{} = ware_house, attrs \\ %{}) do
    WareHouse.changeset(ware_house, attrs)
  end
end
