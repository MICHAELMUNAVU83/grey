defmodule GreyWeb.BreakbulkLive.FormComponent do
  use GreyWeb, :live_component
  require Ecto.Query
  require Ecto
  alias Grey.Breakbulks
  alias Grey.Breakbulks.Breakbulk
  alias Grey.Repo

  @impl true
  def update(%{breakbulk: breakbulk} = assigns, socket) do
    changeset = Breakbulks.change_breakbulk(breakbulk)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(:form_count, 1)}
  end

  @impl true
  def handle_event("validate", params, socket) do
    changeset =
      socket.assigns.breakbulk
      |> Breakbulks.change_breakbulk(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("quantity_check", params, socket) do
    # error = if params["quantity"]
    IO.inspect(params)
    {:noreply, socket}
  end

  def handle_event("quantity_recover", params, socket) do
    # error = if params["quantity"]
    IO.inspect(params)
    {:noreply, socket}
  end

  def handle_event("save", %{"breakbulk" => breakbulk_params}, socket) do
    save_breakbulk(socket, socket.assigns.action, breakbulk_params)
  end

  defp save_breakbulk(socket, :edit, breakbulk_params) do
    case Breakbulks.update_breakbulk(socket.assigns.breakbulk, breakbulk_params) do
      {:ok, _breakbulk} ->
        {:noreply,
         socket
         |> put_flash(:info, "Breakbulk updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_breakbulk(socket, :new, breakbulk_params) do
    IO.inspect(breakbulk_params)

    new_breakbulk =
      breakbulk_params
      |> Map.put("user_id", socket.assigns.user.id)

    case Breakbulks.create_breakbulk(new_breakbulk) do
      {:ok, _breakbulk} ->
        {:noreply,
         socket
         |> put_flash(:info, "Breakbulk created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  @impl true
  def handle_event("saver", params, socket) do
    IO.inspect(params)

    status =
      if params["status"] == ["on"] do
        true
      else
        false
      end

    code = SecureRandom.hex(6)

    now =
      NaiveDateTime.utc_now()
      |> NaiveDateTime.truncate(:second)

    [items, quantities, uom] = [params["item"], params["quantity"], params["uom"]]

    items_to_add =
      Enum.zip(Enum.zip(items, quantities), uom)
      |> Enum.map(fn {item_qty, uom_value} ->
        {elem(item_qty, 0), elem(item_qty, 1), uom_value}
      end)
      |> Enum.map(fn {item, quantity, uom} ->
        %{
          items: item,
          quantity: quantity,
          uom: uom,
          user_id: socket.assigns.user.id,
          code: code,
          active: status,
          inserted_at: now,
          updated_at: now
        }
      end)
      |> IO.inspect()

    case Breakbulks.add_all(items_to_add) do
      {_x, nil} ->
        {:noreply,
         socket
         |> put_flash(:info, "Breakbulk created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      _ ->
        {:noreply, socket}
    end
  end

  defp apply_changeset(items) do
    Breakbulk.changeset(items, %{})
  end
end
