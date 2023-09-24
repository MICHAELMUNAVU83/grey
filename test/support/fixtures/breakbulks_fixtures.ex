defmodule Grey.BreakbulksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Grey.Breakbulks` context.
  """

  @doc """
  Generate a breakbulk.
  """
  def breakbulk_fixture(attrs \\ %{}) do
    {:ok, breakbulk} =
      attrs
      |> Enum.into(%{
        code: "some code",
        description: "some description",
        quantity: "some quantity",
        status: "some status",
        uom: "some uom"
      })
      |> Grey.Breakbulks.create_breakbulk()

    breakbulk
  end
end
