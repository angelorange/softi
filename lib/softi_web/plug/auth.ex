defmodule SoftiWeb.AuthPlug do
  use Guardian.Plug.Pipeline,
    otp_app: :softi,
    error_handler: SoftiWeb.ErrorHandler,
    module: Softi.Guardian

  plug Guardian.Plug.VerifyHeader, scheme: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, allow_blank: true
end
