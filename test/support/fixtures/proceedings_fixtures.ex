defmodule Softi.ProceedingsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Softi.Proceedings` context.
  """

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        description: "some description",
        title: "some title"
      })
      |> Softi.Proceedings.create_event()

    event
  end
end
