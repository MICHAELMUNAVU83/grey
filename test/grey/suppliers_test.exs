defmodule Grey.SuppliersTest do
  use Grey.DataCase

  alias Grey.Suppliers

  describe "suppliers" do
    alias Grey.Suppliers.Supplier

    import Grey.SuppliersFixtures

    @invalid_attrs %{description: nil, name: nil, status: nil}

    test "list_suppliers/0 returns all suppliers" do
      supplier = supplier_fixture()
      assert Suppliers.list_suppliers() == [supplier]
    end

    test "get_supplier!/1 returns the supplier with given id" do
      supplier = supplier_fixture()
      assert Suppliers.get_supplier!(supplier.id) == supplier
    end

    test "create_supplier/1 with valid data creates a supplier" do
      valid_attrs = %{description: "some description", name: "some name", status: "some status"}

      assert {:ok, %Supplier{} = supplier} = Suppliers.create_supplier(valid_attrs)
      assert supplier.description == "some description"
      assert supplier.name == "some name"
      assert supplier.status == "some status"
    end

    test "create_supplier/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Suppliers.create_supplier(@invalid_attrs)
    end

    test "update_supplier/2 with valid data updates the supplier" do
      supplier = supplier_fixture()
      update_attrs = %{description: "some updated description", name: "some updated name", status: "some updated status"}

      assert {:ok, %Supplier{} = supplier} = Suppliers.update_supplier(supplier, update_attrs)
      assert supplier.description == "some updated description"
      assert supplier.name == "some updated name"
      assert supplier.status == "some updated status"
    end

    test "update_supplier/2 with invalid data returns error changeset" do
      supplier = supplier_fixture()
      assert {:error, %Ecto.Changeset{}} = Suppliers.update_supplier(supplier, @invalid_attrs)
      assert supplier == Suppliers.get_supplier!(supplier.id)
    end

    test "delete_supplier/1 deletes the supplier" do
      supplier = supplier_fixture()
      assert {:ok, %Supplier{}} = Suppliers.delete_supplier(supplier)
      assert_raise Ecto.NoResultsError, fn -> Suppliers.get_supplier!(supplier.id) end
    end

    test "change_supplier/1 returns a supplier changeset" do
      supplier = supplier_fixture()
      assert %Ecto.Changeset{} = Suppliers.change_supplier(supplier)
    end
  end
end
