require 'open-uri'
require_relative 'flat_extractor'
module Scrape
  class Scraper
    SITE_URL = "https://www.habitaclia.com/alquiler-viviendas-particulares-distrito_ciutat_vella-barcelona-{NUM}.htm"
    MIN_ROOMS = 2
    MAX_PRICE = 1100

   

    def full_site_scrape
      limit = $TEST_RUN ? 1 : 5
      results = []
      (1..limit).each do |num|
        results += page_scrape(num)
      end
      results
    end

    private

    def page_scrape(num)
      url = site_url_for_page(num)
      file = $TEST_RUN ? open(File.join(__dir__, '../../', 'spec/habitaclia.htm')) : URI.open(url)
      doc = Nokogiri::HTML(file)
      FlatExtractor.new(doc).extract_flats
    end

    def site_url_for_page(page_number)
      SITE_URL.sub('{NUM}', page_number.to_s)
    end
  end
end
