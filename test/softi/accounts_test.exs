defmodule Softi.AccountsTest do
  use Softi.DataCase

  alias Softi.Accounts

  describe "authors" do
    alias Softi.Accounts.Author

    import Softi.Factory

    test "list_authors/0 returns all authors" do
      author = insert(:author)
      assert [subject] = Accounts.list_authors()
      assert subject.id == author.id
    end

    test "get_author!/1 returns the author with given id" do
      author = insert(:author)
      assert subject = Accounts.get_author!(author.id)
      assert subject.id == author.id
    end

    test "create_author/1 with valid data creates a author" do
      expected = params_for(:author)
      assert {:ok, %Author{} = author} = Accounts.create_author(expected)
      assert author.email == expected.email
      assert author.name == expected.name
      assert author.password == expected.password
    end

    test "create_author/1 with invalid data returns error changeset" do
      params =
        params_for(:author, %{
          email: nil,
          name: nil,
          password: nil
        })

      assert {:error, %Ecto.Changeset{}} = Accounts.create_author(params)
    end

    test "update_author/2 with valid data updates the author" do
      author = insert(:author)

      updated =
        params_for(:author, %{
          name: "shinji",
          email: "shinji@gmail.com",
          password: "chorei123"
        })

      assert {:ok, %Author{} = author} = Accounts.update_author(author, updated)
      assert author.email == updated.email
      assert author.name == updated.name
      assert author.password == updated.password
    end

    test "update_author/2 with invalid data returns error changeset" do
      author = insert(:author)

      params = %{
        name: nil,
        email: nil,
        password: nil
      }

      assert {:error, %Ecto.Changeset{}} = Accounts.update_author(author, params)
      assert author == Accounts.get_author!(author.id)
    end

    test "delete_author/1 deletes the author" do
      author = insert(:author)
      assert {:ok, %Author{}} = Accounts.delete_author(author)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_author!(author.id) end
    end

    test "change_author/1 returns a author changeset" do
      author = insert(:author)
      assert %Ecto.Changeset{} = Accounts.change_author(author)
    end
  end
end
