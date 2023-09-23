defmodule Grey.Putaways do
  @moduledoc """
  The Putaways context.
  """

  import Ecto.Query, warn: false
  alias Grey.Repo

  alias Grey.Putaways.Putaway

  @doc """
  Returns the list of putaways.

  ## Examples

      iex> list_putaways()
      [%Putaway{}, ...]

  """
  def list_putaways do
    Repo.all(Putaway)
  end

  @doc """
  Gets a single putaway.

  Raises `Ecto.NoResultsError` if the Putaway does not exist.

  ## Examples

      iex> get_putaway!(123)
      %Putaway{}

      iex> get_putaway!(456)
      ** (Ecto.NoResultsError)

  """
  def get_putaway!(id), do: Repo.get!(Putaway, id)

  @doc """
  Creates a putaway.

  ## Examples

      iex> create_putaway(%{field: value})
      {:ok, %Putaway{}}

      iex> create_putaway(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_putaway(attrs \\ %{}) do
    %Putaway{}
    |> Putaway.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a putaway.

  ## Examples

      iex> update_putaway(putaway, %{field: new_value})
      {:ok, %Putaway{}}

      iex> update_putaway(putaway, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_putaway(%Putaway{} = putaway, attrs) do
    putaway
    |> Putaway.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a putaway.

  ## Examples

      iex> delete_putaway(putaway)
      {:ok, %Putaway{}}

      iex> delete_putaway(putaway)
      {:error, %Ecto.Changeset{}}

  """
  def delete_putaway(%Putaway{} = putaway) do
    Repo.delete(putaway)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking putaway changes.

  ## Examples

      iex> change_putaway(putaway)
      %Ecto.Changeset{data: %Putaway{}}

  """
  def change_putaway(%Putaway{} = putaway, attrs \\ %{}) do
    Putaway.changeset(putaway, attrs)
  end
end
