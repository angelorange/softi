defmodule Softi.Factory do
  use ExMachina.Ecto, repo: Softi.Repo

  use Softi.AuthorFactory
end
