# frozen_string_literal: true

task license_finder: :environment do
  exit(1) unless system("license_finder")
end

