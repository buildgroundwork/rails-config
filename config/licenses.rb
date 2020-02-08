# frozen_string_literal: true

module Config
  class Licenses
    class << self
      def acceptable
        [
          'MIT', 'Apache 2.0', 'ruby', 'ISC', 'Simplified BSD', 'New BSD',
          'CC0-1.0', 'WTFPL', 'Unlicense'
        ].freeze
      end

      def special_cases
        {
          amdefine: 'Dual license; using MIT',
          'async-foreach': 'Uses MIT; license file differs from norm in whitespace only',
          atob: 'Dual license; using MIT',
          'json-schema': 'Dual license; using BSD-3-Clause',
          'node-forge': 'Dual license; using BSD-3-Clause',
          pako: 'Dual license; using MIT',
          'path-is-inside': 'Dual license; using MIT',
          'sha.js': 'Dual license; using MIT'
        }
      end
    end
  end
end

