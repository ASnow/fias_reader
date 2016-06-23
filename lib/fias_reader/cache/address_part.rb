module FiasReader
  module Cache
    class AddressPart
      include DataMapper::Resource
      ZERO_STR = '0'.freeze

      # property :AOGUID, String
      property :id0,     Integer, key: true
      property :id1,     Integer, key: true
      property :id2,     Integer, key: true
      property :id3,     Integer, key: true
      property :SHORTNAME, String, length: 10
      property :OFFNAME, String, length: 120
      property :levels_filled, Boolean
      property :shortname_l1, String, length: 10
      property :offname_l1, String, length: 120
      property :shortname_l2, String, length: 10
      property :offname_l2, String, length: 120
      property :shortname_l3, String, length: 10
      property :offname_l3, String, length: 120
      property :shortname_l4, String, length: 10
      property :offname_l4, String, length: 120
      property :shortname_l5, String, length: 10
      property :offname_l5, String, length: 120
      property :shortname_l6, String, length: 10
      property :offname_l6, String, length: 120
      property :shortname_l7, String, length: 10
      property :offname_l7, String, length: 120
      property :shortname_l8, String, length: 10
      property :offname_l8, String, length: 120
      property :shortname_l9, String, length: 10
      property :offname_l9, String, length: 120
      property :shortname_l65, String, length: 10
      property :offname_l65, String, length: 120
      property :shortname_l75, String, length: 10
      property :offname_l75, String, length: 120
      property :shortname_l90, String, length: 10
      property :offname_l90, String, length: 120
      property :shortname_l91, String, length: 10
      property :offname_l91, String, length: 120
      property :AOLEVEL, Integer
      # property :PARENTGUID, String
      property :parent0,     Integer
      property :parent1,     Integer
      property :parent2,     Integer
      property :parent3,     Integer

      require 'ruby-prof'

      def self.index(reader)
        attrs = properties.map(&:name)
        FiasReader::Table::AddressPart.new(reader).query.all do |row|
          next if row[:LIVESTATUS] == ZERO_STR
          begin
            params = FiasReader::Cache::Guid.new(row[:AOGUID]).to_attr(:id)
            params.merge! FiasReader::Cache::Guid.new(row[:PARENTGUID]).to_attr(:parent)
            params[:SHORTNAME] = row[:SHORTNAME]
            params[:OFFNAME] = row[:OFFNAME]
            params[:AOLEVEL] = row[:AOLEVEL]
            create params
          rescue DataObjects::IntegrityError => e
          end
        end
      end

      def self.index_levels
        puts "Части 4..."
        index_levels_batch '4'
        puts "Части 6..."
        index_levels_batch '6'
        puts "Части 7..."
        index_levels_batch '7'
      end

      def self.index_levels_batch(level)
        start = -1
        i = 0

        while start != i
          start = i
          all(offset: i, limit: 1000, AOLEVEL: level).each do |item|
            i += 1
            puts Time.new if (i % 10_000).zero?
            item.parent_string
          end
        end
      end

      def levels
        @levels ||= FiasReader::Cache::AddressPart::LevelAdapter.new(self)
      end

      def parent_string
        return levels if levels_filled

        if parent0.nil?
          levels.reset_own
        else
          # some bug with parent DataObjects::SyntaxError, so using first
          parent_item = FiasReader::Cache::AddressPart.first(id0: parent0, id1: parent1, id2: parent2, id3: parent3)

          if parent_item
            levels.copy(parent_item.parent_string)
          else
            levels.reset_own
          end
          save
        end

        levels
      end

      belongs_to :parent, 'AddressPart',
                 parent_key: [:id0, :id1, :id2, :id3],
                 child_key: [:parent0, :parent1, :parent2, :parent3]
    end
  end
end
