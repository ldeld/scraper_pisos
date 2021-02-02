class Mailer
  def initialize(attrs = {})
    @to = attrs[:to]
  end

  def send_new_flats_mail(flats)
    # TODO
    puts "Simulating mailing..."
  end
end
