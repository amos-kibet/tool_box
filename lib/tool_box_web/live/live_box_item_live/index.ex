defmodule ToolBoxWeb.LiveBoxItemLive.Index do
  use ToolBoxWeb, :live_view

  alias ToolBox.LiveBox
  alias ToolBox.LiveBox.LiveBoxItem

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :box_items, list_box_items())}
    |> IO.inspect(label: "[MOUNT SOCKET")
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Live box item")
    |> assign(:live_box_item, LiveBox.get_live_box_item!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Live box item")
    |> assign(:live_box_item, %LiveBoxItem{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Box items")
    |> assign(:live_box_item, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    live_box_item = LiveBox.get_live_box_item!(id)
    {:ok, _} = LiveBox.delete_live_box_item(live_box_item)

    {:noreply, assign(socket, :box_items, list_box_items())}
  end

  defp list_box_items do
    LiveBox.list_box_items()
  end
end
