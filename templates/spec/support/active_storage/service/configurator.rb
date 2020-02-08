# frozen_string_literal: true

module ActiveStorage
  class Service::Configurator #:nodoc:
    private

    # This is copied from the ActiveStorage gem
    #
    # Since the MemoryStorage service lives in the spec/support directory,
    # rather than in the load path, requiring it will fail.  No need to do
    # so, since it's loaded automatically with all spec/support files, so
    # we remove the require line for specs.
    def resolve(class_name)
      # require "active_storage/service/#{class_name.to_s.underscore}_service"
      ActiveStorage::Service.const_get(:"#{class_name.camelize}Service")
    rescue LoadError
      raise "Missing service adapter for #{class_name.inspect}"
    end
  end
end

