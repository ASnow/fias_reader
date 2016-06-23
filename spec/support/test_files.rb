module TestFiles
  DB_PATH = File.expand_path('../../db/fias_xml/', __FILE__)

  def db_path
    DB_PATH
  end

  def db_file(file)
    Dir["#{DB_PATH}/#{file}_*.XML"].first
  end
end
