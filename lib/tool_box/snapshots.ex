# defmodule ToolBox.Snapshots do
#   @moduledoc """
#   The Gallery context.
#   """

#   import Ecto.Query, warn: false
#   alias ToolBox.Repo

#   alias ToolBox.Snapshots.Snapshot

#   @doc """
#   Returns the list of Snapshots.

#   ## Examples

#       iex> list_snapshots()
#       [%Snapshot{}, ...]

#   """
#   def list_snapshots do
#     Repo.all(Snapshot)
#   end

#   @doc """
#   Gets a single Snapshot.

#   Raises `Ecto.NoResultsError` if the Snapshot does not exist.

#   ## Examples

#       iex> get_Snapshot!(123)
#       %Snapshot{}

#       iex> get_Snapshot!(456)
#       ** (Ecto.NoResultsError)

#   """
#   def get_snapshot!(id), do: Repo.get!(Snapshot, id)

#   @doc """
#   Creates a Snapshot.

#   ## Examples

#       iex> create_Snapshot(%{field: value})
#       {:ok, %Snapshot{}}

#       iex> create_Snapshot(%{field: bad_value})
#       {:error, %Ecto.Changeset{}}

#   """
#   def create_snapshot(attrs \\ %{}) do
#     %Snapshot{}
#     |> Snapshot.changeset(attrs)
#     |> Repo.insert()
#   end

#   @doc """
#   Updates a Snapshot.

#   ## Examples

#       iex> update_Snapshot(Snapshot, %{field: new_value})
#       {:ok, %Snapshot{}}

#       iex> update_Snapshot(Snapshot, %{field: bad_value})
#       {:error, %Ecto.Changeset{}}

#   """
#   def update_snapshot(%Snapshot{} = snapshot, attrs) do
#     snapshot
#     |> Snapshot.changeset(attrs)
#     |> Repo.update()
#   end

#   @doc """
#   Deletes a Snapshot.

#   ## Examples

#       iex> delete_Snapshot(Snapshot)
#       {:ok, %Snapshot{}}

#       iex> delete_Snapshot(Snapshot)
#       {:error, %Ecto.Changeset{}}

#   """
#   def delete_snapshot(%Snapshot{} = snapshot) do
#     Repo.delete(snapshot)
#   end

#   @doc """
#   Returns an `%Ecto.Changeset{}` for tracking Snapshot changes.

#   ## Examples

#       iex> change_Snapshot(Snapshot)
#       %Ecto.Changeset{data: %Snapshot{}}

#   """
#   def change_snapshot(%Snapshot{} = snapshot, attrs \\ %{}) do
#     Snapshot.changeset(snapshot, attrs)
#   end
# end
