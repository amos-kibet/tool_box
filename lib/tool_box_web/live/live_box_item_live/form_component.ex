defmodule ToolBoxWeb.LiveBoxItemLive.FormComponent do
  use ToolBoxWeb, :live_component

  alias ToolBox.LiveBox

  @impl true
  def update(%{live_box_item: live_box_item} = assigns, socket) do
    changeset = LiveBox.change_live_box_item(live_box_item)

    Process.sleep(250)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> allow_upload(:snapshot,
       accept: ~w(.jpg .jpeg .png),
       max_entries: 1,
       max_file_size: 9_000_000,
       auto_upload: true,
       progress: &handle_progress/3
     )}

    # |> IO.inspect(label: "AFTER ALLOW_UPLOAD SOCKET")
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

  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :snapshot, ref)}
  end

  defp save_live_box_item(socket, :edit, params) do
    result =
      LiveBox.update_live_box_item(socket.assigns.live_box_item, live_box_params(socket, params))

    case result do
      {:ok, _live_box_item} ->
        {:noreply,
         socket
         |> put_flash(:info, "Live box item updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_live_box_item(socket, :new, params) do
    case LiveBox.create_live_box_item(live_box_params(socket, params)) do
      {:ok, _live_box_item} ->
        {:noreply,
         socket
         |> put_flash(:info, "Live box item created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def live_box_params(socket, params) do
    Map.put(params, "snapshot_upload", socket.assigns.live_box_item)
  end

  defp handle_progress(:snapshot, entry, socket) do
    :timer.sleep(200)

    if entry.done? do
      {:ok, path} =
        consume_uploaded_entry(
          socket,
          entry,
          &upload_static_file(&1, socket)
        )

      {:noreply,
       socket
       |> put_flash(:info, "file #{entry.client_name} uploaded")
       |> assign(:snapshot, path)}
    else
      {:noreply, socket}
    end
  end

  defp upload_static_file(path, socket) do
    # Plug in your production image file persistence implementation here!
    dest = Path.join("priv/static/images", Path.basename(path))
    File.cp!(path, dest)
    {:ok, Routes.static_path(socket, "/images/#{Path.basename(dest)}")}
  end
end
