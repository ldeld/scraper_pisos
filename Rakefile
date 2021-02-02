require 'sqlite3'

task :test do
  puts "TODO: write spec!!!"
end

task :reset_db do
  db_file = 'db/flats.db'
  db = SQLite3::Database.new(db_file)
  db.execute('DROP TABLE IF EXISTS `flats`;')
  create_statement = "
  CREATE TABLE `flats` (
    `id`  INTEGER PRIMARY KEY AUTOINCREMENT,
    `title` TEXT,
    `link` TEXT,
    `price`  INTEGER,
    `rooms` INTEGER
  );"
  db.execute(create_statement)

  puts "Database was reset"
end
