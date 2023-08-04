defmodule PhxPackingListWeb.ItemLive do
  use PhxPackingListWeb, :live_component
  alias PhxPackingList.Packing

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_changeset()
     |> assign_display_id()}
  end

  defp assign_changeset(%{assigns: %{item: item}} = socket) do
    assign(socket, :changeset, Packing.change_item(item))
  end

  defp assign_display_id(%{assigns: %{item: item}} = socket) do
    assign(socket, :display_id, "display-#{item.id}")
  end

  def handle_event("update-item", %{"item" => item_params}, socket) do
    {:noreply, update_item(socket, item_params)}
  end

  def handle_event("delete-item", _params, socket) do
    {:noreply, delete_item(socket)}
  end

  defp update_item(%{assigns: %{item: item}} = socket, item_params) do
    case Packing.update_item(item, item_params) do
      {:ok, item} ->
        send(self(), {:updated_item, item})
        socket

      {:error, %Ecto.Changeset{} = _changeset} ->
        socket |> put_flash(:info, "Error: item not updated!")
    end
  end

  defp delete_item(%{assigns: %{item: item}} = socket) do
    case Packing.delete_item(item) do
      {:ok, item} ->
        send(self(), {:deleted_item, item})
        socket

      {:error, %Ecto.Changeset{} = _changeset} ->
        socket |> put_flash(:info, "Error: item not deleted!")
    end
  end
end
