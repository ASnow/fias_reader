$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'fias_reader'

Dir['./spec/support/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.include TestFiles
end
