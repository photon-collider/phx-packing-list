defmodule PhxPackingListWeb.PackingListLive.Show do
  use PhxPackingListWeb, :live_view

  alias PhxPackingList.Packing

  import PhxPackingListWeb.PackingListComponents

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:packing_list, Packing.get_packing_list!(id))
     |> assign(:items, Packing.list_items_for_packing_list(id))}
  end

  defp page_title(:show), do: "Show Packing list"
  defp page_title(:edit), do: "Edit Packing list"
end
