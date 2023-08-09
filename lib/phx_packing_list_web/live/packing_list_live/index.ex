defmodule PhxPackingListWeb.PackingListLive.Index do
  use PhxPackingListWeb, :live_view

  alias PhxPackingList.Packing
  alias PhxPackingList.Packing.PackingList
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
    <div class="bg-white rounded-md shadow-sm overflow-hidden" id={"trip-#{@trip.id}"}>
      <div class="p-6 flex flex-col justify-between">
        <div>
          <div>
            <.link
              patch={~p"/packing_lists/#{@trip.id}/edit"}
              class="block text-lg leading-tight font-bold text-darkest hover:underline text-xl mb-4"
            >
              <%= @trip.title %>
            </.link>
          </div>
          <div class="flex flex-col gap-1 text-sm">
            <div>
              <div>
                <div class="flex flex-row items-center text-dark gap-1">
                  <.icon name="hero-map-pin" />
                  <span class="">
                    <%= @trip.travel_destination %>
                  </span>
                </div>
              </div>
            </div>

            <div class="flex flex-row items-center text-dark gap-1">
              <.icon name="hero-calendar" />
              <span class="">
                <%= @trip.start_date %>
              </span>
              <.icon name="hero-arrow-right" class="h-3 w-3" />
              <span class="">
                <%= @trip.end_date %>
              </span>
            </div>
          </div>
        </div>

        <div class="flex flex-row justify-between mt-4">
          <.link navigate={~p"/packing_lists/#{@trip.id}/edit"}>
            <button class="text-primary text-base border border-primary rounded px-2 py-1 flex flex-row items-center gap-1">
              <.icon name="hero-pencil-square" class="h-4 w-4" /> <span> Edit </span>
            </button>
          </.link>
          <.link
            phx-click={JS.push("delete", value: %{id: @trip.id}) |> hide("#trip-#{@trip.id}")}
            data-confirm="Are you sure?"
          >
            <button class="text-primary text-base border border-primary rounded px-2 py-1 flex flex-row items-center gap-1">
              <.icon name="hero-trash" />
              <span> Delete </span>
            </button>
          </.link>
        </div>
      </div>
    </div>
    """
  end
end
