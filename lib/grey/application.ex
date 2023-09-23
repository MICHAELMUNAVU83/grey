defmodule Grey.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Grey.Repo,
      # Start the Telemetry supervisor
      GreyWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Grey.PubSub},
      # Start the Endpoint (http/https)
      GreyWeb.Endpoint
      # Start a worker by calling: Grey.Worker.start_link(arg)
      # {Grey.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Grey.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GreyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
