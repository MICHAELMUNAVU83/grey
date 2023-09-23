defmodule Grey.StaffsTest do
  use Grey.DataCase

  alias Grey.Staffs

  describe "staff" do
    alias Grey.Staffs.Staff

    import Grey.StaffsFixtures

    @invalid_attrs %{
      active: nil,
      serial: nil,
      firstname: nil,
      lastname: nil,
      email: nil,
      phone: nil,
      passcode: nil,
      nationalid: nil,
      dob: nil,
      decsription: nil
    }

    test "list_staff/0 returns all staff" do
      staff = staff_fixture()
      assert Staffs.list_staff() == [staff]
    end

    test "get_staff!/1 returns the staff with given id" do
      staff = staff_fixture()
      assert Staffs.get_staff!(staff.id) == staff
    end

    test "create_staff/1 with valid data creates a staff" do
      valid_attrs = %{
        active: true,
        serial: "some serial",
        firstname: "some firstname",
        lastname: "some lastname",
        email: "some email",
        phone: "some phone",
        passcode: "some passcode",
        nationalid: "some nationalid",
        dob: "some dob",
        decsription: "some decsription"
      }

      assert {:ok, %Staff{} = staff} = Staffs.create_staff(valid_attrs)
      assert staff.active == true
      assert staff.serial == "some serial"
      assert staff.firstname == "some firstname"
      assert staff.lastname == "some lastname"
      assert staff.email == "some email"
      assert staff.phone == "some phone"
      assert staff.passcode == "some passcode"
      assert staff.nationalid == "some nationalid"
      assert staff.dob == "some dob"
      assert staff.decsription == "some decsription"
    end

    test "create_staff/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Staffs.create_staff(@invalid_attrs)
    end

    test "update_staff/2 with valid data updates the staff" do
      staff = staff_fixture()

      update_attrs = %{
        active: false,
        serial: "some updated serial",
        firstname: "some updated firstname",
        lastname: "some updated lastname",
        email: "some updated email",
        phone: "some updated phone",
        passcode: "some updated passcode",
        nationalid: "some updated nationalid",
        dob: "some updated dob",
        decsription: "some updated decsription"
      }

      assert {:ok, %Staff{} = staff} = Staffs.update_staff(staff, update_attrs)
      assert staff.active == false
      assert staff.serial == "some updated serial"
      assert staff.firstname == "some updated firstname"
      assert staff.lastname == "some updated lastname"
      assert staff.email == "some updated email"
      assert staff.phone == "some updated phone"
      assert staff.passcode == "some updated passcode"
      assert staff.nationalid == "some updated nationalid"
      assert staff.dob == "some updated dob"
      assert staff.decsription == "some updated decsription"
    end

    test "update_staff/2 with invalid data returns error changeset" do
      staff = staff_fixture()
      assert {:error, %Ecto.Changeset{}} = Staffs.update_staff(staff, @invalid_attrs)
      assert staff == Staffs.get_staff!(staff.id)
    end

    test "delete_staff/1 deletes the staff" do
      staff = staff_fixture()
      assert {:ok, %Staff{}} = Staffs.delete_staff(staff)
      assert_raise Ecto.NoResultsError, fn -> Staffs.get_staff!(staff.id) end
    end

    test "change_staff/1 returns a staff changeset" do
      staff = staff_fixture()
      assert %Ecto.Changeset{} = Staffs.change_staff(staff)
    end
  end
end
