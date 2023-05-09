defmodule PhxPackingListWeb.PackingListControllerTest do
  use PhxPackingListWeb.ConnCase

  import PhxPackingList.PackingFixtures

  @create_attrs %{
    description: "some description",
    end_date: ~D[2023-05-06],
    start_date: ~D[2023-05-06],
    title: "some title"
  }
  @update_attrs %{
    description: "some updated description",
    end_date: ~D[2023-05-07],
    start_date: ~D[2023-05-07],
    title: "some updated title"
  }
  @invalid_attrs %{description: nil, end_date: nil, start_date: nil, title: nil}

  describe "index" do
    test "lists all packing_lists", %{conn: conn} do
      conn = get(conn, ~p"/packing_lists")
      assert html_response(conn, 200) =~ "Listing Packing lists"
    end
  end

  describe "new packing_list" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/packing_lists/new")
      assert html_response(conn, 200) =~ "New Packing list"
    end
  end

  describe "create packing_list" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/packing_lists", packing_list: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/packing_lists/#{id}"

      conn = get(conn, ~p"/packing_lists/#{id}")
      assert html_response(conn, 200) =~ "Packing list #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/packing_lists", packing_list: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Packing list"
    end
  end

  describe "edit packing_list" do
    setup [:create_packing_list]

    test "renders form for editing chosen packing_list", %{conn: conn, packing_list: packing_list} do
      conn = get(conn, ~p"/packing_lists/#{packing_list}/edit")
      assert html_response(conn, 200) =~ "Edit Packing list"
    end
  end

  describe "update packing_list" do
    setup [:create_packing_list]

    test "redirects when data is valid", %{conn: conn, packing_list: packing_list} do
      conn = put(conn, ~p"/packing_lists/#{packing_list}", packing_list: @update_attrs)
      assert redirected_to(conn) == ~p"/packing_lists/#{packing_list}"

      conn = get(conn, ~p"/packing_lists/#{packing_list}")
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, packing_list: packing_list} do
      conn = put(conn, ~p"/packing_lists/#{packing_list}", packing_list: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Packing list"
    end
  end

  describe "delete packing_list" do
    setup [:create_packing_list]

    test "deletes chosen packing_list", %{conn: conn, packing_list: packing_list} do
      conn = delete(conn, ~p"/packing_lists/#{packing_list}")
      assert redirected_to(conn) == ~p"/packing_lists"

      assert_error_sent 404, fn ->
        get(conn, ~p"/packing_lists/#{packing_list}")
      end
    end
  end

  defp create_packing_list(_) do
    packing_list = packing_list_fixture()
    %{packing_list: packing_list}
  end
end
