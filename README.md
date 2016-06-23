# FiasReader

Библиотека для работы с XML базой ФИАС. Библиотека позволяет провести обход по всем активным записям домов.  

## Installation

Добваить строку в Gemfile:

```ruby
gem 'fias_reader', path: '/path_to_dir/fias_reader'
```

И выполнить после:

```
  $ bundle
```

## Usage

Перед запуском лучше исполнить rake для построения индекса:

```
rake fias_reader:build DB_PATH=/path/to/dir
```

если запускать без него то индекс построится в процессе выполнения.

Для просотого обхода по всем записям домов нужно вызвать итератор следующим способом:

``` ruby
FiasReader.open('/path/to/unpacked/fais/xml/dir/').each do |row|
  # somecode here
end
```

Итератор передает аргумент типа `FiasReader::Reader::Row`, который имеет методы:
* `postal_code` - почтовый индекс
* `house_number` - номер дома
* `house_building_number` - номер корпуса, опционально
* `house_structure_number` - номер строения, опционально
* `levels` - хеш всех уровни частей адреса
* Части адреса возращаются либо масивом из двух объектов(сокращенное название типа части адреса, название части адреса). В случае если часть адреса не указана возвращаем nil.
  * `street` - улица
  * `settlement` - населенный пункт
  * `city_district` - внутригородская территория
  * `city` - город
  * `district` - район
  * `autonomy` - автономный округ
  * `state` - регион


После выполнения работы нужно удалить индекс:

```
rake fias_reader:clear
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing
