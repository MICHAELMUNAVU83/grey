defmodule GreyWeb.VehicleLiveTest do
  use GreyWeb.ConnCase

  import Phoenix.LiveViewTest
  import Grey.VehiclesFixtures

  @create_attrs %{active: true, serial: "some serial", type: "some type", description: "some description", makeofcar: "some makeofcar", reg: "some reg"}
  @update_attrs %{active: false, serial: "some updated serial", type: "some updated type", description: "some updated description", makeofcar: "some updated makeofcar", reg: "some updated reg"}
  @invalid_attrs %{active: false, serial: nil, type: nil, description: nil, makeofcar: nil, reg: nil}

  defp create_vehicle(_) do
    vehicle = vehicle_fixture()
    %{vehicle: vehicle}
  end

  describe "Index" do
    setup [:create_vehicle]

    test "lists all vehicle", %{conn: conn, vehicle: vehicle} do
      {:ok, _index_live, html} = live(conn, Routes.vehicle_index_path(conn, :index))

      assert html =~ "Listing Vehicle"
      assert html =~ vehicle.serial
    end

    test "saves new vehicle", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.vehicle_index_path(conn, :index))

      assert index_live |> element("a", "New Vehicle") |> render_click() =~
               "New Vehicle"

      assert_patch(index_live, Routes.vehicle_index_path(conn, :new))

      assert index_live
             |> form("#vehicle-form", vehicle: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#vehicle-form", vehicle: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.vehicle_index_path(conn, :index))

      assert html =~ "Vehicle created successfully"
      assert html =~ "some serial"
    end

    test "updates vehicle in listing", %{conn: conn, vehicle: vehicle} do
      {:ok, index_live, _html} = live(conn, Routes.vehicle_index_path(conn, :index))

      assert index_live |> element("#vehicle-#{vehicle.id} a", "Edit") |> render_click() =~
               "Edit Vehicle"

      assert_patch(index_live, Routes.vehicle_index_path(conn, :edit, vehicle))

      assert index_live
             |> form("#vehicle-form", vehicle: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#vehicle-form", vehicle: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.vehicle_index_path(conn, :index))

      assert html =~ "Vehicle updated successfully"
      assert html =~ "some updated serial"
    end

    test "deletes vehicle in listing", %{conn: conn, vehicle: vehicle} do
      {:ok, index_live, _html} = live(conn, Routes.vehicle_index_path(conn, :index))

      assert index_live |> element("#vehicle-#{vehicle.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#vehicle-#{vehicle.id}")
    end
  end

  describe "Show" do
    setup [:create_vehicle]

    test "displays vehicle", %{conn: conn, vehicle: vehicle} do
      {:ok, _show_live, html} = live(conn, Routes.vehicle_show_path(conn, :show, vehicle))

      assert html =~ "Show Vehicle"
      assert html =~ vehicle.serial
    end

    test "updates vehicle within modal", %{conn: conn, vehicle: vehicle} do
      {:ok, show_live, _html} = live(conn, Routes.vehicle_show_path(conn, :show, vehicle))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Vehicle"

      assert_patch(show_live, Routes.vehicle_show_path(conn, :edit, vehicle))

      assert show_live
             |> form("#vehicle-form", vehicle: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#vehicle-form", vehicle: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.vehicle_show_path(conn, :show, vehicle))

      assert html =~ "Vehicle updated successfully"
      assert html =~ "some updated serial"
    end
  end
end
