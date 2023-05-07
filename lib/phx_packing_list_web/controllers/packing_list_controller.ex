defmodule PhxPackingListWeb.PackingListController do
  use PhxPackingListWeb, :controller

  alias PhxPackingList.Packing
  alias PhxPackingList.Packing.PackingList

  def index(conn, _params) do
    packing_lists = Packing.list_packing_lists()
    render(conn, :index, packing_lists: packing_lists)
  end

  def new(conn, _params) do
    changeset = Packing.change_packing_list(%PackingList{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"packing_list" => packing_list_params}) do
    case Packing.create_packing_list(packing_list_params) do
      {:ok, packing_list} ->
        conn
        |> put_flash(:info, "Packing list created successfully.")
        |> redirect(to: ~p"/packing_lists/#{packing_list}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    packing_list = Packing.get_packing_list!(id)
    render(conn, :show, packing_list: packing_list)
  end

  def edit(conn, %{"id" => id}) do
    packing_list = Packing.get_packing_list!(id)
    changeset = Packing.change_packing_list(packing_list)
    render(conn, :edit, packing_list: packing_list, changeset: changeset)
  end

  def update(conn, %{"id" => id, "packing_list" => packing_list_params}) do
    packing_list = Packing.get_packing_list!(id)

    case Packing.update_packing_list(packing_list, packing_list_params) do
      {:ok, packing_list} ->
        conn
        |> put_flash(:info, "Packing list updated successfully.")
        |> redirect(to: ~p"/packing_lists/#{packing_list}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, packing_list: packing_list, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    packing_list = Packing.get_packing_list!(id)
    {:ok, _packing_list} = Packing.delete_packing_list(packing_list)

    conn
    |> put_flash(:info, "Packing list deleted successfully.")
    |> redirect(to: ~p"/packing_lists")
  end
end
