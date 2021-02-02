require 'pry-nav'
require 'awesome_print'
require_relative 'scraper'
require_relative 'repository'
require_relative 'mailer'

DB_FILE = 'db/flats.db'
RECEIVERS = ['l.delcastillo.97@gmail.com']
TEST_RUN = ARGV[0] == "test"

scraper = Scraper.new(test_run: TEST_RUN)
repository = Repository.new(db_file: DB_FILE)
mailer = Mailer.new(to: RECEIVERS)

puts "Scraping..."
results = scraper.full_site_scrape
puts "Saving to DB..."
new_results = repository.filter_and_save_new_flats(results)

puts "Mailing..."
mailer.send_new_flats_mail(new_results)

puts "Success"
