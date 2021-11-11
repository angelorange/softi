defmodule Softi.EventsFactory do
  defmacro __using__(_opts) do
    quote do
      def event_factory do
        %Softi.Proceedings.Event{
          title: "How I became rich with pyramid scheme",
          description: "pero pero pero pero pero pero pero",
        }
      end
    end
  end
end
