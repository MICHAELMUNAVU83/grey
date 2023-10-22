defmodule Grey.Receives do
  @moduledoc """
  The Receives context.
  """

  import Ecto.Query, warn: false
  alias Grey.Repo

  alias Grey.Receives.Receive

  @doc """
  Returns the list of receives.

  ## Examples

      iex> list_receives()
      [%Receive{}, ...]

  """
  def list_receives do
    Repo.all(Receive)
  end

  @doc """
  Gets a single receive.

  Raises `Ecto.NoResultsError` if the Receive does not exist.

  ## Examples

      iex> get_receive!(123)
      %Receive{}

      iex> get_receive!(456)
      ** (Ecto.NoResultsError)

  """
  def get_receive!(id), do: Repo.get!(Receive, id)

  @doc """
  Creates a receive.

  ## Examples

      iex> create_receive(%{field: value})
      {:ok, %Receive{}}

      iex> create_receive(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_receive(attrs \\ %{}) do
    %Receive{}
    |> Receive.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a receive.

  ## Examples

      iex> update_receive(receive, %{field: new_value})
      {:ok, %Receive{}}

      iex> update_receive(receive, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_receive(%Receive{} = receive, attrs) do
    receive
    |> Receive.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a receive.

  ## Examples

      iex> delete_receive(receive)
      {:ok, %Receive{}}

      iex> delete_receive(receive)
      {:error, %Ecto.Changeset{}}

  """
  def delete_receive(%Receive{} = receive) do
    Repo.delete(receive)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking receive changes.

  ## Examples

      iex> change_receive(receive)
      %Ecto.Changeset{data: %Receive{}}

  """
  def change_receive(%Receive{} = receive, attrs \\ %{}) do
    Receive.changeset(receive, attrs)
  end
end
