defmodule ToolBox.LiveBox.LiveBoxItem do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  schema "box_items" do
    field :short_description, :string
    field :snapshot, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(live_box_item, attrs) do
    live_box_item
    |> cast(attrs, [:short_description, :snapshot, :url])
    |> validate_required([:short_description, :snapshot, :url])
  end
end
