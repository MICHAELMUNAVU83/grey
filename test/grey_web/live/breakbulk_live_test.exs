defmodule GreyWeb.BreakbulkLiveTest do
  use GreyWeb.ConnCase

  import Phoenix.LiveViewTest
  import Grey.BreakbulksFixtures

  @create_attrs %{
    code: "some code",
    description: "some description",
    quantity: "some quantity",
    status: "some status",
    uom: "some uom"
  }
  @update_attrs %{
    code: "some updated code",
    description: "some updated description",
    quantity: "some updated quantity",
    status: "some updated status",
    uom: "some updated uom"
  }
  @invalid_attrs %{code: nil, description: nil, quantity: nil, status: nil, uom: nil}

  defp create_breakbulk(_) do
    breakbulk = breakbulk_fixture()
    %{breakbulk: breakbulk}
  end

  describe "Index" do
    setup [:create_breakbulk]

    test "lists all breakbulks", %{conn: conn, breakbulk: breakbulk} do
      {:ok, _index_live, html} = live(conn, Routes.breakbulk_index_path(conn, :index))

      assert html =~ "Listing Breakbulks"
      assert html =~ breakbulk.code
    end

    test "saves new breakbulk", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.breakbulk_index_path(conn, :index))

      assert index_live |> element("a", "New Breakbulk") |> render_click() =~
               "New Breakbulk"

      assert_patch(index_live, Routes.breakbulk_index_path(conn, :new))

      assert index_live
             |> form("#breakbulk-form", breakbulk: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#breakbulk-form", breakbulk: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.breakbulk_index_path(conn, :index))

      assert html =~ "Breakbulk created successfully"
      assert html =~ "some code"
    end

    test "updates breakbulk in listing", %{conn: conn, breakbulk: breakbulk} do
      {:ok, index_live, _html} = live(conn, Routes.breakbulk_index_path(conn, :index))

      assert index_live |> element("#breakbulk-#{breakbulk.id} a", "Edit") |> render_click() =~
               "Edit Breakbulk"

      assert_patch(index_live, Routes.breakbulk_index_path(conn, :edit, breakbulk))

      assert index_live
             |> form("#breakbulk-form", breakbulk: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#breakbulk-form", breakbulk: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.breakbulk_index_path(conn, :index))

      assert html =~ "Breakbulk updated successfully"
      assert html =~ "some updated code"
    end

    test "deletes breakbulk in listing", %{conn: conn, breakbulk: breakbulk} do
      {:ok, index_live, _html} = live(conn, Routes.breakbulk_index_path(conn, :index))

      assert index_live |> element("#breakbulk-#{breakbulk.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#breakbulk-#{breakbulk.id}")
    end
  end

  describe "Show" do
    setup [:create_breakbulk]

    test "displays breakbulk", %{conn: conn, breakbulk: breakbulk} do
      {:ok, _show_live, html} = live(conn, Routes.breakbulk_show_path(conn, :show, breakbulk))

      assert html =~ "Show Breakbulk"
      assert html =~ breakbulk.code
    end

    test "updates breakbulk within modal", %{conn: conn, breakbulk: breakbulk} do
      {:ok, show_live, _html} = live(conn, Routes.breakbulk_show_path(conn, :show, breakbulk))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Breakbulk"

      assert_patch(show_live, Routes.breakbulk_show_path(conn, :edit, breakbulk))

      assert show_live
             |> form("#breakbulk-form", breakbulk: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#breakbulk-form", breakbulk: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.breakbulk_show_path(conn, :show, breakbulk))

      assert html =~ "Breakbulk updated successfully"
      assert html =~ "some updated code"
    end
  end
end
