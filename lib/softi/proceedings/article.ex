defmodule Softi.Proceedings.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field :keywords, {:array, :string}
    field :summary, :string
    field :title, :string

    belongs_to :author, Softi.Accounts.Author
    belongs_to :event, Softi.Proceedings.Event

    timestamps()
  end

  @required ~w(title summary author_id keywords event_id)a

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, @required)
    |> validate_required(@required)
  end
end
