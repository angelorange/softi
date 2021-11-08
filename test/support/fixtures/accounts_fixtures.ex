defmodule Softi.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Softi.Accounts` context.
  """

  @doc """
  Generate a author.
  """
  def author_fixture(attrs \\ %{}) do
    {:ok, author} =
      attrs
      |> Enum.into(%{
        email: "some email",
        name: "some name",
        password: "some password"
      })
      |> Softi.Accounts.create_author()

    author
  end
end
