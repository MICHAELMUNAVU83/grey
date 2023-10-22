defmodule GreyWeb.ReceiveLiveTest do
  use GreyWeb.ConnCase

  import Phoenix.LiveViewTest
  import Grey.ReceivesFixtures

  @create_attrs %{
    active: "some active",
    batch: "some batch",
    description: "some description",
    expiry: %{day: 21, month: 10, year: 2023},
    gtin: 42,
    name: "some name",
    production: %{day: 21, month: 10, year: 2023},
    qty: 120.5,
    uom: "some uom",
    weight: 120.5
  }
  @update_attrs %{
    active: "some updated active",
    batch: "some updated batch",
    description: "some updated description",
    expiry: %{day: 22, month: 10, year: 2023},
    gtin: 43,
    name: "some updated name",
    production: %{day: 22, month: 10, year: 2023},
    qty: 456.7,
    uom: "some updated uom",
    weight: 456.7
  }
  @invalid_attrs %{
    active: nil,
    batch: nil,
    description: nil,
    expiry: %{day: 30, month: 2, year: 2023},
    gtin: nil,
    name: nil,
    production: %{day: 30, month: 2, year: 2023},
    qty: nil,
    uom: nil,
    weight: nil
  }

  defp create_receive(_) do
    receive = receive_fixture()
    %{receive: receive}
  end

  describe "Index" do
    setup [:create_receive]

    test "lists all receives", %{conn: conn, receive: receive} do
      {:ok, _index_live, html} = live(conn, Routes.receive_index_path(conn, :index))

      assert html =~ "Listing Receives"
      assert html =~ receive.active
    end

    test "saves new receive", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.receive_index_path(conn, :index))

      assert index_live |> element("a", "New Receive") |> render_click() =~
               "New Receive"

      assert_patch(index_live, Routes.receive_index_path(conn, :new))

      assert index_live
             |> form("#receive-form", receive: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#receive-form", receive: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.receive_index_path(conn, :index))

      assert html =~ "Receive created successfully"
      assert html =~ "some active"
    end

    test "updates receive in listing", %{conn: conn, receive: receive} do
      {:ok, index_live, _html} = live(conn, Routes.receive_index_path(conn, :index))

      assert index_live |> element("#receive-#{receive.id} a", "Edit") |> render_click() =~
               "Edit Receive"

      assert_patch(index_live, Routes.receive_index_path(conn, :edit, receive))

      assert index_live
             |> form("#receive-form", receive: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#receive-form", receive: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.receive_index_path(conn, :index))

      assert html =~ "Receive updated successfully"
      assert html =~ "some updated active"
    end

    test "deletes receive in listing", %{conn: conn, receive: receive} do
      {:ok, index_live, _html} = live(conn, Routes.receive_index_path(conn, :index))

      assert index_live |> element("#receive-#{receive.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#receive-#{receive.id}")
    end
  end

  describe "Show" do
    setup [:create_receive]

    test "displays receive", %{conn: conn, receive: receive} do
      {:ok, _show_live, html} = live(conn, Routes.receive_show_path(conn, :show, receive))

      assert html =~ "Show Receive"
      assert html =~ receive.active
    end

    test "updates receive within modal", %{conn: conn, receive: receive} do
      {:ok, show_live, _html} = live(conn, Routes.receive_show_path(conn, :show, receive))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Receive"

      assert_patch(show_live, Routes.receive_show_path(conn, :edit, receive))

      assert show_live
             |> form("#receive-form", receive: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        show_live
        |> form("#receive-form", receive: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.receive_show_path(conn, :show, receive))

      assert html =~ "Receive updated successfully"
      assert html =~ "some updated active"
    end
  end
end
