require_relative 'lib/scraper'
require_relative 'lib/repository'
require_relative 'lib/mailer'

# bundler setup
require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)


DB_FILE = 'db/flats.db'
RECEIVERS = ['l.delcastillo.97@gmail.com']
TEST_RUN = ARGV[0] == "test"

scraper = Scraper.new(test_run: TEST_RUN)
repository = Repository.new(db_file: DB_FILE)
mailer = Mailer.new(to: RECEIVERS, test_run: TEST_RUN)

puts "Running in test mode" if TEST_RUN
results = scraper.full_site_scrape
new_results = repository.filter_and_save_new_flats(results)

mailer.send_new_flats_mail(new_results)

puts "Success"
