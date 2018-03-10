defmodule JivifightWeb.GamesChannel do
  use JivifightWeb, :channel

  alias Jivifight.Game

  def join("games:" <> name, payload, socket) do
    if authorized?(payload) do
      game = Jivifight.GameBackup.load(name) || Game.new()
      socket = socket
      |> assign(:game, game)
      |> assign(:name, name)
      {:ok, %{"join" => name, "game" => Game.client_view(game)}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("flip", %{"pos" => ll}, socket) do
    game = Game.flip(socket.assigns[:game], ll)
    Jivifight.GameBackup.save(socket.assigns[:name], game)
    socket = assign(socket, :game, game)
    {:reply, {:ok, %{ "game" => Game.client_view(game)}}, socket}
  end

  def handle_in("flop", %{"pos" => ll}, socket) do
    game = Game.flop(socket.assigns[:game], ll)
    Jivifight.GameBackup.save(socket.assigns[:name], game)
    socket = assign(socket, :game, game)
    {:reply, {:ok, %{ "game" => Game.client_view(game)}}, socket}
  end

  def handle_in("reset", %{"trigger" => ll}, socket) do
    game = Game.reset(socket.assigns[:game], ll)
    Jivifight.GameBackup.save(socket.assigns[:name], game)
    socket = assign(socket, :game, game)
    {:reply, {:ok, %{ "game" => Game.client_view(game)}}, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
