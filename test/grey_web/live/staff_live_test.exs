defmodule GreyWeb.StaffLiveTest do
  use GreyWeb.ConnCase

  import Phoenix.LiveViewTest
  import Grey.StaffsFixtures

  @create_attrs %{active: true, serial: "some serial", firstname: "some firstname", lastname: "some lastname", email: "some email", phone: "some phone", passcode: "some passcode", nationalid: "some nationalid", dob: "some dob", decsription: "some decsription"}
  @update_attrs %{active: false, serial: "some updated serial", firstname: "some updated firstname", lastname: "some updated lastname", email: "some updated email", phone: "some updated phone", passcode: "some updated passcode", nationalid: "some updated nationalid", dob: "some updated dob", decsription: "some updated decsription"}
  @invalid_attrs %{active: false, serial: nil, firstname: nil, lastname: nil, email: nil, phone: nil, passcode: nil, nationalid: nil, dob: nil, decsription: nil}

  defp create_staff(_) do
    staff = staff_fixture()
    %{staff: staff}
  end

  describe "Index" do
    setup [:create_staff]

    test "lists all staff", %{conn: conn, staff: staff} do
      {:ok, _index_live, html} = live(conn, Routes.staff_index_path(conn, :index))

      assert html =~ "Listing Staff"
      assert html =~ staff.serial
    end

    test "saves new staff", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.staff_index_path(conn, :index))

      assert index_live |> element("a", "New Staff") |> render_click() =~
               "New Staff"

      assert_patch(index_live, Routes.staff_index_path(conn, :new))

      assert index_live
             |> form("#staff-form", staff: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#staff-form", staff: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.staff_index_path(conn, :index))

      assert html =~ "Staff created successfully"
      assert html =~ "some serial"
    end

    test "updates staff in listing", %{conn: conn, staff: staff} do
      {:ok, index_live, _html} = live(conn, Routes.staff_index_path(conn, :index))

      assert index_live |> element("#staff-#{staff.id} a", "Edit") |> render_click() =~
               "Edit Staff"

      assert_patch(index_live, Routes.staff_index_path(conn, :edit, staff))

      assert index_live
             |> form("#staff-form", staff: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#staff-form", staff: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.staff_index_path(conn, :index))

      assert html =~ "Staff updated successfully"
      assert html =~ "some updated serial"
    end

    test "deletes staff in listing", %{conn: conn, staff: staff} do
      {:ok, index_live, _html} = live(conn, Routes.staff_index_path(conn, :index))

      assert index_live |> element("#staff-#{staff.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#staff-#{staff.id}")
    end
  end

  describe "Show" do
    setup [:create_staff]

    test "displays staff", %{conn: conn, staff: staff} do
      {:ok, _show_live, html} = live(conn, Routes.staff_show_path(conn, :show, staff))

      assert html =~ "Show Staff"
      assert html =~ staff.serial
    end

    test "updates staff within modal", %{conn: conn, staff: staff} do
      {:ok, show_live, _html} = live(conn, Routes.staff_show_path(conn, :show, staff))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Staff"

      assert_patch(show_live, Routes.staff_show_path(conn, :edit, staff))

      assert show_live
             |> form("#staff-form", staff: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#staff-form", staff: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.staff_show_path(conn, :show, staff))

      assert html =~ "Staff updated successfully"
      assert html =~ "some updated serial"
    end
  end
end
