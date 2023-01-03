defmodule ToolBox.LiveBox do
  @moduledoc """
  The LiveBox context.
  """

  import Ecto.Query, warn: false
  alias ToolBox.Repo

  alias ToolBox.LiveBox.LiveBoxItem

  @doc """
  Returns the list of box_items.

  ## Examples

      iex> list_box_items()
      [%LiveBoxItem{}, ...]

  """
  def list_box_items do
    Repo.all(LiveBoxItem)
  end

  @doc """
  Gets a single live_box_item.

  Raises `Ecto.NoResultsError` if the Live box item does not exist.

  ## Examples

      iex> get_live_box_item!(123)
      %LiveBoxItem{}

      iex> get_live_box_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_live_box_item!(id), do: Repo.get!(LiveBoxItem, id)

  @doc """
  Creates a live_box_item.

  ## Examples

      iex> create_live_box_item(%{field: value})
      {:ok, %LiveBoxItem{}}

      iex> create_live_box_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_live_box_item(attrs \\ %{}) do
    %LiveBoxItem{}
    |> LiveBoxItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a live_box_item.

  ## Examples

      iex> update_live_box_item(live_box_item, %{field: new_value})
      {:ok, %LiveBoxItem{}}

      iex> update_live_box_item(live_box_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_live_box_item(%LiveBoxItem{} = live_box_item, attrs) do
    live_box_item
    |> LiveBoxItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a live_box_item.

  ## Examples

      iex> delete_live_box_item(live_box_item)
      {:ok, %LiveBoxItem{}}

      iex> delete_live_box_item(live_box_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_live_box_item(%LiveBoxItem{} = live_box_item) do
    Repo.delete(live_box_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking live_box_item changes.

  ## Examples

      iex> change_live_box_item(live_box_item)
      %Ecto.Changeset{data: %LiveBoxItem{}}

  """
  def change_live_box_item(%LiveBoxItem{} = live_box_item, attrs \\ %{}) do
    LiveBoxItem.changeset(live_box_item, attrs)
  end
end
