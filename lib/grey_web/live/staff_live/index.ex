defmodule GreyWeb.StaffLive.Index do
  use GreyWeb, :live_view

  alias Grey.Staffs
  alias Grey.Staffs.Staff

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :staff_collection, list_staff())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Staff")
    |> assign(:staff, Staffs.get_staff!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Staff")
    |> assign(:staff, %Staff{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Staff")
    |> assign(:staff, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    staff = Staffs.get_staff!(id)
    {:ok, _} = Staffs.delete_staff(staff)

    {:noreply, assign(socket, :staff_collection, list_staff())}
  end

  defp list_staff do
    Staffs.list_staff()
  end
end
