# frozen_string_literal: true

require 'zeitwerk'

loader = Zeitwerk::Loader.for_gem
loader.setup # ready!

module Racque
  # Your code goes here...
  def self.hello
    puts 'Hello!'
  end
end
