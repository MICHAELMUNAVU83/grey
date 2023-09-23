defmodule Grey.BreakbulksTest do
  use Grey.DataCase

  alias Grey.Breakbulks

  describe "breakbulks" do
    alias Grey.Breakbulks.Breakbulk

    import Grey.BreakbulksFixtures

    @invalid_attrs %{code: nil, description: nil, quantity: nil, status: nil, uom: nil}

    test "list_breakbulks/0 returns all breakbulks" do
      breakbulk = breakbulk_fixture()
      assert Breakbulks.list_breakbulks() == [breakbulk]
    end

    test "get_breakbulk!/1 returns the breakbulk with given id" do
      breakbulk = breakbulk_fixture()
      assert Breakbulks.get_breakbulk!(breakbulk.id) == breakbulk
    end

    test "create_breakbulk/1 with valid data creates a breakbulk" do
      valid_attrs = %{
        code: "some code",
        description: "some description",
        quantity: "some quantity",
        status: "some status",
        uom: "some uom"
      }

      assert {:ok, %Breakbulk{} = breakbulk} = Breakbulks.create_breakbulk(valid_attrs)
      assert breakbulk.code == "some code"
      assert breakbulk.description == "some description"
      assert breakbulk.quantity == "some quantity"
      assert breakbulk.status == "some status"
      assert breakbulk.uom == "some uom"
    end

    test "create_breakbulk/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Breakbulks.create_breakbulk(@invalid_attrs)
    end

    test "update_breakbulk/2 with valid data updates the breakbulk" do
      breakbulk = breakbulk_fixture()

      update_attrs = %{
        code: "some updated code",
        description: "some updated description",
        quantity: "some updated quantity",
        status: "some updated status",
        uom: "some updated uom"
      }

      assert {:ok, %Breakbulk{} = breakbulk} =
               Breakbulks.update_breakbulk(breakbulk, update_attrs)

      assert breakbulk.code == "some updated code"
      assert breakbulk.description == "some updated description"
      assert breakbulk.quantity == "some updated quantity"
      assert breakbulk.status == "some updated status"
      assert breakbulk.uom == "some updated uom"
    end

    test "update_breakbulk/2 with invalid data returns error changeset" do
      breakbulk = breakbulk_fixture()
      assert {:error, %Ecto.Changeset{}} = Breakbulks.update_breakbulk(breakbulk, @invalid_attrs)
      assert breakbulk == Breakbulks.get_breakbulk!(breakbulk.id)
    end

    test "delete_breakbulk/1 deletes the breakbulk" do
      breakbulk = breakbulk_fixture()
      assert {:ok, %Breakbulk{}} = Breakbulks.delete_breakbulk(breakbulk)
      assert_raise Ecto.NoResultsError, fn -> Breakbulks.get_breakbulk!(breakbulk.id) end
    end

    test "change_breakbulk/1 returns a breakbulk changeset" do
      breakbulk = breakbulk_fixture()
      assert %Ecto.Changeset{} = Breakbulks.change_breakbulk(breakbulk)
    end
  end
end
