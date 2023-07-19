defmodule PhxPackingList.Repo.Migrations.AddPositionAndIndexesToItems do
  use Ecto.Migration

  def change do
    alter table(:items) do
      add :position, :integer
    end
  end
end
