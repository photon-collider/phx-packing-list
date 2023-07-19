defmodule PhxPackingList.Packing do
  @moduledoc """
  The Packing context.
  """

  import Ecto.Query, warn: false
  alias PhxPackingList.Repo

  alias PhxPackingList.Packing.PackingList
  alias PhxPackingList.Packing.Item

  @doc """
  Returns the list of packing_lists.

  ## Examples

      iex> list_packing_lists()
      [%PackingList{}, ...]

  """
  def list_packing_lists do
    Repo.all(PackingList)
  end

  @doc """
  Gets a single packing_list.

  Raises `Ecto.NoResultsError` if the Packing list does not exist.

  ## Examples

      iex> get_packing_list!(123)
      %PackingList{}

      iex> get_packing_list!(456)
      ** (Ecto.NoResultsError)

  """
  def get_packing_list!(id), do: Repo.get!(PackingList, id)

  @doc """
  Creates a packing_list.

  ## Examples

      iex> create_packing_list(%{field: value})
      {:ok, %PackingList{}}

      iex> create_packing_list(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_packing_list(attrs \\ %{}) do
    %PackingList{}
    |> PackingList.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a packing_list.

  ## Examples

      iex> update_packing_list(packing_list, %{field: new_value})
      {:ok, %PackingList{}}

      iex> update_packing_list(packing_list, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_packing_list(%PackingList{} = packing_list, attrs) do
    packing_list
    |> PackingList.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a packing_list.

  ## Examples

      iex> delete_packing_list(packing_list)
      {:ok, %PackingList{}}

      iex> delete_packing_list(packing_list)
      {:error, %Ecto.Changeset{}}

  """
  def delete_packing_list(%PackingList{} = packing_list) do
    Repo.delete(packing_list)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking packing_list changes.

  ## Examples

      iex> change_packing_list(packing_list)
      %Ecto.Changeset{data: %PackingList{}}

  """
  def change_packing_list(%PackingList{} = packing_list, attrs \\ %{}) do
    PackingList.changeset(packing_list, attrs)
  end

  alias PhxPackingList.Packing.Item

  @doc """
  Returns the list of items.

  ## Examples

      iex> list_items()
      [%Item{}, ...]

  """
  def list_items do
    Repo.all(Item)
  end

  @doc """
  Gets a single item.

  Raises `Ecto.NoResultsError` if the Item does not exist.

  ## Examples

      iex> get_item!(123)
      %Item{}

      iex> get_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_item!(id) do
    Repo.get!(Item, id)
  end

  @doc """
  Creates a item.

  ## Examples

      iex> create_item(%{field: value})
      {:ok, %Item{}}

      iex> create_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  def create_item(attrs \\ %{}) do
    %Item{}
    |> Item.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a item.

  ## Examples

      iex> update_item(item, %{field: new_value})
      {:ok, %Item{}}

      iex> update_item(item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_item(%Item{} = item, attrs) do
    item
    |> Item.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a item.

  ## Examples

      iex> delete_item(item)
      {:ok, %Item{}}

      iex> delete_item(item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_item(%Item{} = item) do
    Repo.delete(item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking item changes.

  ## Examples

      iex> change_item(item)
      %Ecto.Changeset{data: %Item{}}

  """
  def change_item(%Item{} = item, attrs \\ %{}) do
    Item.changeset(item, attrs)
  end

  def list_items_for_packing_list(packing_list_id) do
    Repo.all(
      from i in Item, where: i.packing_list_id == ^packing_list_id, order_by: [asc: :position]
    )
  end
end
