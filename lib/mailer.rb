class Mailer
  FROM_ADDRESS = 'l.delcastillo.97@gmail.com'
  def initialize(attrs = {})
    @test_run = attrs[:test_run]
    # Send to self if test run
    @recipients = @test_run ? FROM_ADDRESS : attrs[:recipients]
  end

  def send_new_flats_mail(flats)
    return if flats.empty?

    body = generate_mail_body(flats)
    send_mail(body)
  end

  private

  def send_mail(mail_body)
    mail = Mail.new
    mail.from    = FROM_ADDRESS
    mail.to      = @recipients
    mail.subject = 'Nuevos apartamentos!'
    mail.html_part do
      content_type 'text/html; charset=UTF-8'
      body mail_body
    end
    mail.deliver!
  end

  def generate_mail_body(flats)
    str = "Hay #{flats.length} apartamentos nuevos:<br>"

    flat_links = flats.map.with_index do |flat, i|
      "#{i + 1} - <a href='#{flat.link}'>#{flat}</a>"
    end

    str + flat_links.join("<br>")
  end
end
