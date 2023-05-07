defmodule PhxPackingList.Packing.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :name, :string
    field :notes, :string
    field :quantity, :integer
    field :packing_list_id, :id

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :quantity, :notes])
    |> validate_required([:name, :quantity, :notes])
  end
end
