defmodule PhxRtcWeb.RoomChannel do
  use PhxRtcWeb, :channel
  alias PhxRtcWeb.Presence

  def join("foo", _, socket) do
    {:ok, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  def handle_in("create or join", %{"user_id" => id}, socket) do
    IO.inspect "Received request to create or join room " <> socket.topic

    case Presence.list(socket) |> Enum.count do
      0 ->
        {:ok, _} = track_browser(socket, id)
        log(socket, "Client ID " <> id <> " created room " <> socket.topic);
        push(socket, "created", %{})
      1 ->
        push(socket, "join", %{})
        {:ok, _} = track_browser(socket, id)
        log(socket, "Client ID " <> id <> " joined room " <> socket.topic);
        push(socket, "joined", %{})
      _num ->
        push(socket, "full", %{message: socket.topic})
    end
    require IEx; IEx.pry


    {:noreply, socket}
  end

  def handle_in("message", payload, socket) do
    log(socket, "Client said: " <> payload)

    broadcast(socket, "message", %{message: payload})

    {:noreply, socket}
  end

  def handle_in("ipaddr", _, socket) do
    {:noreply, socket}
  end

  def handle_in("bye", _, socket) do
    IO.inspect "got bye"
    {:noreply, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (room:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  def handle_in(event, payload, socket) do
    IO.inspect({event, payload}, label: "event + payload")
    {:noreply, socket}
  end

  defp track_browser(socket, id) do
Presence.track(socket, id, %{
      online_at: inspect(System.system_time(:seconds))
    })
  end

  defp log(socket, something) do
    message = "Message from server: " <> inspect(something)
    push(socket, "log", %{ message: message })
  end
end
