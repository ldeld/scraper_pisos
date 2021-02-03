class Repository
  def initialize(attrs = {})
    @db_file = attrs[:db_file]
    @db = SQLite3::Database.new(@db_file)
    @db.results_as_hash = true
  end

  def filter_and_save_new_flats(flats)
    new_flats = flats.reject { |flat| flat_exists?(flat) }
    return [] if new_flats.empty?

    save_flats(new_flats)
    new_flats
  end

  private

  def save_flats(new_flats)
    query = <<-SQL
      INSERT INTO flats (title, link, price, rooms) VALUES
    SQL
    values_query = new_flats.map { |flat| flat_to_value_string(flat) }.join(', ')
    @db.execute(query + values_query)
  end

  def flat_to_value_string(flat)
    "('#{flat.title}', '#{flat.link}', #{flat.price}, #{flat.rooms})"
  end

  def flat_exists?(flat)
    @db.execute("SELECT 1 FROM flats WHERE title = ?", flat.title).any?
  end
end
