defmodule Softi.Guardian do
  use Guardian, otp_app: :softi

  @impl true
  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  @impl true
  def resource_from_claims(%{"sub" => id}) do
    resource = Softi.Accounts.get_author!(id)
    {:ok, resource}
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end
end
