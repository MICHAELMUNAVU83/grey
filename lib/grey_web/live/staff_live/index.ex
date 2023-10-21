defmodule GreyWeb.StaffLive.Index do
  use GreyWeb, :admin_live_view

  alias Grey.Staffs
  alias Grey.Staffs.Staff
  alias Grey.Users
  alias Grey.Status

  @impl true
  def mount(_params, session, socket) do
    user = Users.get_user_by_session_token(session["user_token"])

    {:ok,
     socket
     |> assign(:staff_collection, list_staff())
     |> assign(:heading, "Staff")
     |> assign(:subheading, "This is a list of all your staff members")
     |> assign(:user, user)}
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

  @impl true
  def handle_event("change_status", %{"id" => id, "schema" => schema}, socket) do
    Status.change_status(id, schema)

    {:noreply, assign(socket, :staff_collection, list_staff())}
  end

  defp list_staff do
    Staffs.list_staff()
  end
end
