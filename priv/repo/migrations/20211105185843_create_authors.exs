defmodule Softi.Repo.Migrations.CreateAuthors do
  use Ecto.Migration

  def change do
    create table(:authors) do
      add :name, :string
      add :email, :string
      add :password, :string

      timestamps()
    end
  end
end
