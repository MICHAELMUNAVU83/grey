defmodule GreyWeb.ReturnLiveTest do
  use GreyWeb.ConnCase

  import Phoenix.LiveViewTest
  import Grey.ReturnsFixtures

  @create_attrs %{
    item: "some item",
    name: "some name",
    phone: "some phone",
    quantity: "some quantity",
    reason: "some reason",
    status: "some status"
  }
  @update_attrs %{
    item: "some updated item",
    name: "some updated name",
    phone: "some updated phone",
    quantity: "some updated quantity",
    reason: "some updated reason",
    status: "some updated status"
  }
  @invalid_attrs %{item: nil, name: nil, phone: nil, quantity: nil, reason: nil, status: nil}

  defp create_return(_) do
    return = return_fixture()
    %{return: return}
  end

  describe "Index" do
    setup [:create_return]

    test "lists all returns", %{conn: conn, return: return} do
      {:ok, _index_live, html} = live(conn, Routes.return_index_path(conn, :index))

      assert html =~ "Listing Returns"
      assert html =~ return.item
    end

    test "saves new return", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.return_index_path(conn, :index))

      assert index_live |> element("a", "New Return") |> render_click() =~
               "New Return"

      assert_patch(index_live, Routes.return_index_path(conn, :new))

      assert index_live
             |> form("#return-form", return: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#return-form", return: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.return_index_path(conn, :index))

      assert html =~ "Return created successfully"
      assert html =~ "some item"
    end

    test "updates return in listing", %{conn: conn, return: return} do
      {:ok, index_live, _html} = live(conn, Routes.return_index_path(conn, :index))

      assert index_live |> element("#return-#{return.id} a", "Edit") |> render_click() =~
               "Edit Return"

      assert_patch(index_live, Routes.return_index_path(conn, :edit, return))

      assert index_live
             |> form("#return-form", return: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#return-form", return: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.return_index_path(conn, :index))

      assert html =~ "Return updated successfully"
      assert html =~ "some updated item"
    end

    test "deletes return in listing", %{conn: conn, return: return} do
      {:ok, index_live, _html} = live(conn, Routes.return_index_path(conn, :index))

      assert index_live |> element("#return-#{return.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#return-#{return.id}")
    end
  end

  describe "Show" do
    setup [:create_return]

    test "displays return", %{conn: conn, return: return} do
      {:ok, _show_live, html} = live(conn, Routes.return_show_path(conn, :show, return))

      assert html =~ "Show Return"
      assert html =~ return.item
    end

    test "updates return within modal", %{conn: conn, return: return} do
      {:ok, show_live, _html} = live(conn, Routes.return_show_path(conn, :show, return))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Return"

      assert_patch(show_live, Routes.return_show_path(conn, :edit, return))

      assert show_live
             |> form("#return-form", return: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#return-form", return: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.return_show_path(conn, :show, return))

      assert html =~ "Return updated successfully"
      assert html =~ "some updated item"
    end
  end
end
