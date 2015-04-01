require "fileutils"
require "rack/file_watcher/version"

module Rack
  class FileWatcher
    def initialize(app, file_path, &block)
      @app = app
      @file_path = file_path
      @block = block

      initialize_target_file

      @last_update_at = updated_at
    end

    def execute_if_updated
      current_updated_at = updated_at

      if @last_update_at != current_updated_at
        @block.call
        @last_update_at = current_updated_at
      end
    end

    def call(env)
      execute_if_updated

      @app.call(env)
    end

    private

    def initialize_target_file
      FileUtils.touch(@file_path)
    end

    def updated_at
      ::File.mtime(@file_path)
    end
  end
end
