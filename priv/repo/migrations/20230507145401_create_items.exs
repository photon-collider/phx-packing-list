defmodule PhxPackingList.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :name, :string
      add :quantity, :integer
      add :notes, :text
      add :packing_list_id, references(:packing_lists, on_delete: :nothing)

      timestamps()
    end

    create index(:items, [:packing_list_id])
  end
end
