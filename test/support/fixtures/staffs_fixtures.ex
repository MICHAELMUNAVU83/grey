defmodule Grey.StaffsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Grey.Staffs` context.
  """

  @doc """
  Generate a staff.
  """
  def staff_fixture(attrs \\ %{}) do
    {:ok, staff} =
      attrs
      |> Enum.into(%{
        active: true,
        serial: "some serial",
        firstname: "some firstname",
        lastname: "some lastname",
        email: "some email",
        phone: "some phone",
        passcode: "some passcode",
        nationalid: "some nationalid",
        dob: "some dob",
        decsription: "some decsription"
      })
      |> Grey.Staffs.create_staff()

    staff
  end
end
