defmodule ToolBox.LiveBoxTest do
  use ToolBox.DataCase

  alias ToolBox.LiveBox

  describe "box_items" do
    alias ToolBox.LiveBox.LiveBoxItem

    import ToolBox.LiveBoxFixtures

    @invalid_attrs %{short_description: nil, snapshot: nil, url: nil}

    test "list_box_items/0 returns all box_items" do
      live_box_item = live_box_item_fixture()
      assert LiveBox.list_box_items() == [live_box_item]
    end

    test "get_live_box_item!/1 returns the live_box_item with given id" do
      live_box_item = live_box_item_fixture()
      assert LiveBox.get_live_box_item!(live_box_item.id) == live_box_item
    end

    test "create_live_box_item/1 with valid data creates a live_box_item" do
      valid_attrs = %{
        short_description: "some short_description",
        snapshot: "some snapshot",
        url: "some url"
      }

      assert {:ok, %LiveBoxItem{} = live_box_item} = LiveBox.create_live_box_item(valid_attrs)
      assert live_box_item.short_description == "some short_description"
      assert live_box_item.snapshot == "some snapshot"
      assert live_box_item.url == "some url"
    end

    test "create_live_box_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = LiveBox.create_live_box_item(@invalid_attrs)
    end

    test "update_live_box_item/2 with valid data updates the live_box_item" do
      live_box_item = live_box_item_fixture()

      update_attrs = %{
        short_description: "some updated short_description",
        snapshot: "some updated snapshot",
        url: "some updated url"
      }

      assert {:ok, %LiveBoxItem{} = live_box_item} =
               LiveBox.update_live_box_item(live_box_item, update_attrs)

      assert live_box_item.short_description == "some updated short_description"
      assert live_box_item.snapshot == "some updated snapshot"
      assert live_box_item.url == "some updated url"
    end

    test "update_live_box_item/2 with invalid data returns error changeset" do
      live_box_item = live_box_item_fixture()

      assert {:error, %Ecto.Changeset{}} =
               LiveBox.update_live_box_item(live_box_item, @invalid_attrs)

      assert live_box_item == LiveBox.get_live_box_item!(live_box_item.id)
    end

    test "delete_live_box_item/1 deletes the live_box_item" do
      live_box_item = live_box_item_fixture()
      assert {:ok, %LiveBoxItem{}} = LiveBox.delete_live_box_item(live_box_item)
      assert_raise Ecto.NoResultsError, fn -> LiveBox.get_live_box_item!(live_box_item.id) end
    end

    test "change_live_box_item/1 returns a live_box_item changeset" do
      live_box_item = live_box_item_fixture()
      assert %Ecto.Changeset{} = LiveBox.change_live_box_item(live_box_item)
    end
  end
end
