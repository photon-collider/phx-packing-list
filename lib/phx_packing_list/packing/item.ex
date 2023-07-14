defmodule PhxPackingList.Packing.Item do
  use Ecto.Schema
  import Ecto.Changeset
  alias PhxPackingList.Packing.PackingList

  schema "items" do
    field :name, :string
    field :notes, :string
    field :quantity, :integer, default: 1
    field :packed, :boolean, default: false
    belongs_to :packing_list, PackingList
    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :notes, :packed, :packing_list_id])
    |> validate_required([:packing_list_id])
  end
end
