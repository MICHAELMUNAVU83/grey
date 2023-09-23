defmodule GreyWeb.UserRegistrationController do
  use GreyWeb, :controller

  alias Grey.Users
  alias Grey.Users.User
  alias GreyWeb.UserAuth

  @spec new(Plug.Conn.t(), any) :: Plug.Conn.t()
  def new(conn, _params) do
    changeset = Users.change_user_registration(%User{})
    todays_date = to_string(Date.utc_today()) |> String.replace("-", "")
    code = (SecureRandom.uuid() |> String.replace("-", "") |> String.slice(0..9)) <> todays_date

    render(conn, "new.html", changeset: changeset, code: code)
  end

  def create(conn, %{"user" => user_params}) do
    case Users.register_user(user_params) do
      {:ok, user} ->
        {:ok, _} =
          Users.deliver_user_confirmation_instructions(
            user,
            &Routes.user_confirmation_url(conn, :edit, &1)
          )

        conn
        |> put_flash(:info, "User created successfully.")
        |> UserAuth.log_in_user(user)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
