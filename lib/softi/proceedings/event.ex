defmodule Softi.Proceedings.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :description, :string
    field :title, :string

    belongs_to :author, Softi.Accounts.Author

    timestamps()
  end

  @required ~w(title description author_id)a

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, @required)
    |> validate_required(@required)
  end
end
