defmodule SoftiWeb.ArticleView do
  use SoftiWeb, :view

  alias SoftiWeb.ArticleView

  def render("index.json", %{articles: articles}) do
    %{data: render_many(articles, ArticleView, "article.json")}
  end

  def render("show.json", %{article: article}) do
    %{data: render_one(article, ArticleView, "article.json")}
  end

  def render("article.json", %{article: article}) do
    %{
      id: article.id,
      title: article.title,
      summary: article.summary,
      keywords: article.keywords,
      author_id: article.author_id,
      event_id: article.event_id
    }
  end
end
