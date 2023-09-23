defmodule GreyWeb.Router do
  use GreyWeb, :router

  import GreyWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {GreyWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GreyWeb do
    pipe_through :browser

    get "/", PageController, :index
   end

  # Other scopes may use custom stacks.
  # scope "/api", GreyWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: GreyWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", GreyWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", GreyWeb do
    pipe_through [:browser, :require_authenticated_user]
    live "/warehouse", WareHouseLive.Index, :index
    live "/warehouse/new", WareHouseLive.Index, :new
    live "/warehouse/:id/edit", WareHouseLive.Index, :edit

    live "/warehouse/:id", WareHouseLive.Show, :show
    live "/warehouse/:id/show/edit", WareHouseLive.Show, :edit
    live "/staff", StaffLive.Index, :index
    live "/staff/new", StaffLive.Index, :new
    live "/staff/:id/edit", StaffLive.Index, :edit

    live "/staff/:id", StaffLive.Show, :show
    live "/staff/:id/show/edit", StaffLive.Show, :edit
    live "/device", DeviceLive.Index, :index
    live "/device/new", DeviceLive.Index, :new
    live "/device/:id/edit", DeviceLive.Index, :edit

    live "/device/:id", DeviceLive.Show, :show
    live "/device/:id/show/edit", DeviceLive.Show, :edit
    live "/vehicle", VehicleLive.Index, :index
    live "/vehicle/new", VehicleLive.Index, :new
    live "/vehicle/:id/edit", VehicleLive.Index, :edit

    live "/vehicle/:id", VehicleLive.Show, :show
    live "/vehicle/:id/show/edit", VehicleLive.Show, :edit

    live "/transfers", TransferLive.Index, :index
    live "/transfers/new", TransferLive.Index, :new
    live "/transfers/:id/edit", TransferLive.Index, :edit

    live "/transfers/:id", TransferLive.Show, :show
    live "/transfers/:id/show/edit", TransferLive.Show, :edit

    live "/returns", ReturnLive.Index, :index
    live "/returns/new", ReturnLive.Index, :new
    live "/returns/:id/edit", ReturnLive.Index, :edit

    live "/returns/:id", ReturnLive.Show, :show
    live "/returns/:id/show/edit", ReturnLive.Show, :edit

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
  end

  scope "/", GreyWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :edit
    post "/users/confirm/:token", UserConfirmationController, :update
  end
end
