defmodule GreyWeb.StorageLiveTest do
  use GreyWeb.ConnCase

  import Phoenix.LiveViewTest
  import Grey.StoragesFixtures

  @create_attrs %{
    active: "some active",
    name: "some name",
    description: "some description",
    item: "some item",
    gln: "some gln"
  }
  @update_attrs %{
    active: "some updated active",
    name: "some updated name",
    description: "some updated description",
    item: "some updated item",
    gln: "some updated gln"
  }
  @invalid_attrs %{active: nil, name: nil, description: nil, item: nil, gln: nil}

  defp create_storage(_) do
    storage = storage_fixture()
    %{storage: storage}
  end

  describe "Index" do
    setup [:create_storage]

    test "lists all storages", %{conn: conn, storage: storage} do
      {:ok, _index_live, html} = live(conn, Routes.storage_index_path(conn, :index))

      assert html =~ "Listing Storages"
      assert html =~ storage.active
    end

    test "saves new storage", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.storage_index_path(conn, :index))

      assert index_live |> element("a", "New Storage") |> render_click() =~
               "New Storage"

      assert_patch(index_live, Routes.storage_index_path(conn, :new))

      assert index_live
             |> form("#storage-form", storage: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#storage-form", storage: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.storage_index_path(conn, :index))

      assert html =~ "Storage created successfully"
      assert html =~ "some active"
    end

    test "updates storage in listing", %{conn: conn, storage: storage} do
      {:ok, index_live, _html} = live(conn, Routes.storage_index_path(conn, :index))

      assert index_live |> element("#storage-#{storage.id} a", "Edit") |> render_click() =~
               "Edit Storage"

      assert_patch(index_live, Routes.storage_index_path(conn, :edit, storage))

      assert index_live
             |> form("#storage-form", storage: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#storage-form", storage: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.storage_index_path(conn, :index))

      assert html =~ "Storage updated successfully"
      assert html =~ "some updated active"
    end

    test "deletes storage in listing", %{conn: conn, storage: storage} do
      {:ok, index_live, _html} = live(conn, Routes.storage_index_path(conn, :index))

      assert index_live |> element("#storage-#{storage.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#storage-#{storage.id}")
    end
  end

  describe "Show" do
    setup [:create_storage]

    test "displays storage", %{conn: conn, storage: storage} do
      {:ok, _show_live, html} = live(conn, Routes.storage_show_path(conn, :show, storage))

      assert html =~ "Show Storage"
      assert html =~ storage.active
    end

    test "updates storage within modal", %{conn: conn, storage: storage} do
      {:ok, show_live, _html} = live(conn, Routes.storage_show_path(conn, :show, storage))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Storage"

      assert_patch(show_live, Routes.storage_show_path(conn, :edit, storage))

      assert show_live
             |> form("#storage-form", storage: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#storage-form", storage: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.storage_show_path(conn, :show, storage))

      assert html =~ "Storage updated successfully"
      assert html =~ "some updated active"
    end
  end
end
