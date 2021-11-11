defmodule SoftiWeb.AuthorView do
  use SoftiWeb, :view
  alias SoftiWeb.AuthorView

  def render("index.json", %{authors: authors}) do
    %{data: render_many(authors, AuthorView, "author.json")}
  end

  def render("show.json", %{author: author}) do
    %{data: render_one(author, AuthorView, "author.json")}
  end

  def render("author.json", %{author: author}) do
    %{
      id: author.id,
      name: author.name,
      email: author.email,
      password: author.password
    }
  end
end
