require_relative '../flat'

module Scrape
  class FlatExtractor
    def initialize(html_doc)
      @doc = html_doc
    end

    def extract_flats
      @doc.search('article.gtmproductclick').map do |elem|
        extract_flat(elem)
      end.compact
    end
    
    private
    
    def extract_flat(flat_html)
      attrs = flat_attributes(flat_html)
      return if attrs[:rooms] < Scraper::MIN_ROOMS || attrs[:price] >= Scraper::MAX_PRICE
      Flat.new(attrs)
    end
    
    def flat_attributes(flat_html)
      {
        rooms: rooms_attr(flat_html),
        price: price_attr(flat_html),
        link: link_attr(flat_html),
        title: title_attr(flat_html),
      }
    end

    def title_link_element(flat_html)
      flat_html.search('.list-item-title a')
    end
    
    def rooms_attr(flat_html)
      info_string = flat_html.search('.list-item-feature').text
      info_string.match(/(\d) habitaci/)[1].to_i

    end

    def link_attr(flat_html)
      title_link_element(flat_html).attr('href').value
    end

    def price_attr(flat_html)
      price_string = flat_html.search('.list-item-price').text
      price_string.split('€').first.gsub(/[^\d]/, '').to_i
    end

    def title_attr(flat_html)
      title_link_element(flat_html).inner_text
    end
  end

end
