defmodule ToolBoxWeb.LiveBoxItemLiveTest do
  use ToolBoxWeb.ConnCase

  import Phoenix.LiveViewTest
  import ToolBox.LiveBoxFixtures

  @create_attrs %{
    short_description: "some short_description",
    snapshot: "some snapshot",
    url: "some url"
  }
  @update_attrs %{
    short_description: "some updated short_description",
    snapshot: "some updated snapshot",
    url: "some updated url"
  }
  @invalid_attrs %{short_description: nil, snapshot: nil, url: nil}

  defp create_live_box_item(_) do
    live_box_item = live_box_item_fixture()
    %{live_box_item: live_box_item}
  end

  describe "Index" do
    setup [:create_live_box_item]

    # @TODO: add flag to test this file alone
    test "lists all box_items", %{conn: conn, live_box_item: live_box_item} do
      {:ok, _index_live, html} =
        live(
          conn,
          Routes.live_box_item_index_path(conn, :index)
          # |> IO.inspect(label: "[TEST FILE INSPECTION]")
        )

      assert html =~ "Listing Box items"
      assert html =~ live_box_item.short_description
    end

    test "saves new live_box_item", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.live_box_item_index_path(conn, :index))

      assert index_live |> element("a", "New Live box item") |> render_click() =~
               "New Live box item"

      assert_patch(index_live, Routes.live_box_item_index_path(conn, :new))

      assert index_live
             |> form("#live_box_item-form", live_box_item: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#live_box_item-form", live_box_item: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.live_box_item_index_path(conn, :index))

      assert html =~ "Live box item created successfully"
      assert html =~ "some short_description"
    end

    test "updates live_box_item in listing", %{conn: conn, live_box_item: live_box_item} do
      {:ok, index_live, _html} = live(conn, Routes.live_box_item_index_path(conn, :index))

      assert index_live
             |> element("#live_box_item-#{live_box_item.id} a", "Edit")
             |> render_click() =~
               "Edit Live box item"

      assert_patch(index_live, Routes.live_box_item_index_path(conn, :edit, live_box_item))

      assert index_live
             |> form("#live_box_item-form", live_box_item: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#live_box_item-form", live_box_item: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.live_box_item_index_path(conn, :index))

      assert html =~ "Live box item updated successfully"
      assert html =~ "some updated short_description"
    end

    test "deletes live_box_item in listing", %{conn: conn, live_box_item: live_box_item} do
      {:ok, index_live, _html} = live(conn, Routes.live_box_item_index_path(conn, :index))

      assert index_live
             |> element("#live_box_item-#{live_box_item.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#live_box_item-#{live_box_item.id}")
    end
  end

  describe "Show" do
    setup [:create_live_box_item]

    test "displays live_box_item", %{conn: conn, live_box_item: live_box_item} do
      {:ok, _show_live, html} =
        live(conn, Routes.live_box_item_show_path(conn, :show, live_box_item))

      assert html =~ "Show Live box item"
      assert html =~ live_box_item.short_description
    end

    test "updates live_box_item within modal", %{conn: conn, live_box_item: live_box_item} do
      {:ok, show_live, _html} =
        live(conn, Routes.live_box_item_show_path(conn, :show, live_box_item))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Live box item"

      assert_patch(show_live, Routes.live_box_item_show_path(conn, :edit, live_box_item))

      assert show_live
             |> form("#live_box_item-form", live_box_item: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#live_box_item-form", live_box_item: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.live_box_item_show_path(conn, :show, live_box_item))

      assert html =~ "Live box item updated successfully"
      assert html =~ "some updated short_description"
    end
  end
end
