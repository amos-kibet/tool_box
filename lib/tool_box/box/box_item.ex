defmodule ToolBox.Box.BoxItem do
  @moduledoc false

  use Ecto.Schema
  use Waffle.Ecto.Schema

  import Ecto.Changeset

  schema "box" do
    field :short_description, :string
    field :snapshot, ToolBoxWeb.Uploaders.Snapshots.Type
    field :url, :string
    field :uuid, :string

    timestamps()
  end

  @doc false
  # @TODO: refactor this changeset; define snapshot changeset & call it here
  def changeset(box_item, attrs) do
    box_item
    |> Map.update(:uuid, Ecto.UUID.generate(), fn val -> val || Ecto.UUID.generate() end)
    |> cast_attachments(attrs, [:snapshot, :uuid])
    |> cast(attrs, [:url, :short_description, :snapshot])
    |> validate_required([:url, :short_description, :snapshot])
    |> validate_url_changeset()
  end

  @doc """
  Validates that the url start with either http or https
  """
  def validate_url_changeset(changeset) do
    regex =
      ~r/^https?:\/\/(?:www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b(?:[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)$/

    changeset
    |> validate_format(:url, regex, message: "must start with either http:// or https://")
  end

  # def snapshot_changeset(snapshot,attrs) do
  #   snapshot
  #   |> Map.update(:uuid, Ecto.UUID.generate, fn val -> val || Ecto.UUID.generate end)
  #   |> cast_attachments(attrs, [:snapshot, :uuid])
  #   |> validate_required([:snapshot, :uuid])
  # end
end
