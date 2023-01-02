# defmodule ToolBox.Snapshots.Snapshot do
#   @moduledoc false

#   use Ecto.Schema
#   use Waffle.Ecto.Schema

#   import Ecto.Changeset

#   schema "snapshots" do
#     field :snapshot, ToolBoxWeb.Uploaders.Snapshots.Type
#     field :uuid, :string

#     timestamps()
#   end

#   @doc false
#   def changeset(snapshot, attrs) do
#     snapshot
#     |> Map.update(:uuid, Ecto.UUID.generate(), fn val -> val || Ecto.UUID.generate() end)
#     |> cast_attachments(attrs, [:snapshot, :uuid])
#     |> validate_required([:snapshot, :uuid])
#   end
# end
