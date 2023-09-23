defmodule GreyWeb.SupplierLiveTest do
  use GreyWeb.ConnCase

  import Phoenix.LiveViewTest
  import Grey.SuppliersFixtures

  @create_attrs %{description: "some description", name: "some name", status: "some status"}
  @update_attrs %{description: "some updated description", name: "some updated name", status: "some updated status"}
  @invalid_attrs %{description: nil, name: nil, status: nil}

  defp create_supplier(_) do
    supplier = supplier_fixture()
    %{supplier: supplier}
  end

  describe "Index" do
    setup [:create_supplier]

    test "lists all suppliers", %{conn: conn, supplier: supplier} do
      {:ok, _index_live, html} = live(conn, Routes.supplier_index_path(conn, :index))

      assert html =~ "Listing Suppliers"
      assert html =~ supplier.description
    end

    test "saves new supplier", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.supplier_index_path(conn, :index))

      assert index_live |> element("a", "New Supplier") |> render_click() =~
               "New Supplier"

      assert_patch(index_live, Routes.supplier_index_path(conn, :new))

      assert index_live
             |> form("#supplier-form", supplier: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#supplier-form", supplier: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.supplier_index_path(conn, :index))

      assert html =~ "Supplier created successfully"
      assert html =~ "some description"
    end

    test "updates supplier in listing", %{conn: conn, supplier: supplier} do
      {:ok, index_live, _html} = live(conn, Routes.supplier_index_path(conn, :index))

      assert index_live |> element("#supplier-#{supplier.id} a", "Edit") |> render_click() =~
               "Edit Supplier"

      assert_patch(index_live, Routes.supplier_index_path(conn, :edit, supplier))

      assert index_live
             |> form("#supplier-form", supplier: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#supplier-form", supplier: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.supplier_index_path(conn, :index))

      assert html =~ "Supplier updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes supplier in listing", %{conn: conn, supplier: supplier} do
      {:ok, index_live, _html} = live(conn, Routes.supplier_index_path(conn, :index))

      assert index_live |> element("#supplier-#{supplier.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#supplier-#{supplier.id}")
    end
  end

  describe "Show" do
    setup [:create_supplier]

    test "displays supplier", %{conn: conn, supplier: supplier} do
      {:ok, _show_live, html} = live(conn, Routes.supplier_show_path(conn, :show, supplier))

      assert html =~ "Show Supplier"
      assert html =~ supplier.description
    end

    test "updates supplier within modal", %{conn: conn, supplier: supplier} do
      {:ok, show_live, _html} = live(conn, Routes.supplier_show_path(conn, :show, supplier))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Supplier"

      assert_patch(show_live, Routes.supplier_show_path(conn, :edit, supplier))

      assert show_live
             |> form("#supplier-form", supplier: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#supplier-form", supplier: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.supplier_show_path(conn, :show, supplier))

      assert html =~ "Supplier updated successfully"
      assert html =~ "some updated description"
    end
  end
end
