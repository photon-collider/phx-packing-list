defmodule PhxPackingListWeb.ItemLive do
  use PhxPackingListWeb, :live_component
  alias PhxPackingList.Packing

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_changeset()}
  end

  defp assign_changeset(%{assigns: %{item: item}} = socket) do
    assign(socket, :changeset, Packing.change_item(item))
  end

  def render(assigns) do
    ~H"""
    <div
      class="flex flex-row bg-white py-4 px-4 text-darkest justify-between"
      id={@id}
      data-id={@item.id}
    >
      <.form
        :let={f}
        for={@changeset}
        phx-submit="update-item"
        phx-change="update-item"
        phx-target={@myself}
      >
        <div class="flex flex-row items-center space-x-2">
          <.input type="checkbox" field={f[:packed]} id={"packed-#{@id}"} />
          <.input type="text" field={f[:name]} id={"name-#{@id}"} />
          <.input type="hidden" field={f[:packing_list_id]} id={"packing-list-id-#{@id}"} />
        </div>
      </.form>
      <button phx-click="delete-item" phx-target={@myself}>Delete</button>
    </div>
    """
  end

  def handle_event("update-item", %{"item" => item_params}, socket) do
    IO.puts(inspect(item_params))
    {:noreply, save_item(socket, item_params)}
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
