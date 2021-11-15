defmodule Softi.Factory do
  use ExMachina.Ecto, repo: Softi.Repo

  use Softi.EventsFactory
  use Softi.AuthorFactory
  use Softi.ArticleFactory
end
