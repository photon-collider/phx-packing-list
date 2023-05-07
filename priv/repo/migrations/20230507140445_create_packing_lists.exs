defmodule PhxPackingList.Repo.Migrations.CreatePackingLists do
  use Ecto.Migration

  def change do
    create table(:packing_lists) do
      add :title, :string
      add :description, :string
      add :start_date, :date
      add :end_date, :date

      timestamps()
    end
  end
end
