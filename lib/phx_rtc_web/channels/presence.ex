defmodule PhxRtcWeb.Presence do
  use Phoenix.Presence, otp_app: :phx_rtc,
                        pubsub_server: PhxRtc.PubSub
end
