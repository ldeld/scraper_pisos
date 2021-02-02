class Mailer
  def initialize(attrs = {})
    @to = attrs[:to]
    @test_run = attrs[:test_run]
  end

  def send_new_flats_mail(flats)
    body = generate_mail_body(flats)
    @test_run ? puts(body) : send_mail(body)
  end

  private

  def send_mail(body)
    puts "Sending mail"
  end

  def generate_mail_body(flats)
    return "No hay apartamentos nuevos" if flats.empty?

    str = "Hay #{flats.length} apartamentos nuevos:\n"

    flat_links = flats.map.with_index do |flat, i|
      "#{i + 1} - <a href='#{flat.link}'>#{flat}</a>"
    end

    str + flat_links.join("\n")
  end
end
