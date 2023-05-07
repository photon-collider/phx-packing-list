defmodule PhxPackingList.Repo.Migrations.AddTravelDestinationFieldToPackingLists do
  use Ecto.Migration

  def change do
    alter table(:packing_lists) do
      add :travel_destination, :string
    end
  end
end
