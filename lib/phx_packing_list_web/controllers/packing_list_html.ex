defmodule PhxPackingListWeb.PackingListHTML do
  use PhxPackingListWeb, :html

  import PhxPackingListWeb.PackingListComponents

  embed_templates "packing_list_html/*"

  @doc """
  Renders a packing_list form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def packing_list_form(assigns)
end
