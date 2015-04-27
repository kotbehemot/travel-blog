require 'gmail_xoauth'

module SpotDropbox
  class Scanner

    GMAIL_DATE_FORMAT = "%d-%b-%Y"

    def self.process!
      credentials = SpotDropbox::Credentials.new
      puts "Connecting to gmail folder: #{credentials.label}"
      imap = Net::IMAP.new('imap.gmail.com', 993, usessl = true, certs = nil, verify = false)
      imap.authenticate('XOAUTH2', credentials.username, credentials.token)
      imap.select(credentials.label)
      imap.search(['SUBJECT', 'na-pi', "BEFORE", (Date.today - 2.days).strftime(GMAIL_DATE_FORMAT), 'SINCE', (Location.maximum(:emailed_at) + 1.day).strftime(GMAIL_DATE_FORMAT)]).each do |message_id|
        message_body = imap.fetch(message_id, ['BODY[TEXT]', 'INTERNALDATE'])[0]
        puts "Processing email #{message_id}"
        SpotDropbox::EmailProcessor.new(message_body).run
      end
    end
  end
end
