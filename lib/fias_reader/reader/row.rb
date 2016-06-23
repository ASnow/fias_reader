module FiasReader
  class Reader
    # Представление строки итерироемой Reader'ом
    class Row
      def initialize(house_row)
        @house_row = house_row
      end

      # Возвращает объект части адреса к которой прикреплен дом(объект улицы)
      def address_object
        return @address_object unless @address_object.nil?
        @address_object = FiasReader::Cache::AddressPart.first(address_object_id.to_attr(:id)) || false
      end

      def address_object_id
        FiasReader::Cache::Guid.new(@house_row[:AOGUID])
      end

      # Возвращает хеш уровней частей адреса к которой прикреплен дом(объект улицы)
      def levels
        address_object.parent_string
      end

      # Возвращает номер дома
      def house_number
        @house_row[:HOUSENUM]
      end

      # Возвращает номер корпуса
      def house_building_number
        @house_row[:BUILDNUM]
      end

      # Возвращает номер строения
      def house_structure_number
        @house_row[:STRUCNUM]
      end

      # Возвращает улицу
      def street
        levels.street
      end

      # Возвращает почтовый индекс
      def postal_code
        @house_row[:POSTALCODE]
      end

      # Возвращает деревню, поселок
      def settlement
        levels.settlement
      end

      # Возвращает внутригородской территории
      def city_district
        levels.city_district
      end

      # Возвращает город
      def city
        levels.city
      end

      # Возвращает район
      def district
        levels.district
      end

      # Возвращает автономный округ
      def autonomy
        levels.autonomy
      end

      # Возвращает область
      def state
        levels.state
      end
    end
  end
end
