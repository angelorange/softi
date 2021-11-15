defmodule Softi.ArticleFactory do
  defmacro __using__(_opts) do
    quote do
      def article_factory do
        %Softi.Proceedings.Article{
          title: "Chess and things",
          summary: "this is about chess",
          keywords: ["chess", "game"]
        }
      end
    end
  end
end
