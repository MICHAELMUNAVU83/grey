defmodule GreyWeb.ReturnLive.Index do
  use GreyWeb, :live_view

  alias Grey.Returns
  alias Grey.Returns.Return
  alias Grey.Users

  @impl true
  def mount(_params, session, socket) do
    user = Users.get_user_by_session_token(session["user_token"])

    {:ok,
    socket
    |> assign(:returns, list_returns())
    |> assign(:user, user)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Return")
    |> assign(:return, Returns.get_return!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Return")
    |> assign(:return, %Return{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Returns")
    |> assign(:return, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    return = Returns.get_return!(id)
    {:ok, _} = Returns.delete_return(return)

    {:noreply, assign(socket, :returns, list_returns())}
  end

  defp list_returns do
    Returns.list_returns()
  end
end
