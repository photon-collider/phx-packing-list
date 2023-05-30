defmodule PhxPackingListWeb.CustomComponents do
  use PhxPackingListWeb, :html
  use Phoenix.Component

  def header_menu(assigns) do
    ~H"""
    <header class="">
      <nav class="flex items-center justify-between px-4 py-4 bg-dark text-white sm:rounded-b-lg drop-shadow-md">
        <span class="text-2xl font-bold">TravelPacker</span>
        <div class="space-x-4 h-full">
          <.link navigate={~p"/trips"}>
            <span class="h-full"> Trips</span>
          </.link>
          <span>Inventory</span>
          <span>Account</span>
          <span>Logout</span>
        </div>
      </nav>
    </header>
    """
  end
end
