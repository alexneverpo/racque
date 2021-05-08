# frozen_string_literal: true

module Racque
  VERSION = '0.1.0'

  module Job
    def self.included(base)
      base.extend(ClassMethods)
    end

    def perform(*args); end

    module ClassMethods
      def perform_later(*args)
        WorkerPool.run(class: self, args: args)
      end
    end

  end
end
