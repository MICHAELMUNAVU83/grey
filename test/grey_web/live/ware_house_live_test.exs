defmodule GreyWeb.WareHouseLiveTest do
  use GreyWeb.ConnCase

  import Phoenix.LiveViewTest
  import Grey.WareHousesFixtures

  @create_attrs %{active: true, name: "some name", description: "some description", location: "some location", category: "some category"}
  @update_attrs %{active: false, name: "some updated name", description: "some updated description", location: "some updated location", category: "some updated category"}
  @invalid_attrs %{active: false, name: nil, description: nil, location: nil, category: nil}

  defp create_ware_house(_) do
    ware_house = ware_house_fixture()
    %{ware_house: ware_house}
  end

  describe "Index" do
    setup [:create_ware_house]

    test "lists all warehouse", %{conn: conn, ware_house: ware_house} do
      {:ok, _index_live, html} = live(conn, Routes.ware_house_index_path(conn, :index))

      assert html =~ "Listing Warehouse"
      assert html =~ ware_house.name
    end

    test "saves new ware_house", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.ware_house_index_path(conn, :index))

      assert index_live |> element("a", "New Ware house") |> render_click() =~
               "New Ware house"

      assert_patch(index_live, Routes.ware_house_index_path(conn, :new))

      assert index_live
             |> form("#ware_house-form", ware_house: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#ware_house-form", ware_house: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.ware_house_index_path(conn, :index))

      assert html =~ "Ware house created successfully"
      assert html =~ "some name"
    end

    test "updates ware_house in listing", %{conn: conn, ware_house: ware_house} do
      {:ok, index_live, _html} = live(conn, Routes.ware_house_index_path(conn, :index))

      assert index_live |> element("#ware_house-#{ware_house.id} a", "Edit") |> render_click() =~
               "Edit Ware house"

      assert_patch(index_live, Routes.ware_house_index_path(conn, :edit, ware_house))

      assert index_live
             |> form("#ware_house-form", ware_house: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#ware_house-form", ware_house: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.ware_house_index_path(conn, :index))

      assert html =~ "Ware house updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes ware_house in listing", %{conn: conn, ware_house: ware_house} do
      {:ok, index_live, _html} = live(conn, Routes.ware_house_index_path(conn, :index))

      assert index_live |> element("#ware_house-#{ware_house.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#ware_house-#{ware_house.id}")
    end
  end

  describe "Show" do
    setup [:create_ware_house]

    test "displays ware_house", %{conn: conn, ware_house: ware_house} do
      {:ok, _show_live, html} = live(conn, Routes.ware_house_show_path(conn, :show, ware_house))

      assert html =~ "Show Ware house"
      assert html =~ ware_house.name
    end

    test "updates ware_house within modal", %{conn: conn, ware_house: ware_house} do
      {:ok, show_live, _html} = live(conn, Routes.ware_house_show_path(conn, :show, ware_house))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Ware house"

      assert_patch(show_live, Routes.ware_house_show_path(conn, :edit, ware_house))

      assert show_live
             |> form("#ware_house-form", ware_house: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#ware_house-form", ware_house: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.ware_house_show_path(conn, :show, ware_house))

      assert html =~ "Ware house updated successfully"
      assert html =~ "some updated name"
    end
  end
end
