defmodule PhxPackingListWeb.ItemController do
  use PhxPackingListWeb, :controller

  alias PhxPackingList.Packing
  alias PhxPackingList.Packing.Item

  def index(conn, %{"packing_list_id" => packing_list_id}) do
    items = Packing.list_items_for_packing_list(packing_list_id)
    render(conn, :index, items: items, packing_list_id: packing_list_id)
  end

  def new(conn, %{"packing_list_id" => packing_list_id}) do
    changeset = Packing.change_item(%Item{})
    render(conn, :new, changeset: changeset, packing_list_id: packing_list_id)
  end

  def create(conn, %{"item" => item_params, "packing_list_id" => packing_list_id}) do
    case Packing.create_item(packing_list_id, item_params) do
      {:ok, _item} ->
        conn
        |> put_flash(:info, "Item created successfully.")
        |> redirect(to: ~p"/packing_lists/#{packing_list_id}/items/")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset, packing_list_id: packing_list_id)
    end
  end

  def show(conn, %{"id" => id, "packing_list_id" => packing_list_id}) do
    item = Packing.get_item!(packing_list_id, id)
    render(conn, :show, item: item)
  end

  def edit(conn, %{"id" => id, "packing_list_id" => packing_list_id}) do
    item = Packing.get_item!(packing_list_id, id)
    changeset = Packing.change_item(item)
    render(conn, :edit, item: item, changeset: changeset, packing_list_id: packing_list_id)
  end

  def update(conn, %{"packing_list_id" => packing_list_id, "id" => id, "item" => item_params}) do
    item = Packing.get_item!(packing_list_id, id)

    case Packing.update_item(item, item_params) do
      {:ok, _item} ->
        conn
        |> put_flash(:info, "Item updated successfully.")
        |> redirect(to: ~p"/packing_lists/#{packing_list_id}/items/")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, item: item, changeset: changeset)
    end
  end

  def delete(conn, %{"packing_list_id" => packing_list_id, "id" => id}) do
    item = Packing.get_item!(packing_list_id, id)
    {:ok, _item} = Packing.delete_item(item)

    conn
    |> put_flash(:info, "Item deleted successfully.")
    |> redirect(to: ~p"/packing_lists/#{packing_list_id}/items")
  end
end
