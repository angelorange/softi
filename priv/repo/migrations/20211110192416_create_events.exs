defmodule Softi.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :title, :string
      add :description, :string

      add(:author_id, references(:authors), on_delete: :delete_all)

      timestamps()
    end
  end
end
