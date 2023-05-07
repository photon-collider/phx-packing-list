defmodule PhxPackingList.Packing.PackingList do
  use Ecto.Schema
  import Ecto.Changeset

  schema "packing_lists" do
    field :description, :string
    field :end_date, :date
    field :start_date, :date
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(packing_list, attrs) do
    packing_list
    |> cast(attrs, [:title, :description, :start_date, :end_date])
    |> validate_required([:title, :description, :start_date, :end_date])
  end
end
