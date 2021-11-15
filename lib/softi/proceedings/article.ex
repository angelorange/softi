defmodule Softi.Proceedings.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field :keywords, {:array, :string}
    field :summary, :string
    field :title, :string
    field :author_id, :id
    field :events_id, :id

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :keywords, :summary])
    |> validate_required([:title, :keywords, :summary])
  end
end
