defmodule ToolBoxWeb.LiveBoxItemLive.FormComponent do
  use ToolBoxWeb, :live_component

  alias ToolBox.LiveBox

  @impl true
  def update(%{live_box_item: live_box_item} = assigns, socket) do
    changeset = LiveBox.change_live_box_item(live_box_item)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"live_box_item" => live_box_item_params}, socket) do
    changeset =
      socket.assigns.live_box_item
      |> LiveBox.change_live_box_item(live_box_item_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"live_box_item" => live_box_item_params}, socket) do
    save_live_box_item(socket, socket.assigns.action, live_box_item_params)
  end

  defp save_live_box_item(socket, :edit, live_box_item_params) do
    case LiveBox.update_live_box_item(socket.assigns.live_box_item, live_box_item_params) do
      {:ok, _live_box_item} ->
        {:noreply,
         socket
         |> put_flash(:info, "Live box item updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_live_box_item(socket, :new, live_box_item_params) do
    case LiveBox.create_live_box_item(live_box_item_params) do
      {:ok, _live_box_item} ->
        {:noreply,
         socket
         |> put_flash(:info, "Live box item created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
