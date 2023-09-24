defmodule Grey.Breakbulks do
  @moduledoc """
  The Breakbulks context.
  """

  import Ecto.Query, warn: false
  alias Grey.Repo

  alias Grey.Breakbulks.Breakbulk

  @doc """
  Returns the list of breakbulks.

  ## Examples

      iex> list_breakbulks()
      [%Breakbulk{}, ...]

  """
  def list_breakbulks do
    Repo.all(Breakbulk)
  end

  @doc """
  Gets a single breakbulk.

  Raises `Ecto.NoResultsError` if the Breakbulk does not exist.

  ## Examples

      iex> get_breakbulk!(123)
      %Breakbulk{}

      iex> get_breakbulk!(456)
      ** (Ecto.NoResultsError)

  """
  def get_breakbulk!(id), do: Repo.get!(Breakbulk, id)

  @doc """
  Creates a breakbulk.

  ## Examples

      iex> create_breakbulk(%{field: value})
      {:ok, %Breakbulk{}}

      iex> create_breakbulk(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_breakbulk(attrs \\ %{}) do
    %Breakbulk{}
    |> Breakbulk.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a breakbulk.

  ## Examples

      iex> update_breakbulk(breakbulk, %{field: new_value})
      {:ok, %Breakbulk{}}

      iex> update_breakbulk(breakbulk, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_breakbulk(%Breakbulk{} = breakbulk, attrs) do
    breakbulk
    |> Breakbulk.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a breakbulk.

  ## Examples

      iex> delete_breakbulk(breakbulk)
      {:ok, %Breakbulk{}}

      iex> delete_breakbulk(breakbulk)
      {:error, %Ecto.Changeset{}}

  """
  def delete_breakbulk(%Breakbulk{} = breakbulk) do
    Repo.delete(breakbulk)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking breakbulk changes.

  ## Examples

      iex> change_breakbulk(breakbulk)
      %Ecto.Changeset{data: %Breakbulk{}}

  """
  def change_breakbulk(%Breakbulk{} = breakbulk, attrs \\ %{}) do
    Breakbulk.changeset(breakbulk, attrs)
  end
end
