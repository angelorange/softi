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
      expected = params_for(:event)

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
      event = insert(:event)

      updated = params_for(:event, %{
        title: "nada nao fii",
        description: "foifoifoiffoi"
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
end
