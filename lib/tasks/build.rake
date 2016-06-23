namespace :fias_reader do
  task :build do
    raise "Вы должны указать путь к XML базе ФИАС в переменной окружения DB_PATH" unless ENV[:DB_PATH]
    raise "Не верно указан путь к XML базе ФИАС в переменной окружения DB_PATH" unless File.exist? ENV[:DB_PATH]
    Cache.init FiasReader.open(ENV[:DB_PATH])
  end

  task :clear do
    Cache.clear
  end
end
