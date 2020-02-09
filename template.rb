# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength
class << self
  def execute
    ask_for_versions

    generate_clean_gemfile
    generate_clean_database_yml

    add_rubocop_files
    add_rake_files
    add_fixture_builder
    add_license_finder_decisions

    after_bundle do
      generate_clean_rspec_files
      fix_rubocop_issues
      run_rake

      singleton_class.remove_method(:source_paths)
    end
  end

  def source_paths
    [File.join(File.dirname(__FILE__), "templates")]
  end

  private

  def ruby_version
    @ruby_version ||= RUBY_VERSION
  end

  def rails_version
    @rails_version ||= Rails.gem_version
  end

  def ask_for_versions
    @ruby_version = ask("Ruby version? (default #{ruby_version})").presence
    @rails_version = ask("Rails version? (default #{rails_version})").presence
  end

  def generate_clean_gemfile
    remove_file("Gemfile", verbose: false)
    template("Gemfile", ruby_version: ruby_version, rails_version: rails_version)
  end

  def generate_clean_database_yml
    remove_file("config/database.yml", verbose: false)
    template("config/database.yml")
  end

  def add_rubocop_files
    copy_file(".rubocop.yml")
  end

  def add_rake_files
    copy_file("lib/tasks/brakeman.rake")
    copy_file("lib/tasks/rubocop.rake")
    copy_file("lib/tasks/license_finder.rake")

    copy_file("lib/tasks/default.rake")
  end

  def add_fixture_builder
    copy_file("spec/support/fixture_builder.rb")
  end

  def add_license_finder_decisions
    copy_file("doc/dependency_decisions.yml")
  end

  def generate_clean_rspec_files
    generate("rspec:install")

    remove_file("spec/spec_helper.rb", verbose: false)
    copy_file("spec/spec_helper.rb")

    remove_file("spec/rails_helper.rb", verbose: false)
    copy_file("spec/rails_helper.rb")
  end

  def fix_rubocop_issues
    run("bundle exec rubocop --auto-correct --out /dev/null")
  end

  def run_rake
    rails_command("default", abort_on_failure: true, verbose: true)
  end
end
# rubocop:enable Metrics/MethodLength

execute

