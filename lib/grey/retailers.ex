defmodule Grey.Retailers do
  @moduledoc """
  The Retailers context.
  """

  import Ecto.Query, warn: false
  alias Grey.Repo

  alias Grey.Retailers.Retailer

  @doc """
  Returns the list of retailers.

  ## Examples

      iex> list_retailers()
      [%Retailer{}, ...]

  """
  def list_retailers do
    Repo.all(Retailer)
  end

  @doc """
  Gets a single retailer.

  Raises `Ecto.NoResultsError` if the Retailer does not exist.

  ## Examples

      iex> get_retailer!(123)
      %Retailer{}

      iex> get_retailer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_retailer!(id), do: Repo.get!(Retailer, id)

  @doc """
  Creates a retailer.

  ## Examples

      iex> create_retailer(%{field: value})
      {:ok, %Retailer{}}

      iex> create_retailer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_retailer(attrs \\ %{}) do
    %Retailer{}
    |> Retailer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a retailer.

  ## Examples

      iex> update_retailer(retailer, %{field: new_value})
      {:ok, %Retailer{}}

      iex> update_retailer(retailer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_retailer(%Retailer{} = retailer, attrs) do
    retailer
    |> Retailer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a retailer.

  ## Examples

      iex> delete_retailer(retailer)
      {:ok, %Retailer{}}

      iex> delete_retailer(retailer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_retailer(%Retailer{} = retailer) do
    Repo.delete(retailer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking retailer changes.

  ## Examples

      iex> change_retailer(retailer)
      %Ecto.Changeset{data: %Retailer{}}

  """
  def change_retailer(%Retailer{} = retailer, attrs \\ %{}) do
    Retailer.changeset(retailer, attrs)
  end
end
