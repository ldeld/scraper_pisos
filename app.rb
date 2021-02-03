require_relative 'config/config'

require_relative 'lib/scraper'
require_relative 'lib/repository'
require_relative 'lib/mailer'

DB_FILE = 'db/flats.db'
RECIPIENTS = ['l.delcastillo.97@gmail.com', 'lamottan@unal.edu.co', 'alejandro.daniel1995@gmail.com']
TEST_RUN = ARGV[0] == "test"

scraper = Scraper.new(test_run: TEST_RUN)
repository = Repository.new(db_file: DB_FILE)
mailer = Mailer.new(recipients: RECIPIENTS, test_run: TEST_RUN)

puts "Running in test mode" if TEST_RUN
results = scraper.full_site_scrape
new_results = repository.filter_and_save_new_flats(results)

mailer.send_new_flats_mail(new_results)

puts "Success"
