defmodule PhxPackingListWeb.PackingListLive.FormComponent do
  use PhxPackingListWeb, :live_component

  alias PhxPackingList.Packing

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage packing_list records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="packing_list-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Packing list</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{packing_list: packing_list} = assigns, socket) do
    changeset = Packing.change_packing_list(packing_list)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"packing_list" => packing_list_params}, socket) do
    changeset =
      socket.assigns.packing_list
      |> Packing.change_packing_list(packing_list_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"packing_list" => packing_list_params}, socket) do
    save_packing_list(socket, socket.assigns.action, packing_list_params)
  end

  defp save_packing_list(socket, :edit, packing_list_params) do
    case Packing.update_packing_list(socket.assigns.packing_list, packing_list_params) do
      {:ok, packing_list} ->
        notify_parent({:saved, packing_list})

        {:noreply,
         socket
         |> put_flash(:info, "Packing list updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_packing_list(socket, :new, packing_list_params) do
    case Packing.create_packing_list(packing_list_params) do
      {:ok, packing_list} ->
        notify_parent({:saved, packing_list})

        {:noreply,
         socket
         |> put_flash(:info, "Packing list created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
