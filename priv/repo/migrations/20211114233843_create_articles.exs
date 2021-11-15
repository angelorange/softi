defmodule Softi.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title, :string
      add :keywords, {:array, :string}
      add :summary, :string
      add :author_id, references(:authors, on_delete: :nothing)
      add :events_id, references(:events, on_delete: :nothing)

      timestamps()
    end

    create index(:articles, [:author_id])
    create index(:articles, [:events_id])
  end
end
