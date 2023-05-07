defmodule PhxPackingList.PackingTest do
  use PhxPackingList.DataCase

  alias PhxPackingList.Packing

  describe "packing_lists" do
    alias PhxPackingList.Packing.PackingList

    import PhxPackingList.PackingFixtures

    @invalid_attrs %{description: nil, end_date: nil, start_date: nil, title: nil}

    test "list_packing_lists/0 returns all packing_lists" do
      packing_list = packing_list_fixture()
      assert Packing.list_packing_lists() == [packing_list]
    end

    test "get_packing_list!/1 returns the packing_list with given id" do
      packing_list = packing_list_fixture()
      assert Packing.get_packing_list!(packing_list.id) == packing_list
    end

    test "create_packing_list/1 with valid data creates a packing_list" do
      valid_attrs = %{description: "some description", end_date: ~D[2023-05-06], start_date: ~D[2023-05-06], title: "some title"}

      assert {:ok, %PackingList{} = packing_list} = Packing.create_packing_list(valid_attrs)
      assert packing_list.description == "some description"
      assert packing_list.end_date == ~D[2023-05-06]
      assert packing_list.start_date == ~D[2023-05-06]
      assert packing_list.title == "some title"
    end

    test "create_packing_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Packing.create_packing_list(@invalid_attrs)
    end

    test "update_packing_list/2 with valid data updates the packing_list" do
      packing_list = packing_list_fixture()
      update_attrs = %{description: "some updated description", end_date: ~D[2023-05-07], start_date: ~D[2023-05-07], title: "some updated title"}

      assert {:ok, %PackingList{} = packing_list} = Packing.update_packing_list(packing_list, update_attrs)
      assert packing_list.description == "some updated description"
      assert packing_list.end_date == ~D[2023-05-07]
      assert packing_list.start_date == ~D[2023-05-07]
      assert packing_list.title == "some updated title"
    end

    test "update_packing_list/2 with invalid data returns error changeset" do
      packing_list = packing_list_fixture()
      assert {:error, %Ecto.Changeset{}} = Packing.update_packing_list(packing_list, @invalid_attrs)
      assert packing_list == Packing.get_packing_list!(packing_list.id)
    end

    test "delete_packing_list/1 deletes the packing_list" do
      packing_list = packing_list_fixture()
      assert {:ok, %PackingList{}} = Packing.delete_packing_list(packing_list)
      assert_raise Ecto.NoResultsError, fn -> Packing.get_packing_list!(packing_list.id) end
    end

    test "change_packing_list/1 returns a packing_list changeset" do
      packing_list = packing_list_fixture()
      assert %Ecto.Changeset{} = Packing.change_packing_list(packing_list)
    end
  end
end
