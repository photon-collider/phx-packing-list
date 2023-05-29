defmodule PhxPackingListWeb.PackingListLiveTest do
  use PhxPackingListWeb.ConnCase

  import Phoenix.LiveViewTest
  import PhxPackingList.PackingFixtures

  @create_attrs %{title: "some title"}
  @update_attrs %{title: "some updated title"}
  @invalid_attrs %{title: nil}

  defp create_packing_list(_) do
    packing_list = packing_list_fixture()
    %{packing_list: packing_list}
  end

  describe "Index" do
    setup [:create_packing_list]

    test "lists all packing_lists", %{conn: conn, packing_list: packing_list} do
      {:ok, _index_live, html} = live(conn, ~p"/packing_lists")

      assert html =~ "Listing Packing lists"
      assert html =~ packing_list.title
    end

    test "saves new packing_list", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/packing_lists")

      assert index_live |> element("a", "New Packing list") |> render_click() =~
               "New Packing list"

      assert_patch(index_live, ~p"/packing_lists/new")

      assert index_live
             |> form("#packing_list-form", packing_list: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#packing_list-form", packing_list: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/packing_lists")

      html = render(index_live)
      assert html =~ "Packing list created successfully"
      assert html =~ "some title"
    end

    test "updates packing_list in listing", %{conn: conn, packing_list: packing_list} do
      {:ok, index_live, _html} = live(conn, ~p"/packing_lists")

      assert index_live |> element("#packing_lists-#{packing_list.id} a", "Edit") |> render_click() =~
               "Edit Packing list"

      assert_patch(index_live, ~p"/packing_lists/#{packing_list}/edit")

      assert index_live
             |> form("#packing_list-form", packing_list: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#packing_list-form", packing_list: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/packing_lists")

      html = render(index_live)
      assert html =~ "Packing list updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes packing_list in listing", %{conn: conn, packing_list: packing_list} do
      {:ok, index_live, _html} = live(conn, ~p"/packing_lists")

      assert index_live |> element("#packing_lists-#{packing_list.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#packing_lists-#{packing_list.id}")
    end
  end

  describe "Show" do
    setup [:create_packing_list]

    test "displays packing_list", %{conn: conn, packing_list: packing_list} do
      {:ok, _show_live, html} = live(conn, ~p"/packing_lists/#{packing_list}")

      assert html =~ "Show Packing list"
      assert html =~ packing_list.title
    end

    test "updates packing_list within modal", %{conn: conn, packing_list: packing_list} do
      {:ok, show_live, _html} = live(conn, ~p"/packing_lists/#{packing_list}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Packing list"

      assert_patch(show_live, ~p"/packing_lists/#{packing_list}/show/edit")

      assert show_live
             |> form("#packing_list-form", packing_list: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#packing_list-form", packing_list: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/packing_lists/#{packing_list}")

      html = render(show_live)
      assert html =~ "Packing list updated successfully"
      assert html =~ "some updated title"
    end
  end
end
