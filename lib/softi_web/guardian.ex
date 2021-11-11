defmodule Softi.Guardian do
  use Guardian, otp_app: :softi

  alias Softi.Accounts.Author

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

  @doc """
  Returns the author based on the connection gave
  """
  @spec get_author(%Plug.Conn{}) :: %Author{}
  def get_author(conn) do
    token = Softi.Guardian.Plug.current_token(conn)
    {:ok, author, _claims} = Softi.Guardian.resource_from_token(token)

    author
  end
end
