defmodule Grey.SuppliersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Grey.Suppliers` context.
  """

  @doc """
  Generate a supplier.
  """
  def supplier_fixture(attrs \\ %{}) do
    {:ok, supplier} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name",
        status: "some status"
      })
      |> Grey.Suppliers.create_supplier()

    supplier
  end
end
