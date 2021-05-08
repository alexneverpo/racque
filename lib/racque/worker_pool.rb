# frozen_string_literal: true

module Racque
  class WorkerPool
    attr_reader :ractors, :name

    def initialize(name, opt = {})
      @name = name
      pool_size = opt[:size] || ::Etc.nprocessors * 2
      @ractors = pool_size.times.map { spawn_worker }
    end

    def spawn_worker
      Ractor.new do
        Ractor.yield(:ready)
        loop do
          msg = Ractor.receive
          job = msg[:class].new
          Ractor.yield job.perform(msg[:args])
        end
      end
    end

    def self.run(parameters)
      ractor, _ignored_result =
        Ractor.select(*default_pool.ractors)
      ractor << parameters
    end

    def self.default_pool
      @default_pool ||= new('default')
    end
  end
end
