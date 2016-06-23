module FiasReader
  module Cache
    class Guid
      DASH_STR = '-'.freeze
      EMPTY_STR = ''.freeze
      GUID_PARTS = [
        0..8,
        8..16,
        16..24,
        24..32
      ].freeze

      def initialize(*args)
        if args.size == 1
          guid = args[0]
          case guid
          when Hash
            init_from_hash guid
          when Array
            init_from_array guid
          else
            init_from_guid guid
          end

        elsif args.size == 2
          init_from_hash_slice args[0], args[1]
        elsif args.size > 2
          init_from_array args
        end
      end

      def to_attr(name)
        @parts.each_with_index.each_with_object({}) do |(part, index), result|
          result["#{name}#{index}"] = part
        end
      end

      GUID_FORMAT_STR = '%08x'.freeze
      def to_guid
        @parts.each_with_object('') { |i, str| str << format(GUID_FORMAT_STR, i) }
      end

      def parts
        @parts ||= []
      end

      attr_writer :parts

      def init_from_array(val)
        self.parts = val
      end

      def init_from_guid(guid)
        (self.parts = []) && return unless guid
        guid.tr!(DASH_STR, EMPTY_STR)
        self.parts = GUID_PARTS.map { |range| guid[range].to_i(16) }
      end

      def init_from_hash(hash)
        hash.each { |key, val| parts[key[-1].to_i] = val }
      end

      def init_from_hash_slice(hash, mask)
        self.parts = hash.keys.select { |key| key.to_s =~ /^#{mask}\d/ }.each_with_object([]) do |key, obj|
          obj[key[-1].to_i] = hash[key]
        end
      end
    end
  end
end
