defmodule GreyWeb.RetailerLiveTest do
  use GreyWeb.ConnCase

  import Phoenix.LiveViewTest
  import Grey.RetailersFixtures

  @create_attrs %{description: "some description", location: "some location", name: "some name", status: "some status"}
  @update_attrs %{description: "some updated description", location: "some updated location", name: "some updated name", status: "some updated status"}
  @invalid_attrs %{description: nil, location: nil, name: nil, status: nil}

  defp create_retailer(_) do
    retailer = retailer_fixture()
    %{retailer: retailer}
  end

  describe "Index" do
    setup [:create_retailer]

    test "lists all retailers", %{conn: conn, retailer: retailer} do
      {:ok, _index_live, html} = live(conn, Routes.retailer_index_path(conn, :index))

      assert html =~ "Listing Retailers"
      assert html =~ retailer.description
    end

    test "saves new retailer", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.retailer_index_path(conn, :index))

      assert index_live |> element("a", "New Retailer") |> render_click() =~
               "New Retailer"

      assert_patch(index_live, Routes.retailer_index_path(conn, :new))

      assert index_live
             |> form("#retailer-form", retailer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#retailer-form", retailer: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.retailer_index_path(conn, :index))

      assert html =~ "Retailer created successfully"
      assert html =~ "some description"
    end

    test "updates retailer in listing", %{conn: conn, retailer: retailer} do
      {:ok, index_live, _html} = live(conn, Routes.retailer_index_path(conn, :index))

      assert index_live |> element("#retailer-#{retailer.id} a", "Edit") |> render_click() =~
               "Edit Retailer"

      assert_patch(index_live, Routes.retailer_index_path(conn, :edit, retailer))

      assert index_live
             |> form("#retailer-form", retailer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#retailer-form", retailer: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.retailer_index_path(conn, :index))

      assert html =~ "Retailer updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes retailer in listing", %{conn: conn, retailer: retailer} do
      {:ok, index_live, _html} = live(conn, Routes.retailer_index_path(conn, :index))

      assert index_live |> element("#retailer-#{retailer.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#retailer-#{retailer.id}")
    end
  end

  describe "Show" do
    setup [:create_retailer]

    test "displays retailer", %{conn: conn, retailer: retailer} do
      {:ok, _show_live, html} = live(conn, Routes.retailer_show_path(conn, :show, retailer))

      assert html =~ "Show Retailer"
      assert html =~ retailer.description
    end

    test "updates retailer within modal", %{conn: conn, retailer: retailer} do
      {:ok, show_live, _html} = live(conn, Routes.retailer_show_path(conn, :show, retailer))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Retailer"

      assert_patch(show_live, Routes.retailer_show_path(conn, :edit, retailer))

      assert show_live
             |> form("#retailer-form", retailer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#retailer-form", retailer: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.retailer_show_path(conn, :show, retailer))

      assert html =~ "Retailer updated successfully"
      assert html =~ "some updated description"
    end
  end
end
