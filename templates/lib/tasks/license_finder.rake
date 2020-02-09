# frozen_string_literal: true

desc "Run static license checks"
task license_finder: :environment do
  exit(1) unless system("license_finder")
end

