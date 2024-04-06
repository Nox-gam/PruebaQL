defmodule PruebaQL.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PruebaQLWeb.Telemetry,
      PruebaQL.Repo,
      {DNSCluster, query: Application.get_env(:pruebaQL, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PruebaQL.PubSub, fastlane: Phoenix.Channel.Server},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PruebaQL.Finch},
      # Start a worker by calling: PruebaQL.Worker.start_link(arg)
      # {PruebaQL.Worker, arg},
      # Start to serve requests, typically the last entry
      PruebaQLWeb.Endpoint,
      {Absinthe.Subscription, PruebaQLWeb.Endpoint}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PruebaQL.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PruebaQLWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
