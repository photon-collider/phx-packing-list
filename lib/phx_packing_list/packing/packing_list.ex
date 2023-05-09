defmodule PhxPackingList.Packing.PackingList do
  use Ecto.Schema
  import Ecto.Changeset

  schema "packing_lists" do
    field :title, :string
    field :description, :string
    field :start_date, :date
    field :end_date, :date
    field :travel_destination, :string
    has_many :items, PhxPackingList.Packing.Item

    timestamps()
  end

  @doc false
  def changeset(packing_list, attrs) do
    packing_list
    |> cast(attrs, [:title, :description, :start_date, :end_date, :travel_destination])
    |> validate_required([:title, :description, :start_date, :end_date, :travel_destination])
  end
end
