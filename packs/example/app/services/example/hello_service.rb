# frozen_string_literal: true

module Example
  class HelloService
    class << self
      def call(name: "world")
        new(name: name).call
      end
    end

    def initialize(name:)
      @name = name
    end

    def call
      "Hello, #{@name}!"
    end
  end
end
