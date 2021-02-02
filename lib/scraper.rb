require 'open-uri'
require_relative 'flat'

SITE_URL = "https://www.habitaclia.com/alquiler-viviendas-particulares-distrito_ciutat_vella-barcelona-{NUM}.htm"

class Scraper
  def initialize(attrs = {})
    @test_run = attrs[:test_run]
    @file_to_use = @test_run ? 'spec/habitaclia.html' : SITE_URL
  end

  def full_site_scrape
    limit = @test_run ? 1 : 8
    results = []
    (1..limit).each do |num|
      results += page_scrape(num)
    end
    results
  end

  private

  def page_scrape(num)
    # TODO: Refacto
    url = site_url_for_page(num)
    file = open(url)
    doc = Nokogiri::HTML(file)
    results = doc.search('article.gtmproductclick').map do |elem|
      info_string = elem.search('.list-item-feature').text
      rooms = info_string_to_num(info_string)
      price_string = elem.search('.list-item-price').text
      price = price_string_to_num(price_string)
      next if rooms < 3 || price > 1000

      link_element = elem.search('.list-item-title a')
      link = link_element.attr('href').value
      title = link_element.text.gsub('Alquiler', '')
      Flat.new(title: title, link: link, price: price, rooms: rooms)
    end

    results.compact
  end

  def price_string_to_num(string)
    string.split('€').first.gsub(/[^\d]/, '').to_i
  end

  def info_string_to_num(info_string)
    info_string.match(/(\d) habitaci/)[1].to_i
  end

  def site_url_for_page(page_number)
    SITE_URL.sub('{NUM}', page_number.to_s)
  end
end
