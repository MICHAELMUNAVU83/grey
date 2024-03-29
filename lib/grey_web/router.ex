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
    live "/dashboard", DashboardLive.Index, :index
    live "/warehouse", WareHouseLive.Index, :index
    live "/warehouse/new", WareHouseLive.Index, :new
    live "/warehouse/:id/edit", WareHouseLive.Index, :edit

    live "/warehouse/:id", WareHouseLive.Show, :show
    live "/warehouse/:id/show/edit", WareHouseLive.Show, :edit
    live "/staff", StaffLive.Index, :index
    live "/staff/new", StaffLive.Index, :new
    live "/staff/:id/edit", StaffLive.Index, :edit

    live "/receives", ReceiveLive.Index, :index
    live "/receives/new", ReceiveLive.Index, :new
    live "/receives/:id/edit", ReceiveLive.Index, :edit

    live "/receives/:id", ReceiveLive.Show, :show
    live "/receives/:id/show/edit", ReceiveLive.Show, :edit

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

    live "/breakbulks", BreakbulkLive.Index, :index
    live "/breakbulks/new", BreakbulkLive.Index, :new
    live "/breakbulks/:id/edit", BreakbulkLive.Index, :edit

    live "/breakbulks/:id", BreakbulkLive.Show, :show
    live "/breakbulks/:id/show/edit", BreakbulkLive.Show, :edit

    live "/returns/:id", ReturnLive.Show, :show
    live "/returns/:id/show/edit", ReturnLive.Show, :edit
    live "/dispatches", DispatchLive.Index, :index
    live "/dispatches/new", DispatchLive.Index, :new
    live "/dispatches/:id/edit", DispatchLive.Index, :edit

    live "/dispatches/:id", DispatchLive.Show, :show
    live "/dispatches/:id/show/edit", DispatchLive.Show, :edit
    live "/retailers", RetailerLive.Index, :index
    live "/retailers/new", RetailerLive.Index, :new
    live "/retailers/:id/edit", RetailerLive.Index, :edit

    live "/suppliers", SupplierLive.Index, :index
    live "/suppliers/new", SupplierLive.Index, :new
    live "/suppliers/:id/edit", SupplierLive.Index, :edit

    live "/suppliers/:id", SupplierLive.Show, :show
    live "/suppliers/:id/show/edit", SupplierLive.Show, :edit

    live "/putaways", PutawayLive.Index, :index
    live "/putaways/new", PutawayLive.Index, :new
    live "/putaways/:id/edit", PutawayLive.Index, :edit

    live "/putaways/:id", PutawayLive.Show, :show
    live "/putaways/:id/show/edit", PutawayLive.Show, :edit

    live "/retailers/:id", RetailerLive.Show, :show
    live "/retailers/:id/show/edit", RetailerLive.Show, :edit

    live "/storages", StorageLive.Index, :index
    live "/storages/new", StorageLive.Index, :new
    live "/storages/:id/edit", StorageLive.Index, :edit

    live "/storages/:id", StorageLive.Show, :show
    live "/storages/:id/show/edit", StorageLive.Show, :edit

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
