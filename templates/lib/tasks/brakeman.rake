# frozen_string_literal: true

if Rails.env.development?
  require "brakeman"
  desc "Run static security checks"
  task brakeman: :environment do
    exit(1) unless system("brakeman --no-summary --quiet")
  end
end

