defmodule GreyWeb.DispatchLiveTest do
  use GreyWeb.ConnCase

  import Phoenix.LiveViewTest
  import Grey.DispatchesFixtures

  @create_attrs %{batch: "some batch", companies: "some companies", description: "some description", expiry: "some expiry", gtin: "some gtin", image: "some image", name: "some name", production: "some production", quantity: "some quantity", rack: "some rack", status: "some status", transporter: "some transporter", transporterid: "some transporterid", uom: "some uom", weight: "some weight"}
  @update_attrs %{batch: "some updated batch", companies: "some updated companies", description: "some updated description", expiry: "some updated expiry", gtin: "some updated gtin", image: "some updated image", name: "some updated name", production: "some updated production", quantity: "some updated quantity", rack: "some updated rack", status: "some updated status", transporter: "some updated transporter", transporterid: "some updated transporterid", uom: "some updated uom", weight: "some updated weight"}
  @invalid_attrs %{batch: nil, companies: nil, description: nil, expiry: nil, gtin: nil, image: nil, name: nil, production: nil, quantity: nil, rack: nil, status: nil, transporter: nil, transporterid: nil, uom: nil, weight: nil}

  defp create_dispatch(_) do
    dispatch = dispatch_fixture()
    %{dispatch: dispatch}
  end

  describe "Index" do
    setup [:create_dispatch]

    test "lists all dispatches", %{conn: conn, dispatch: dispatch} do
      {:ok, _index_live, html} = live(conn, Routes.dispatch_index_path(conn, :index))

      assert html =~ "Listing Dispatches"
      assert html =~ dispatch.batch
    end

    test "saves new dispatch", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.dispatch_index_path(conn, :index))

      assert index_live |> element("a", "New Dispatch") |> render_click() =~
               "New Dispatch"

      assert_patch(index_live, Routes.dispatch_index_path(conn, :new))

      assert index_live
             |> form("#dispatch-form", dispatch: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#dispatch-form", dispatch: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.dispatch_index_path(conn, :index))

      assert html =~ "Dispatch created successfully"
      assert html =~ "some batch"
    end

    test "updates dispatch in listing", %{conn: conn, dispatch: dispatch} do
      {:ok, index_live, _html} = live(conn, Routes.dispatch_index_path(conn, :index))

      assert index_live |> element("#dispatch-#{dispatch.id} a", "Edit") |> render_click() =~
               "Edit Dispatch"

      assert_patch(index_live, Routes.dispatch_index_path(conn, :edit, dispatch))

      assert index_live
             |> form("#dispatch-form", dispatch: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#dispatch-form", dispatch: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.dispatch_index_path(conn, :index))

      assert html =~ "Dispatch updated successfully"
      assert html =~ "some updated batch"
    end

    test "deletes dispatch in listing", %{conn: conn, dispatch: dispatch} do
      {:ok, index_live, _html} = live(conn, Routes.dispatch_index_path(conn, :index))

      assert index_live |> element("#dispatch-#{dispatch.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#dispatch-#{dispatch.id}")
    end
  end

  describe "Show" do
    setup [:create_dispatch]

    test "displays dispatch", %{conn: conn, dispatch: dispatch} do
      {:ok, _show_live, html} = live(conn, Routes.dispatch_show_path(conn, :show, dispatch))

      assert html =~ "Show Dispatch"
      assert html =~ dispatch.batch
    end

    test "updates dispatch within modal", %{conn: conn, dispatch: dispatch} do
      {:ok, show_live, _html} = live(conn, Routes.dispatch_show_path(conn, :show, dispatch))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Dispatch"

      assert_patch(show_live, Routes.dispatch_show_path(conn, :edit, dispatch))

      assert show_live
             |> form("#dispatch-form", dispatch: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#dispatch-form", dispatch: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.dispatch_show_path(conn, :show, dispatch))

      assert html =~ "Dispatch updated successfully"
      assert html =~ "some updated batch"
    end
  end
end
