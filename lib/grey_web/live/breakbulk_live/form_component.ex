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
  def handle_event("validate", %{"breakbulk" => breakbulk_params}, socket) do
    changeset =
      socket.assigns.breakbulk
      |> Breakbulks.change_breakbulk(breakbulk_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  @impl true
  def handle_event("add_form", params, socket) do
    new_form_count = socket.assigns.form_count + 1
    IO.inspect(new_form_count)

    {:noreply,
     socket
     |> assign(:form_count, new_form_count)}
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
    list_quantity =
      params["quantity"]
      |> Enum.chunk_every(1)
      |> Enum.map(fn [b] -> %{"quantity" => b} end)

    list_uom =
      params["uom"]
      |> Enum.chunk_every(1)
      |> Enum.map(fn [c] -> %{"uom" => c} end)

    list_code =
      params["code"]
      |> Enum.chunk_every(1)
      |> Enum.map(fn [e] -> %{"code" => e} end)

    list_active =
      params["active"]
      |> Enum.chunk_every(1)
      |> Enum.map(fn [f] -> %{"active" => f} end)

    list_description =
      [""]
      |> Enum.chunk_every(1)
      |> Enum.map(fn [d] -> %{"description" => d} end)

    IO.inspect(
      list =
        Enum.map(
          for {b, c, d} <-
                Enum.zip([list_quantity, list_uom, list_description, list_code, list_active]) do
            Enum.concat([b, c, d])
          end,
          fn x ->
            Enum.into(x, %{"active" => params["active"], "user_id" => socket.assigns.user.id})
          end
        )
    )

    changesets =
      Enum.map(list, fn breakbulk ->
        Breakbulk.changeset(%Breakbulk{}, breakbulk)
      end)

    result =
      changesets
      |> Enum.with_index()
      |> Enum.reduce(Ecto.Multi.new(), fn {changeset, index}, multi ->
        Ecto.Multi.insert(multi, Integer.to_string(index), changeset)
      end)
      |> Repo.transaction()

    case result do
      {:ok, _} ->
        {:noreply,
         socket
         |> put_flash(:info, "Breakbulk created successfully")}
    end
  end

  @impl true

  def handle_event("validate_form", params, socket) do
    IO.inspect(params["code"])

    {:noreply, socket}
  end
end
