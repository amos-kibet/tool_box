defmodule ToolBox.LiveBoxFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ToolBox.LiveBox` context.
  """

  @doc """
  Generate a live_box_item.
  """
  def live_box_item_fixture(attrs \\ %{}) do
    {:ok, live_box_item} =
      attrs
      |> Enum.into(%{
        short_description: "some short_description",
        snapshot: "some snapshot",
        url: "some url"
      })
      |> ToolBox.LiveBox.create_live_box_item()

    live_box_item
  end
end
