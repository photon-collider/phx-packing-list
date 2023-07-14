defmodule PhxPackingListWeb.PackingListLive.Show do
  use PhxPackingListWeb, :live_view
  alias PhxPackingList.Packing
  alias PhxPackingListWeb.ItemLive

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:packing_list_id, id)
     |> assign(:packing_list, Packing.get_packing_list!(id))
     |> stream(:items, Packing.list_items_for_packing_list(id))}
  end

  @impl true
  def handle_event(
        "create-item",
        _params,
        %{assigns: %{packing_list_id: packing_list_id}} = socket
      ) do
    # create new item in DB
    {:ok, item} = Packing.create_item(%{packing_list_id: packing_list_id})

    # add to streams
    {:noreply,
     socket
     |> put_flash(:info, "Item Created!")
     |> stream_insert(:items, item, at: 0)}
  end

  @impl true
  def handle_event("reposition", params, socket) do
    # Put your logic here to deal with the changes to the list order
    # and persist the data
    IO.inspect(params)
    {:noreply, socket}
  end

  @impl true
  def handle_info({:updated_item, item}, socket) do
    {:noreply, handle_updated_item(socket, item)}
  end

  defp handle_updated_item(socket, item) do
    socket
    |> put_flash(:info, "Item updated!")
    |> stream_insert(:items, item)
  end

  def packing_list_header(assigns) do
    ~H"""
    <.list>
      <:item title="Title"><%= @packing_list.title %></:item>
      <:item title="Travel Destination"><%= @packing_list.travel_destination %></:item>
      <:item title="Description"><%= @packing_list.description %></:item>
      <:item title="Start date"><%= @packing_list.start_date %></:item>
      <:item title="End date"><%= @packing_list.end_date %></:item>
    </.list>
    """
  end

  defp page_title(:show), do: "Show Packing list"
  defp page_title(:edit), do: "Edit Packing list"
end
