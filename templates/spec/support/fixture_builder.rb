# frozen_string_literal: true

fixture_paths = Module.new do
  class << self
    def ordered
      ordered_tables.collect { |table| path_for(table) }
    end

    def unordered
      Dir.glob(path_for("*")) - ordered
    end

    private

    # Add names of tables for which order matters
    #
    # e.g. An Employee must belong to an Organizations, so Organization
    # fixtures must be created before Employees.
    #
    # %w(organizations employees)
    def ordered_tables
      %w()
    end

    def path_for(file)
      Rails.root.join("spec", "fixtures", "#{file}.rb").to_s
    end
  end
end

# Make sure all test doubles are in place for the fixture build.
Dir[Rails.root.join("spec", "support", "**", "*.rb")].sort.each { |f| require f }

FixtureBuilder.configure do |builder|
  # rebuild fixtures automatically when these files change:
  builder.files_to_check += Dir["spec/support/fixture_builder.rb", "db/structure.sql", "spec/fixtures/*.rb"]

  builder.factory do
    fixture_paths.ordered.each do |path|
      File.open(path) { |file| instance_eval(file.read) }
    end

    fixture_paths.unordered.each do |path|
      File.open(path) { |file| instance_eval(file.read) }
    end
  end
end

