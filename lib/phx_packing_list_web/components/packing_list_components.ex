defmodule PhxPackingListWeb.PackingListComponents do
  use PhxPackingListWeb, :html
  alias Phoenix.LiveView.JS

  def packing_lists_menu(assigns) do
    ~H"""
    <.header>
      Listing Packing Lists
      <:actions>
        <.link href={~p"/packing_lists/new/"}>
          <.button>New Packing List</.button>
        </.link>
      </:actions>
    </.header>

    <.table
      id="packing_lists"
      rows={@packing_lists}
      row_click={&JS.navigate(~p"/packing_lists/#{&1}")}
    >
      <:col :let={packing_list} label="Name"><%= packing_list.name %></:col>
      <:col :let={packing_list} label="Notes"><%= packing_list.notes %></:col>
      <:action :let={packing_list}>
        <div class="sr-only">
          <.link navigate={~p"/packing_lists/#{packing_list}/edit"}>Edit</.link>
        </div>
        <.link navigate={~p"/packing_lists/#{packing_list}/edit"}>Edit</.link>
      </:action>
      <:action :let={packing_list}>
        <.link href={~p"/packing_lists/#{packing_list}"} method="delete" data-confirm="Are you sure?">
          Delete
        </.link>
      </:action>
    </.table>
    """
  end

  attr :packing_list, :map, required: true
  attr :items, :list, required: true

  def packing_list(assigns) do
    ~H"""
    <.list>
      <:item title="Title"><%= @packing_list.title %></:item>
      <:item title="Travel Destination"><%= @packing_list.travel_destination %></:item>
      <:item title="Description"><%= @packing_list.description %></:item>
      <:item title="Start date"><%= @packing_list.start_date %></:item>
      <:item title="End date"><%= @packing_list.end_date %></:item>
    </.list>

    <.items items={@items} packing_list_id={@packing_list.id} />
    """
  end

  attr :items, :list, required: true
  attr :packing_list_id, :integer, required: true

  def items(assigns) do
    ~H"""
    <.header>
      Items
    </.header>

    <.table
      id="items"
      rows={@items}
      row_click={&JS.navigate(~p"/packing_lists/#{@packing_list_id}/items/#{&1}/edit")}
    >
      <:col :let={item} label="Name"><%= item.name %></:col>
      <:col :let={item} label="Quantity"><%= item.quantity %></:col>
      <:col :let={item} label="Notes"><%= item.notes %></:col>
      <:col :let={item} label="Packed"><%= item.packed %></:col>

      <:action :let={item}>
        <div class="sr-only">
          <.link navigate={~p"/packing_lists/#{@packing_list_id}/items/#{item}/edit"}>Edit</.link>
        </div>
        <.link navigate={~p"/packing_lists/#{@packing_list_id}/items/#{item}/edit"}>Edit</.link>
      </:action>
      <:action :let={item}>
        <.link
          href={~p"/packing_lists/#{@packing_list_id}/items/#{item}"}
          method="delete"
          data-confirm="Are you sure?"
        >
          Delete
        </.link>
      </:action>
    </.table>
    """
  end
end
