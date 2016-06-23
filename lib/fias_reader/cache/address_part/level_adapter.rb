module FiasReader
  module Cache
    class AddressPart
      class LevelAdapter
        module AddressObjectLevel
          STREET = '7'.freeze
          SETTLEMENT = '6'.freeze
          CITY_DISTRICT = '5'.freeze
          CITY = '4'.freeze
          STATE_DISTRICT = '3'.freeze
          AUTONOMY = '2'.freeze
          STATE = '1'.freeze
          # 90 – уровень дополнительных территорий
          # 91 – уровень подчиненных дополнительным территориям объектов
        end

        attr_reader :item

        def initialize(item)
          @item = item
        end

        def copy(other)
          @item.shortname_l1 = other.item.shortname_l1
          @item.offname_l1 = other.item.offname_l1
          @item.shortname_l2 = other.item.shortname_l2
          @item.offname_l2 = other.item.offname_l2
          @item.shortname_l3 = other.item.shortname_l3
          @item.offname_l3 = other.item.offname_l3
          @item.shortname_l4 = other.item.shortname_l4
          @item.offname_l4 = other.item.offname_l4
          @item.shortname_l5 = other.item.shortname_l5
          @item.offname_l5 = other.item.offname_l5
          @item.shortname_l6 = other.item.shortname_l6
          @item.offname_l6 = other.item.offname_l6
          @item.shortname_l7 = other.item.shortname_l7
          @item.offname_l7 = other.item.offname_l7
          @item.shortname_l8 = other.item.shortname_l8
          @item.offname_l8 = other.item.offname_l8
          @item.shortname_l9 = other.item.shortname_l9
          @item.offname_l9 = other.item.offname_l9
          @item.shortname_l65 = other.item.shortname_l65
          @item.offname_l65 = other.item.offname_l65
          @item.shortname_l75 = other.item.shortname_l75
          @item.offname_l75 = other.item.offname_l75
          @item.shortname_l90 = other.item.shortname_l90
          @item.offname_l90 = other.item.offname_l90
          @item.shortname_l91 = other.item.shortname_l91
          @item.offname_l91 = other.item.offname_l91
          reset_own
        end

        def reset_own
          case @item[:AOLEVEL]
          when 1
            @item.shortname_l1 = @item[:SHORTNAME]
            @item.offname_l1 = @item[:OFFNAME]
          when 2
            @item.shortname_l2 = @item[:SHORTNAME]
            @item.offname_l2 = @item[:OFFNAME]
          when 3
            @item.shortname_l3 = @item[:SHORTNAME]
            @item.offname_l3 = @item[:OFFNAME]
          when 4
            @item.shortname_l4 = @item[:SHORTNAME]
            @item.offname_l4 = @item[:OFFNAME]
          when 5
            @item.shortname_l5 = @item[:SHORTNAME]
            @item.offname_l5 = @item[:OFFNAME]
          when 6
            @item.shortname_l6 = @item[:SHORTNAME]
            @item.offname_l6 = @item[:OFFNAME]
          when 7
            @item.shortname_l7 = @item[:SHORTNAME]
            @item.offname_l7 = @item[:OFFNAME]
          when 8
            @item.shortname_l8 = @item[:SHORTNAME]
            @item.offname_l8 = @item[:OFFNAME]
          when 9
            @item.shortname_l9 = @item[:SHORTNAME]
            @item.offname_l9 = @item[:OFFNAME]
          when 65
            @item.shortname_l65 = @item[:SHORTNAME]
            @item.offname_l65 = @item[:OFFNAME]
          when 75
            @item.shortname_l75 = @item[:SHORTNAME]
            @item.offname_l75 = @item[:OFFNAME]
          when 90
            @item.shortname_l90 = @item[:SHORTNAME]
            @item.offname_l90 = @item[:OFFNAME]
          when 91
            @item.shortname_l91 = @item[:SHORTNAME]
            @item.offname_l91 = @item[:OFFNAME]
          else
            raise 'errors'
          end
          @item.levels_filled = true
        end

        # Возвращает улицу
        def street
          [@item.shortname_l7, @item.offname_l7]
        end

        # Возвращает деревню, поселок
        def settlement
          [@item.shortname_l6, @item.offname_l6]
        end

        # Возвращает внутригородской территории
        def city_district
          [@item.shortname_l5, @item.offname_l5]
        end

        # Возвращает город
        def city
          [@item.shortname_l4, @item.offname_l4]
        end

        # Возвращает район
        def district
          [@item.shortname_l3, @item.offname_l3]
        end

        # Возвращает автономный округ
        def autonomy
          [@item.shortname_l2, @item.offname_l2]
        end

        # Возвращает область
        def state
          [@item.shortname_l1, @item.offname_l1]
        end
      end
    end
  end
end
