defmodule GreyWeb.PutawayLiveTest do
  use GreyWeb.ConnCase

  import Phoenix.LiveViewTest
  import Grey.PutawaysFixtures

  @create_attrs %{item: "some item", rack: "some rack", status: "some status"}
  @update_attrs %{
    item: "some updated item",
    rack: "some updated rack",
    status: "some updated status"
  }
  @invalid_attrs %{item: nil, rack: nil, status: nil}

  defp create_putaway(_) do
    putaway = putaway_fixture()
    %{putaway: putaway}
  end

  describe "Index" do
    setup [:create_putaway]

    test "lists all putaways", %{conn: conn, putaway: putaway} do
      {:ok, _index_live, html} = live(conn, Routes.putaway_index_path(conn, :index))

      assert html =~ "Listing Putaways"
      assert html =~ putaway.item
    end

    test "saves new putaway", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.putaway_index_path(conn, :index))

      assert index_live |> element("a", "New Putaway") |> render_click() =~
               "New Putaway"

      assert_patch(index_live, Routes.putaway_index_path(conn, :new))

      assert index_live
             |> form("#putaway-form", putaway: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#putaway-form", putaway: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.putaway_index_path(conn, :index))

      assert html =~ "Putaway created successfully"
      assert html =~ "some item"
    end

    test "updates putaway in listing", %{conn: conn, putaway: putaway} do
      {:ok, index_live, _html} = live(conn, Routes.putaway_index_path(conn, :index))

      assert index_live |> element("#putaway-#{putaway.id} a", "Edit") |> render_click() =~
               "Edit Putaway"

      assert_patch(index_live, Routes.putaway_index_path(conn, :edit, putaway))

      assert index_live
             |> form("#putaway-form", putaway: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#putaway-form", putaway: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.putaway_index_path(conn, :index))

      assert html =~ "Putaway updated successfully"
      assert html =~ "some updated item"
    end

    test "deletes putaway in listing", %{conn: conn, putaway: putaway} do
      {:ok, index_live, _html} = live(conn, Routes.putaway_index_path(conn, :index))

      assert index_live |> element("#putaway-#{putaway.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#putaway-#{putaway.id}")
    end
  end

  describe "Show" do
    setup [:create_putaway]

    test "displays putaway", %{conn: conn, putaway: putaway} do
      {:ok, _show_live, html} = live(conn, Routes.putaway_show_path(conn, :show, putaway))

      assert html =~ "Show Putaway"
      assert html =~ putaway.item
    end

    test "updates putaway within modal", %{conn: conn, putaway: putaway} do
      {:ok, show_live, _html} = live(conn, Routes.putaway_show_path(conn, :show, putaway))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Putaway"

      assert_patch(show_live, Routes.putaway_show_path(conn, :edit, putaway))

      assert show_live
             |> form("#putaway-form", putaway: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#putaway-form", putaway: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.putaway_show_path(conn, :show, putaway))

      assert html =~ "Putaway updated successfully"
      assert html =~ "some updated item"
    end
  end
end
