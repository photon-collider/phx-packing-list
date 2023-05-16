defmodule PhxPackingList.Repo.Migrations.AddPackedToItems do
  use Ecto.Migration

  def change do
    alter table(:items) do
      add :packed, :boolean, default: false, null: false
    end
  end
end
