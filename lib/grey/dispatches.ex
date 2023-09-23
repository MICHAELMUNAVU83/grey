defmodule Grey.Dispatches do
  @moduledoc """
  The Dispatches context.
  """

  import Ecto.Query, warn: false
  alias Grey.Repo

  alias Grey.Dispatches.Dispatch

  @doc """
  Returns the list of dispatches.

  ## Examples

      iex> list_dispatches()
      [%Dispatch{}, ...]

  """
  def list_dispatches do
    Repo.all(Dispatch)
  end

  @doc """
  Gets a single dispatch.

  Raises `Ecto.NoResultsError` if the Dispatch does not exist.

  ## Examples

      iex> get_dispatch!(123)
      %Dispatch{}

      iex> get_dispatch!(456)
      ** (Ecto.NoResultsError)

  """
  def get_dispatch!(id), do: Repo.get!(Dispatch, id)

  @doc """
  Creates a dispatch.

  ## Examples

      iex> create_dispatch(%{field: value})
      {:ok, %Dispatch{}}

      iex> create_dispatch(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_dispatch(attrs \\ %{}) do
    %Dispatch{}
    |> Dispatch.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a dispatch.

  ## Examples

      iex> update_dispatch(dispatch, %{field: new_value})
      {:ok, %Dispatch{}}

      iex> update_dispatch(dispatch, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_dispatch(%Dispatch{} = dispatch, attrs) do
    dispatch
    |> Dispatch.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a dispatch.

  ## Examples

      iex> delete_dispatch(dispatch)
      {:ok, %Dispatch{}}

      iex> delete_dispatch(dispatch)
      {:error, %Ecto.Changeset{}}

  """
  def delete_dispatch(%Dispatch{} = dispatch) do
    Repo.delete(dispatch)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking dispatch changes.

  ## Examples

      iex> change_dispatch(dispatch)
      %Ecto.Changeset{data: %Dispatch{}}

  """
  def change_dispatch(%Dispatch{} = dispatch, attrs \\ %{}) do
    Dispatch.changeset(dispatch, attrs)
  end
end
