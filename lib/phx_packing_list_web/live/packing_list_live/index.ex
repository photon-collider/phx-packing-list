defmodule PhxPackingListWeb.PackingListLive.Index do
  use PhxPackingListWeb, :live_view

  alias PhxPackingList.Packing
  alias PhxPackingList.Packing.PackingList
  alias PhxPackingListWeb.PackingListLive.FormComponent
  alias PhxPackingListWeb.PackingListLive

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> stream(:packing_lists, Packing.list_packing_lists())
     |> assign_modal_form_id()}
  end

  defp assign_modal_form_id(socket) do
    socket
    |> assign(:modal_form_id, "create-trip-modal")
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Packing list")
    |> assign(:packing_list, %PackingList{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Packing lists")
    |> assign(:packing_list, nil)
  end

  @impl true
  def handle_info({:new_packing_list, packing_list}, socket) do
    {:noreply, stream_insert(socket, :packing_lists, packing_list)}
  end

  @impl true
  def handle_info(
        {PhxPackingListWeb.PackingListLive.FormComponent, {:saved, packing_list}},
        socket
      ) do
    {:noreply, stream_insert(socket, :packing_lists, packing_list)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    packing_list = Packing.get_packing_list!(id)
    {:ok, _} = Packing.delete_packing_list(packing_list)

    {:noreply, stream_delete(socket, :packing_lists, packing_list)}
  end

  def trip_card(assigns) do
    ~H"""
    <div class="w-64 bg-white rounded-md shadow-md overflow-hidden my-4" id={"trip-#{@trip.id}"}>
      <div class="">
        <div class="p-8">
          <div class="uppercase tracking-wide text-sm text-dark font-semibold">
            <%= @trip.travel_destination %>
          </div>
          <.link
            patch={~p"/packing_lists/#{@trip.id}/edit"}
            class="block mt-1 text-lg leading-tight font-medium text-darkest hover:underline"
          >
            <%= @trip.title %>
          </.link>
          <p class="mt-2 text-medium"><%= @trip.description %></p>
          <div class="mt-4 space-x-2">
            <button class="text-primary text-base border border-primary rounded px-2 py-1">
              <.link navigate={~p"/packing_lists/#{@trip.id}/edit"}>Edit</.link>
            </button>
            <button class="text-primary text-base border border-primary rounded px-2 py-1">
              <.link
                phx-click={JS.push("delete", value: %{id: @trip.id}) |> hide("#trip-#{@trip.id}")}
                data-confirm="Are you sure?"
              >
                Delete
              </.link>
            </button>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
