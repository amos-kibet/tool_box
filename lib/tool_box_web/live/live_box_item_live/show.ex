defmodule ToolBoxWeb.LiveBoxItemLive.Show do
  use ToolBoxWeb, :live_view

  alias ToolBox.LiveBox

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:live_box_item, LiveBox.get_live_box_item!(id))}
  end

  defp page_title(:show), do: "Show Live box item"
  defp page_title(:edit), do: "Edit Live box item"
end
