# defmodule ToolBoxWeb.SnapshotsController do
#   use ToolBoxWeb, :controller

#   alias ToolBox.Snapshots
#   alias ToolBox.Snapshots.Snapshot

#   def index(conn, _params) do
#     snapshots = Snapshots.list_snapshots()
#     render(conn, "index.html", snapshots: snapshots)
#   end

#   def new(conn, _params) do
#     changeset = Snapshots.change_snapshot(%Snapshot{})
#     render(conn, "new.html", changeset: changeset)
#   end

#   def create(conn, %{"snapshot" => snapshot_params}) do
#     case Snapshots.create_snapshot(snapshot_params) do
#       {:ok, snapshot} ->
#         conn
#         |> put_flash(:info, "snapshot created successfully.")
#         |> redirect(to: Routes.snapshots_path(conn, :show, snapshot))

#       {:error, %Ecto.Changeset{} = changeset} ->
#         render(conn, "new.html", changeset: changeset)
#     end
#   end

#   def show(conn, %{"id" => id}) do
#     snapshot = Snapshots.get_snapshot!(id)
#     render(conn, "show.html", snapshot: snapshot)
#   end

#   def edit(conn, %{"id" => id}) do
#     snapshot = Snapshots.get_snapshot!(id)
#     changeset = Snapshots.change_snapshot(snapshot)
#     render(conn, "edit.html", snapshot: snapshot, changeset: changeset)
#   end

#   def update(conn, %{"id" => id, "snapshot" => snapshot_params}) do
#     snapshot = Snapshots.get_snapshot!(id)

#     case Snapshots.update_snapshot(snapshot, snapshot_params) do
#       {:ok, snapshot} ->
#         conn
#         |> put_flash(:info, "snapshot updated successfully.")
#         |> redirect(to: Routes.snapshots_path(conn, :show, snapshot))

#       {:error, %Ecto.Changeset{} = changeset} ->
#         render(conn, "edit.html", snapshot: snapshot, changeset: changeset)
#     end
#   end

#   def delete(conn, %{"id" => id}) do
#     snapshot = Snapshots.get_snapshot!(id)
#     {:ok, _snapshot} = Snapshots.delete_snapshot(snapshot)

#     conn
#     |> put_flash(:info, "snapshot deleted successfully.")
#     |> redirect(to: Routes.snapshots_path(conn, :index))
#   end
# end
