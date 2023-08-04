defmodule PhxPackingListWeb.PackingListLive.Form do
  use PhxPackingListWeb, :live_component

  alias PhxPackingList.Packing
  alias PhxPackingList.Packing.PackingList

  @impl true
  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_changeset()}
  end

  defp assign_changeset(socket) do
    changeset = Packing.change_packing_list(%PackingList{})

    assign(socket, :changeset, changeset)
  end

  defp assign_changeset(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :changeset, changeset)
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
    <.form :let={f} for={@changeset} id="create-trip" phx-submit="save-packing-list" phx-target={@myself}>

      <.input type="text" field={f[:title]} label="Trip Name"/>
      <.input type="textarea" field={f[:description]} label="Description" />
      <.input type="date" field={f[:start_date]} label="Start Date"/>
      <.input type="date" field={f[:end_date]} label="End Date"/>
      <.input type="text" field={f[:travel_destination]}  label="Travel Destination"/>
    <button phx-click={hide_modal(@modal_id)}>Submit</button>
    </.form>
    </div>
    """
  end

  @impl true

  def handle_event("save-packing-list", %{"packing_list" => packing_list_params}, socket) do
    inspect(packing_list_params)
    {:noreply, save_packing_list(socket, packing_list_params)}
    # {:noreply, socket}
  end

  def save_packing_list(socket, packing_list_params) do
    case Packing.create_packing_list(packing_list_params) do
      {:ok, packing_list} ->
        send(self(), {:new_packing_list, packing_list})
        socket

      {:error, %Ecto.Changeset{} = changeset} ->
        assign_changeset(socket, changeset)
    end
  end
end
