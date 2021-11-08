defmodule Softi.AuthorFactory do
  defmacro __using__(_opts) do
    quote do
      def author_factory do
        %Softi.Accounts.Author{
          name: sequence("mari"),
          email: sequence("mari@gmail.com"),
          password: "123456"
        }
      end
    end
  end
end
