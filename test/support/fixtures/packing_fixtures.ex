defmodule PhxPackingList.PackingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhxPackingList.Packing` context.
  """

  @doc """
  Generate a packing_list.
  """
  def packing_list_fixture(attrs \\ %{}) do
    {:ok, packing_list} =
      attrs
      |> Enum.into(%{
        description: "some description",
        end_date: ~D[2023-05-06],
        start_date: ~D[2023-05-06],
        title: "some title"
      })
      |> PhxPackingList.Packing.create_packing_list()

    packing_list
  end

  @doc """
  Generate a item.
  """
  def item_fixture(attrs \\ %{}) do
    {:ok, item} =
      attrs
      |> Enum.into(%{
        name: "some name",
        notes: "some notes",
        quantity: 42
      })
      |> PhxPackingList.Packing.create_item()

    item
  end

  @doc """
  Generate a packing_list.
  """
  def packing_list_fixture(attrs \\ %{}) do
    {:ok, packing_list} =
      attrs
      |> Enum.into(%{

      })
      |> PhxPackingList.Packing.create_packing_list()

    packing_list
  end

  @doc """
  Generate a packing_list.
  """
  def packing_list_fixture(attrs \\ %{}) do
    {:ok, packing_list} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> PhxPackingList.Packing.create_packing_list()

    packing_list
  end
end
