defmodule GreyWeb.DashboardLive.Index do
  use GreyWeb, :admin_live_view
  alias Grey.Users

  def mount(_params, session, socket) do
    user = Users.get_user_by_session_token(session["user_token"])

    {:ok,
     socket
     |> assign(:heading, "Dashboard")
     |> assign(:subheading, "This is your admin dashboard for metrics")
     |> assign(:user, user)}
  end
end
