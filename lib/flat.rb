class Flat
  attr_reader :title, :link, :price, :rooms

  def initialize(attrs = {})
    @title = attrs[:title]
    @link = attrs[:link]
    @price = attrs[:price]
    @rooms = attrs[:rooms]
  end

  def to_s
    "#{@price} € | #{@rooms} habs - #{@title}"
  end
end
