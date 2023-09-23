defmodule Grey.Returns do
  @moduledoc """
  The Returns context.
  """

  import Ecto.Query, warn: false
  alias Grey.Repo

  alias Grey.Returns.Return

  @doc """
  Returns the list of returns.

  ## Examples

      iex> list_returns()
      [%Return{}, ...]

  """
  def list_returns do
    Repo.all(Return)
  end

  @doc """
  Gets a single return.

  Raises `Ecto.NoResultsError` if the Return does not exist.

  ## Examples

      iex> get_return!(123)
      %Return{}

      iex> get_return!(456)
      ** (Ecto.NoResultsError)

  """
  def get_return!(id), do: Repo.get!(Return, id)

  @doc """
  Creates a return.

  ## Examples

      iex> create_return(%{field: value})
      {:ok, %Return{}}

      iex> create_return(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_return(attrs \\ %{}) do
    %Return{}
    |> Return.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a return.

  ## Examples

      iex> update_return(return, %{field: new_value})
      {:ok, %Return{}}

      iex> update_return(return, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_return(%Return{} = return, attrs) do
    return
    |> Return.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a return.

  ## Examples

      iex> delete_return(return)
      {:ok, %Return{}}

      iex> delete_return(return)
      {:error, %Ecto.Changeset{}}

  """
  def delete_return(%Return{} = return) do
    Repo.delete(return)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking return changes.

  ## Examples

      iex> change_return(return)
      %Ecto.Changeset{data: %Return{}}

  """
  def change_return(%Return{} = return, attrs \\ %{}) do
    Return.changeset(return, attrs)
  end
end
