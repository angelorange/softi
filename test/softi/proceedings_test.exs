defmodule Softi.ProceedingsTest do
  use Softi.DataCase

  alias Softi.Proceedings

  import Softi.Factory

  describe "events" do
    alias Softi.Proceedings.Event

    @invalid_attrs %{description: nil, title: nil}

    test "list_events/0 returns all events" do
      event = insert(:event)
      assert [subject] = Proceedings.list_events()
      assert subject.id == event.id
    end

    test "get_event!/1 returns the event with given id" do
      event = insert(:event)
      assert subject = Proceedings.get_event!(event.id)
      assert subject.id == event.id
    end

    test "create_event/1 with valid data creates a event" do
      author = insert(:author)
      expected = params_for(:event, author: author)

      assert {:ok, %Event{} = event} = Proceedings.create_event(expected)
      assert event.description == expected.description
      assert event.title == expected.title
    end

    test "create_event/1 with invalid data returns error changeset" do
      params = params_for(:event, %{
        title: nil,
        description: nil
      })
      assert {:error, %Ecto.Changeset{}} = Proceedings.create_event(params)
    end

    test "update_event/2 with valid data updates the event" do
      author = insert(:author)
      event = insert(:event)

      updated = params_for(:event, %{
        title: "nada nao fii",
        description: "foifoifoiffoi",
        author_id: author.id
      })

      assert {:ok, %Event{} = event} = Proceedings.update_event(event, updated)
      assert event.description == updated.description
      assert event.title == updated.title
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = insert(:event)

      params = %{
        title: nil,
        description: nil
      }
      assert {:error, %Ecto.Changeset{}} = Proceedings.update_event(event, params)
      assert event == Proceedings.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = insert(:event)
      assert {:ok, %Event{}} = Proceedings.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Proceedings.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = insert(:event)
      assert %Ecto.Changeset{} = Proceedings.change_event(event)
    end
  end

  describe "articles" do
    alias Softi.Proceedings.Article

    import Softi.Factory

    @invalid_attrs %{keywords: nil, summary: nil, title: nil}

    test "list_articles/0 returns all articles" do
      article = insert(:article)
      assert [subject] = Proceedings.list_articles()
      assert subject.id == article.id
    end

    test "get_article!/1 returns the article with given id" do
      article = insert(:article)
      assert subject = Proceedings.get_article!(article.id)
      assert subject.id == article.id
    end

    test "create_article/1 with valid data creates a article" do
      author = insert(:author)
      event = insert(:event, author_id: author.id)
      expected = params_for(:article, event_id: event.id, author_id: author.id)


      assert {:ok, %Article{} = article} = Proceedings.create_article(expected)
      assert article.keywords == expected.keywords
      assert article.summary == expected.summary
      assert article.title == expected.title
    end

    test "create_article/1 with invalid data returns error changeset" do
      params = params_for(:article, %{
        title: nil,
        summary: nil,
        keywords: nil
      })
      assert {:error, %Ecto.Changeset{}} = Proceedings.create_article(@invalid_attrs)
    end

    test "update_article/2 with valid data updates the article" do
      author = insert(:author)
      event = insert(:event, author_id: author.id)
      article = insert(:article, event_id: event.id, author_id: author.id)
      expected = %{keywords: ["doce, travessuras"], summary: "something about halloween", title: "halloween"}

      assert {:ok, %Article{} = article} = Proceedings.update_article(article, expected)
      assert article.keywords == expected.keywords
      assert article.summary == expected.summary
      assert article.title == expected.title
    end

    test "update_article/2 with invalid data returns error changeset" do
      article = insert(:article)

      params = %{
        title: nil,
        summary: nil,
        keywords: nil
      }
      assert {:error, %Ecto.Changeset{}} = Proceedings.update_article(article, params)
      assert article == Proceedings.get_article!(article.id)
    end

    test "delete_article/1 deletes the article" do
      article = insert(:article)
      assert {:ok, %Article{}} = Proceedings.delete_article(article)
      assert_raise Ecto.NoResultsError, fn -> Proceedings.get_article!(article.id) end
    end

    test "change_article/1 returns a article changeset" do
      article = insert(:article)
      assert %Ecto.Changeset{} = Proceedings.change_article(article)
    end
  end
end
